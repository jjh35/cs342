import oracle.kv.*;

import java.util.Arrays;
import java.util.Map;

public class Main {
    /**
     * Answers to questions:
     * "explain why the information they provide is appropriate for a noSQL solution":
     *     Since players and player_score table could become very large in a real fantasy soccer league Database,
     *     a noSQL solution would be faster than a SQL solution.
     *" evaluate whether or not Oracle's KVLite key-value system is the best type of noSQL database for your application"
     *      KVLite would work well because the key-value structure works well (would be fast) for many of the queries that
     *      this system would need to perform.
     *
     */


    public static void main(String[] args)
    {
        try {
            LoadDB load = new LoadDB();
            //load table player_score
            load.loadPlayerScores();
            load.getPlayerScore("5", "2");
            //load table player
            load.loadPlayers();
            load.getPlayer("10");
            //Sorted list
            load.getSortedPlayerScores("1");
            //Useful two table Join
            load.loadTeamPlayers();
            load.getTeamNames("1");
            load.getTeamNames("2");
        }
        catch(Exception e)
        {
            System.out.println("error: " + e);
        }
    }
}
