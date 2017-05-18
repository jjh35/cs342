import oracle.kv.*;

import java.sql.*;
import java.util.*;

/***
	*
	 *	Key structure for each table:
	 *	The teamsNames table
	 *   \teamNames\-teamName\teamName\player1Name
     *   	\teamNames\-\teamID\teamName\player2Name
     *       ...
     *       \teamNames\-\teamID\teamName\player11Name
	 *	Player score table
	 *   \playerScore\-\week\playerID\score
     *   	\playerScore\-\week\playerID\played
     *  	\playerScore\-\week\playerID\goals
     *   	etc
	 *	Player table
	 *	\player\ID\-\name
     *  	\player\ID\-\proTeam
     *  	\player\ID\-\position
     *  	etc
	 *
	 *This Class implements methods that pull relations from a relational DB and translates them to a key-value kvlite database.
	 *
     */
public class LoadDB {

    public LoadDB()
    {

    }

    /** Key structure plan: 2 tables, Player_score and Player, 3 Key structures
     * key structure:   \teamNames\-teamName\teamName\player1Name
     *                  \teamNames\-\teamID\teamName\player2Name
     *                  ...
     *                  \teamNames\-\teamID\teamName\player11Name
     */
    /**
	 * get the names of players on a given team, and get the name of the team.
	 * throws an SQL Exception if there is an issue with pull the info from the SQL DB
	*/
    public void loadTeamPlayers() throws SQLException
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "system", "MonkeyHat8");
        Statement jdbcStatement = jdbcConnection.createStatement();

        /**
         * NOTE! I tried to do a nested resultSet loop, but it did not work for a reason that
         * I cannot figure out. So I just put the values into two arrayLists and broke the loops apart
         */
        ResultSet resultSet1 = jdbcStatement.executeQuery("SELECT ID, name from user_Team");
        ArrayList<Integer> teamIDs = new ArrayList<Integer>();
        ArrayList<String> teamNames = new ArrayList<String>();
        while (resultSet1.next())
        {
            teamIDs.add(resultSet1.getInt(1));
            teamNames.add(resultSet1.getString(2));
        }
        resultSet1.close();

        for(int j = 0; j<teamIDs.size(); j++)
        {
            String teamID = Integer.toString(teamIDs.get(j));
            String teamName = teamNames.get(j);
            ResultSet resultSet2 = jdbcStatement.executeQuery("select player_id from team_player where team_id =" + teamID);
            //System.out.println("team: " + teamName);
            int i = 0;
            while(resultSet2.next())
            {

                String player_id = Integer.toString(resultSet2.getInt(1));
                Key playerKeyName = Key.createKey(Arrays.asList("player", player_id ), Arrays.asList("name"));
                String playerName = new String(store.get(playerKeyName).getValue().getValue());
                //System.out.println("\t"+playerName);

                Key key1 = Key.createKey(Arrays.asList("teamNames"),  Arrays.asList(teamID, teamName, "player" + i + "name"));
                //System.out.println(key1.toString());
                Value v = Value.createValue(playerName.getBytes());
                store.put(key1, v);
                i++;
            }
            resultSet2.close();
        }


        jdbcStatement.close();
        jdbcConnection.close();
        store.close();
    }

    /**
     * returns the names of the players on a team (and the team name)
     * @param teamID: the numeric id of the team (as a string)
     */
    public void getTeamNames(String teamID)
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        Key majorKeyPath = Key.createKey(Arrays.asList("teamNames"), Arrays.asList(teamID));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPath, null, null);
        int i = 0;
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(2);
            String fieldValue = new String(field.getValue().getValue().getValue());
            //System.out.println(field.getKey().toString());
            String teamName = field.getKey().getMinorPath().get(1);
            if(i == 0)
                System.out.println(teamName);
            System.out.println("\t"+ fieldValue);
            i++;
        }
        store.close();
    }

    /**
     * key structure
     *  /playerScore/-/week/playerID/score
     *  /playerScore/-/week/playerID/played
     *  /playerScore/-/week/playerID/goals
     *  etc
     *
     *  loads the playerScores into the key-value DB from the relational database
     * @throws SQLException
     */
    public void loadPlayerScores() throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "system", "MonkeyHat8");
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT player_ID, week, score, played, goals, assists, clean_sheet FROM Player_Score");

        //Major key structure:  /playerScore/player_ID/week/-/week/-/score/-/played/-/goals/-/assists/-/clean_sheet
        while (resultSet.next())
        {
            String playerID = Integer.toString(resultSet.getInt(1));
            String week = Integer.toString(resultSet.getInt(2));
            String score = Integer.toString(resultSet.getInt(3));
            String played = Integer.toString(resultSet.getInt(4));
            String goals = Integer.toString(resultSet.getInt(5));
            String assists = Integer.toString(resultSet.getInt(6));
            String clean_sheet = Integer.toString(resultSet.getInt(7));


            Key key1 = Key.createKey(Arrays.asList("playerScore"), Arrays.asList(week, playerID,"score"));
            Key key2 = Key.createKey(Arrays.asList("playerScore"), Arrays.asList(week, playerID, "played"));
            Key key3 = Key.createKey(Arrays.asList("playerScore"), Arrays.asList(week, playerID,"goals"));
            Key key4 = Key.createKey(Arrays.asList("playerScore"), Arrays.asList(week, playerID,"assists"));
            Key key5 = Key.createKey(Arrays.asList("playerScore"), Arrays.asList(week, playerID,"clean_sheet"));

            Value v1 = Value.createValue(score.getBytes());
            Value v2 = Value.createValue(played.getBytes());
            Value v3 = Value.createValue(goals.getBytes());
            Value v4 = Value.createValue(assists.getBytes());
            Value v5 = Value.createValue(clean_sheet.getBytes());


            store.put(key1, v1);
            store.put(key2, v2);
            store.put(key3, v3);
            store.put(key4, v4);
            store.put(key5, v5);
        }


        resultSet.close();
        jdbcStatement.close();
        jdbcConnection.close();
        store.close();
    }

    /**
     * returns the a player's score for a given week
     * @param playerID
     * @param week
     */
    public void getPlayerScore(String playerID, String week)
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        Key majorKeyPath = Key.createKey(Arrays.asList("playerScore"), Arrays.asList(week, playerID));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPath, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(2);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" +fieldName + " " + fieldValue);

        }
        store.close();
    }

    /**
     * sorts the all the players' scores for a given week
     * @param week
     */
    public void getSortedPlayerScores(String week)
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        Key playersScoresKey = Key.createKey(Arrays.asList("playerScore"));
        Map<Key, ValueVersion> values = store.multiGet(playersScoresKey, null, null);
        System.out.println(playersScoresKey.toString());
        System.out.println(values.size());
        List<Integer> scores = new ArrayList<>();
        HashMap<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();

        for (Map.Entry<Key, ValueVersion> field : values.entrySet()) {

            String minorKeyString = field.getKey().getMinorPath().get(2);
            if(!minorKeyString.equals("score"))
                continue;
            if(!field.getKey().getMinorPath().get(0).equals(week))
                continue;


            String score =  new String(field.getValue().getValue().getValue());
            String playerID = field.getKey().getMinorPath().get(1);

            System.out.println("score: " + score);
            System.out.println("ID " + playerID);

            if(!scores.contains(Integer.parseInt(score)))
            {
                scores.add(Integer.parseInt(score));
            }

            if(!map.containsKey(score))
            {
                ArrayList<String> arrayList = new ArrayList<String>();
                arrayList.add(playerID);
                map.put(score,arrayList);
            }
            else
            {
                ArrayList<String> updated = map.get(score);
                updated.add(playerID);
                map.put(score, updated);
            }

        }
        Collections.sort(scores);

        for(int i = 0; i< scores.size(); i++)
        {
            StringBuilder sb = new StringBuilder();
            for (String s : map.get(Integer.toString(scores.get(i))))
            {
                sb.append(s);
                sb.append(" ");
            }
            System.out.println("Score: " + scores.get(i) + ", Player ID: " + sb );
        }
    }


    /**
     * Key Structure
     * \player\ID\-\name
     * \player\ID\-\proTeam
     * \player\ID\-\position
     * etc
	 *
	 * Load the player relation into the key value structure listed above.
     * @throws SQLException
     */
    public void loadPlayers() throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "system", "MonkeyHat8");
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT ID, name, pro_team, position, goals, assists, clean_sheets FROM Player");

        //Major key structure:  /playerScore/player_ID/week/-/week/-/score/-/played/-/goals/-/assists/-/clean_sheet
        while (resultSet.next())
        {
            String ID = Integer.toString(resultSet.getInt(1));
            String name = resultSet.getString(2);
            String proTeam = Integer.toString(resultSet.getInt(3));
            String position = resultSet.getString(4);
            String goals = Integer.toString(resultSet.getInt(5));
            String assists = Integer.toString(resultSet.getInt(6));
            String cleanSheets = Integer.toString(resultSet.getInt(7));


            Key key1 = Key.createKey(Arrays.asList("player", ID), Arrays.asList("name"));
            Key key2 = Key.createKey(Arrays.asList("player", ID), Arrays.asList("proTeam"));
            Key key3 = Key.createKey(Arrays.asList("player", ID), Arrays.asList("position"));
            Key key4 = Key.createKey(Arrays.asList("player", ID), Arrays.asList("goals"));
            Key key5 = Key.createKey(Arrays.asList("player", ID), Arrays.asList("assists"));
            Key key6 = Key.createKey(Arrays.asList("player", ID), Arrays.asList("cleanSheets"));

            Value v1 = Value.createValue(name.getBytes());
            Value v2 = Value.createValue(proTeam.getBytes());
            Value v3 = Value.createValue(position.getBytes());
            Value v4 = Value.createValue(goals.getBytes());
            Value v5 = Value.createValue(assists.getBytes());
            Value v6 = Value.createValue(cleanSheets.getBytes());

            store.put(key1, v1);
            store.put(key2, v2);
            store.put(key3, v3);
            store.put(key4, v4);
            store.put(key5, v5);
            store.put(key5, v5);
            store.put(key6, v6);
        }
        resultSet.close();
        jdbcStatement.close();
        jdbcConnection.close();
        store.close();
    }

    /**
     * prints the information about a player
     * @param ID
     */
    public void getPlayer(String ID)
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        Key majorKeyPath = Key.createKey(Arrays.asList("player", ID));
        System.out.println("player ID: " + majorKeyPath.getMajorPath().get(1));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPath, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" +fieldName + ": " + fieldValue);

        }
        store.close();
    }

}
