import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import oracle.kv.*;


public class LoadDB {

    public ArrayList<Key> movieKeys = new ArrayList<Key>();
    public ArrayList<Key> roleKeys = new ArrayList<Key>();
    public ArrayList<Key>  movieActorKeys = new ArrayList<Key>();
    public ArrayList<Key> actorKeys = new ArrayList<Key>();

    //loads the kvlite Database
    public LoadDB()
    {
        try {
            loadActors();
            loadMovieActors();
            loadMovies();
            loadRoles();
        }
        catch (Exception e)
        {
            System.out.println("error loading database: " + e);
        }

    }

    /**
     * Loads the actors from the actor table in SQL. Uses the following key structure
     * actor/actorID/-/firstName
     * actor/actorID/-/lastName
     * actor/actorID/-/gender
     *
     * @throws SQLException
     */
    public void loadActors() throws SQLException
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        //first connect to the SQL DB
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "system", "MonkeyHat8");
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, firstName, lastName, gender FROM Actor");
        //Load the sql db into the kvlite db
        String fieldName1 = "firstName";
        String fieldName2 = "lastName";
        String fieldName3 = "Gender";

        while (resultSet.next()) {
            String movieIdString = Integer.toString(resultSet.getInt(1));

            Value value1;
            Value value2;
            Value value3;

            Key key1= Key.createKey(Arrays.asList("actor", movieIdString), Arrays.asList(fieldName1));
            Key key2 = Key.createKey(Arrays.asList("actor", movieIdString), Arrays.asList(fieldName2));
            Key key3 = Key.createKey(Arrays.asList("actor", movieIdString), Arrays.asList(fieldName3));

            try {
                value1 = Value.createValue(resultSet.getString(2).getBytes());
                store.put(key1, value1);
            }
            catch (Exception e) {
                value1 = Value.createValue("null".getBytes());
                store.put(key1, value1);
            }

            try {
                value2 = Value.createValue(resultSet.getString(3).getBytes());
                store.put(key2, value2);
            }
            catch (Exception e) {
                value2 = Value.createValue("null".getBytes());
                store.put(key2, value2);
            }

            try {
                value3 = Value.createValue(resultSet.getString(4).getBytes());
                store.put(key3, value3);
            }
            catch (Exception e) {
                value3 = Value.createValue("null".getBytes());
                store.put(key3, value3);
            }

            actorKeys.add(key1);
            actorKeys.add(key2);
            actorKeys.add(key3);
        }

        resultSet.close();
        jdbcStatement.close();
        jdbcConnection.close();

        store.close();
    }

    /**
     * deletes the key structure
     * movieActors/movieID/actor1/-/actorID, /movieID/actor2/-/actorID, etc
     */
    public void deleteActors()
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        for (int i = 0; i < actorKeys.size(); i++) {
            store.delete(actorKeys.get(i));
            //System.out.println("role " + i +  " deleted");
        }
        actorKeys.clear();
        store.close();
    }

    /**
     * Loads the movie actors from the SQL DB
     * uses the following structures
     *  //key structure movieActors/movieID/actor1/-/actorID
     *  /movieID/actor2/-/actorID
     * /movieID/actor3/-/actorID
     */
    public void loadMovieActors() throws SQLException
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        //first connect to the SQL DB
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "system", "MonkeyHat8");
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT movieid, actorid from role");
        int j = 0;
        while (resultSet.next()) {
            //System.out.println(j);
            j++;
            String movieIDString = Integer.toString(resultSet.getInt(1));


            Value value1;
            Key key1;
            int i = 1;
            while(true)
            {
                key1 = Key.createKey(Arrays.asList("movieActors", movieIDString), Arrays.asList("actor" + i));
                movieActorKeys.add(key1);

                try
                {
                    String value = new String(store.get(key1).getValue().getValue());
                }
                catch (Exception e)
                {
                    value1 = Value.createValue(resultSet.getString(2).getBytes());
                    //System.out.println(key1.toString() + " " +  new String(resultSet.getString(2).getBytes()));
                    store.put(key1, value1);
                    break;
                }
                i++;

            }
        }

        resultSet.close();
        jdbcStatement.close();
        jdbcConnection.close();

        store.close();
    }

    /**
     * Returns the actors and roles in a given movie.
     * key Structure
     *    movieActors/movieID/actor1/-/actorID
     //              /movieID/actor2/-/actorID
     //              /movieID/actor3/-/actorID
     * @param movieID
     */
    public void getMovieActors(String movieID)
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        Key majorKeyPath;
        System.out.println("Movie ID: " + movieID );

        int i = 1;
        while(true)
        {
            majorKeyPath =  Key.createKey(Arrays.asList("movieActors", movieID), Arrays.asList("actor" + i));
            try {
                String result = new String(store.get(majorKeyPath).getValue().getValue());
                ArrayList<String> roles = getMovieActorRoles(result, movieID,false);

                Key k = Key.createKey(Arrays.asList("actor", result), Arrays.asList("firstName"));
                //System.out.println(k.toString());
                String actorFirstName = new String(store.get(k).getValue().getValue());
                String actorLastName = new String(store.get(Key.createKey(Arrays.asList("actor", result), Arrays.asList("lastName"))).getValue().getValue());
                for(int j = 0; j< roles.size(); j++)
                {

                    System.out.print("\t"  + result + " " + actorFirstName + " " + actorLastName + "     ");
                    System.out.println(roles.get(j));

                }

            } catch (Exception e) {
                if(i==1)
                    System.out.println("error, invalid key");
                break;
            }
            i++;
        }
        System.out.println();
        store.close();
    }


    /**
     * deletes the keys with the following structure
     *   movieActors/movieID/actor1/-/actorID
     *              /movieID/actor2/-/actorID
     *              /movieID/actor3/-/actorID
     */
    public void deleteMoviesActors()
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        for(int i = 0; i<movieActorKeys.size(); i++)
        {
            store.delete(movieActorKeys.get(i));
        }
        movieActorKeys.clear();
        store.close();
    }

    /**
     * Loads the movies from the SQL DB into the KVlite DB using the following key
     * Key: /movie/movieID/-/name,/movie/movieID/-/year,/movie/movieID/-/rating
     * @throws SQLException
     */
    public void loadMovies() throws SQLException
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        //first connect to the SQL DB
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "system", "MonkeyHat8");
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, year, rank FROM Movie order by year asc");

        //Load the sql db into the kvlite db
        String fieldName1 = "year";
        String fieldName2 = "name";
        String fieldName3 = "rating";

        while (resultSet.next()) {
            String movieIdString = Integer.toString(resultSet.getInt(1));

            Value value1;
            Value value2;
            Value value3;

            Key key1= Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList(fieldName1));
            Key key2 = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList(fieldName2));
            Key key3 = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList(fieldName3));

            try {
                value1 = Value.createValue(resultSet.getString(2).getBytes());
                store.put(key1, value1);
            }
            catch (Exception e) {
                value1 = Value.createValue("null".getBytes());
                store.put(key1, value1);
            }

            try {
                value2 = Value.createValue(resultSet.getString(3).getBytes());
                store.put(key2, value2);
            }
            catch (Exception e) {
                value2 = Value.createValue("null".getBytes());
                store.put(key2, value2);
            }

            try {
                value3 = Value.createValue(resultSet.getString(4).getBytes());
                store.put(key3, value3);
            }
            catch (Exception e) {
                value3 = Value.createValue("null".getBytes());
                store.put(key3, value3);
            }

            movieKeys.add(key2);
            movieKeys.add(key1);
            movieKeys.add(key3);
        }
        resultSet.close();
        jdbcStatement.close();
        jdbcConnection.close();
        store.close();
    }

    /**
     * This function will return all the entries in the movie table.
     * Key: /movie/movieID/-/name,/movie/movieID/-/year,/movie/movieID/-/rating
     */
    public void getTableValues()
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        for(int i = 0; i<movieKeys.size(); i++) {
            Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie", movieKeys.get(i).getMajorPath().get(1)));

            System.out.println("Table: " + movieKeys.get(i).getMajorPath().get(0));
            System.out.println("ID: " + movieKeys.get(i).getMajorPath().get(1));
            Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
            for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
                String fieldName = field.getKey().getMinorPath().get(0);
                String fieldValue = new String(field.getValue().getValue().getValue());
                System.out.println("\t" + fieldValue);
            }
        }

        store.close();
    }

    /**
     * deletes the movie entries in the DB
     */
    public void deleteMovies()
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        for(int i = 0; i<movieKeys.size(); i++)
        {
            store.delete(movieKeys.get(i));
            //System.out.println("movie deleted");
        }
        movieKeys.clear();
        store.close();
    }


    /**
     * This Function will load all the role rows from the roles table in the SQL DB and loads them into kvLite
     * using the following key structure: role/actorID/movieID/-/role1, role/actorID/movieID/-/role2 etc
     * @throws Exception: an SQL exception if an error occurs
     */
    public void loadRoles() throws Exception
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        //first connect to the SQL DB
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "system", "MonkeyHat8");
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT actorID, movieID, Role FROM Role");

        while (resultSet.next()) {
            String actorIDString = Integer.toString(resultSet.getInt(1));
            String movieIDString = Integer.toString(resultSet.getInt(2));

            Value value1;
            Key key1;
            int i = 1;
            while(true)
            {
                key1 = Key.createKey(Arrays.asList("role", actorIDString, movieIDString), Arrays.asList("role" + i));
                roleKeys.add(key1);

                try
                {
                    String value = new String(store.get(key1).getValue().getValue());
                }
                catch (Exception e)
                {
                    value1 = Value.createValue(resultSet.getString(3).getBytes());
                    store.put(key1, value1);
                    break;
                }
                i++;

            }
        }

        resultSet.close();
        jdbcStatement.close();
        jdbcConnection.close();

        store.close();
    }

    /**
     * This function will find all the roles that a actor played in a given movie.
     * key structure role/actorID/movieID/-/role1, role/actorID/movieID/-/role2
     * @param actorID: The actor's ID
     * @param movieID: The movie's ID
     * @param printResults: If true, print results to the console
     * @return returns an arraylist of roles
     */
    public ArrayList<String> getMovieActorRoles(String actorID, String movieID, boolean printResults)
    {
        ArrayList<String> returnArray = new ArrayList<String>();
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        Key majorKeyPath;
        if(printResults) {
            System.out.println("Movie ID: " + movieID);
            System.out.println("Actor ID: " + actorID);
        }
        int i = 1;
        while(true)
        {
            majorKeyPath = Key.createKey(Arrays.asList("role",actorID,movieID), Arrays.asList("role" + i));
            try {
                String result = new String(store.get(majorKeyPath).getValue().getValue());
                if(printResults)
                    System.out.println("\t" + result);
                returnArray.add(result);

            } catch (Exception e) {
                if(i==1) {
                    if(printResults)
                        System.out.println("error, invalid key");
                }
                break;
            }
            i++;
        }

        store.close();
        return returnArray;
    }


    /**
     * This function will delete all all the roles (key structure movieActors/movieID/actor1/-/actorID) in the DB
     */
    public void deleteRoles() {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        for (int i = 0; i < roleKeys.size(); i++) {
            store.delete(roleKeys.get(i));
            //System.out.println("role " + i +  " deleted");
        }
        roleKeys.clear();
        store.close();
    }

    /**
     * This function will return a sorted list of the movies in the DB.
     * key structure movieActors/movieID/actor1/-/actorID
     */
    public void getSortedMovies()
    {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        for(int i = 0; i<movieKeys.size(); i++)
        {
            if((i + 1) % 3 == 0) {
                System.out.print(movieKeys.get(i).getMajorPath().get(1) + " ");
                System.out.println(new String(store.get(movieKeys.get(i)).getValue().getValue()) + " ");
            }
            else {
                System.out.print(new String(store.get(movieKeys.get(i)).getValue().getValue()) + " ");
            }
        }
        store.close();
    }

    }
