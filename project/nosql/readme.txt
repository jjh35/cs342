/**
     * Answers to questions:
     * "explain why the information they provide is appropriate for a noSQL solution":
     *     Since players and player_score table could become very large in a real fantasy soccer league Database,
     *     a noSQL solution would be faster than a SQL solution.
     *" evaluate whether or not Oracle's KVLite key-value system is the best type of noSQL database for your application"
     *      KVLite would work well because the key-value structure works well (would be fast) for many of the queries that
     *      this system would need to perform.
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