This j2ee project implements a restful web service for the fantasy league database. 

A user may query for his team, which will return a JSON object with his or her team's name, record, id, each player with their scores for the week, user account info,
	and fantasy league information at the path @get "fantasysoccer/team/{id}"

A user may update this user_team object by sending a JSON object to @put "fantasysoccer/team/{id}"

A user may add a user_team object to the Database by sending a JSON object to @posrt "fantasysoccer/team"

A user may delete a user_team object by querying the @delete path fantasysoccer/team/{id}"
  
 