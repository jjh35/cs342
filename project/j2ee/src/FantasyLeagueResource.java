import models.FantasyLeague;
import models.UserTeam;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import java.util.List;
import java.util.Map;


/**
*@author Created by  Jesse Hulse(jjh35) on 5/11/2017.
*This j2ee project implements a restful web service for the fantasy league database. 
* A user may query for his team, which will return a JSON object with his or her team's name, record, id, each player with their scores for the week, user account info,
*	and fantasy league information at the path @get "fantasysoccer/team/{id}"
* A user may update this user_team object by sending a JSON object to @put "fantasysoccer/team/{id}"
* A user may add a user_team object to the Database by sending a JSON object to @posrt "fantasysoccer/team"
* A user may delete a user_team object by querying the @delete path fantasysoccer/team/{id}"
 */
@Stateless
@Path("fantasysoccer")
public class FantasyLeagueResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;

    /**
     * A test route
     */
    @GET
    @Path("test")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, soccer enthusiast!";
    }

    /**
     * gets the UserTeam objects and returns it in JSON
     * @param id, the id of the user team
     * @return, the userTeam
     */
    @GET
    @Path("team/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public UserTeam getTeam(@PathParam("id") long id)
    {
        return em.find(UserTeam.class, id);
        //return Response.ok(em.find(UserTeam.class, id), MediaType.APPLICATION_JSON).build();
    }

    /**
     * Updates and existing userTeam
     * @param newTeam, a a JSON userTeam
     * @param id, the id of the user team
     * @return the updated user team
     */
    @PUT
    @Path("team/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response putPerson(UserTeam newTeam, @PathParam("id") long id)
    {

        newTeam.setId(id);
        FantasyLeague fl = (FantasyLeague) this.em.find(FantasyLeague.class, Long.valueOf(newTeam.getFantasyLeague().getId()));
        newTeam.setFantasyLeague(fl);
        try {
            UserTeam ut = this.em.merge(newTeam);
            return Response.ok(ut, MediaType.APPLICATION_JSON).build();
        }
        catch (Exception e)
        {
            return Response.serverError().entity("Invalid data").build();
        }
    }

    /**
     * creates a new user team
     * @param team, a JSON user team
     * @return, the new user team
     */
    @POST
    @Path("team")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public UserTeam postPerson(UserTeam team)
    {
        UserTeam newUserTeam = new UserTeam();
        team.setId(newUserTeam.getId());
        team.setFantasyLeague(team.getFantasyLeague());
        em.persist(team);
        return team;
        //return  Response.serverError().entity("Invalid data").build();
    }

    /**
     * deletes the user team specified by the id
     * @param id, the id of the user team to be deleted
     * @return, an success if deleted, error otherwise
     */
    @DELETE
    @Path("team/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String deleteTeam( @PathParam("id") long id)
    {
        if(em.find(UserTeam.class,id) == null)
        {
            return "team with id " + id + " not found";
        }
        else
        {
            em.remove(em.find(UserTeam.class,id));
            return "Person with id " + id + " was deleted";
        }
    }
}