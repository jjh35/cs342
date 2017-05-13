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
 * The information provided would be useful for any user wanting to view their team.
 * They should be able to see their team's name and players as well as their user
 * profile information. So this API provides this.
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