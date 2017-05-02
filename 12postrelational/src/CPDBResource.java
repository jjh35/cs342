import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import models.PersonEntity;
import models.HouseholdEntity;


import java.util.List;
import java.util.Map;


/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * @author kvlinden
 * @version Spring, 2017
 */
@Stateless
@Path("cpdb")
public class CPDBResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;

    /**
     * GET a default message.
     *
     * @return a static hello-world message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, JPA!";
    }

    /**
     * GET an individual person record.
     *
     * @param id the ID of the person to retrieve
     * @return a person record
     */
    @GET
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public PersonEntity getPerson(@PathParam("id") long id) {
        return em.find(PersonEntity.class, id);
    }

    /**
     * A PUT route that updates an exisiting person in the DB
     * @param newPerson, the new JSON person passed along with the http request
     * @param id, the id of the person being updated
     * @return the updated person
     */
    @PUT
    @Path("person/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response putPerson(PersonEntity newPerson, @PathParam("id") long id)
    {
        PersonEntity oldPerson = em.find(PersonEntity.class, id);

        if( newPerson.getId() != oldPerson.getId())
        {
            return Response.serverError().entity("ID of JSON entity must match request parameter id").build();
        }
        //change the @Basic fields
        oldPerson.setBirthdate(newPerson.getBirthdate());
        oldPerson.setFirstname(newPerson.getFirstname());
        oldPerson.setGender(newPerson.getGender());
        oldPerson.setHouseholdrole(newPerson.getHouseholdrole());
        oldPerson.setLastname(newPerson.getLastname());
        oldPerson.setMembershipstatus(newPerson.getMembershipstatus());
        oldPerson.setTitle(newPerson.getTitle());
        oldPerson.setHomegrouprole(newPerson.getHomegrouprole());

        HouseholdEntity JSONhh = newPerson.getHouseHold();

        HouseholdEntity oldDBhh = oldPerson.getHouseHold();
        //if the id of the Household changes, find the corresponding household by id in
        //the DB and set it equal to that. If the household in the json does not match the
        //household of the same id in the database, then it will return an error.
        //If the houlsehold id of the JSON person matches the corresponding DB's perpson's hh id
        //then it will ignore the other fields of the hh and not change the hh.
        if( JSONhh.getId() !=  oldDBhh.getId())
        {
            if(em.find(HouseholdEntity.class,JSONhh.getId()) != null)
            {
                HouseholdEntity JSONhhFromDB = em.find(HouseholdEntity.class,JSONhh.getId());

                if(!JSONhh.equals(JSONhhFromDB)) {
                    return Response.serverError().entity("The supplied household id does not match one of the same id in the database").build();
                }
                else {
                    oldPerson.setHouseHold(em.find(HouseholdEntity.class, JSONhh.getId()));
                }
            }
            else
            {
                return Response.serverError().entity("The supplied household does not exist in the database").build();
            }
        }

        em.merge(oldPerson);
        return Response.ok(em.find(PersonEntity.class,id), MediaType.APPLICATION_JSON).build();
    };

    /**
     * A POST method that adds a new person that was passed along with the http request
     * @param JSONPerson, the new JSON person
     * @return, the new person
     */
    @POST
    @Path("people")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response postPerson(PersonEntity JSONPerson)
    {
        PersonEntity newPerson = new PersonEntity();
        newPerson.setBirthdate(JSONPerson.getBirthdate());
        newPerson.setFirstname(JSONPerson.getFirstname());
        newPerson.setGender(JSONPerson.getGender());
        newPerson.setHouseholdrole(JSONPerson.getHouseholdrole());
        newPerson.setLastname(JSONPerson.getLastname());
        newPerson.setMembershipstatus(JSONPerson.getMembershipstatus());
        newPerson.setTitle(JSONPerson.getTitle());
        newPerson.setHomegrouprole(JSONPerson.getHomegrouprole());

        HouseholdEntity JSONhh = JSONPerson.getHouseHold();
        HouseholdEntity DBhh = em.find(HouseholdEntity.class,JSONhh.getId());
        if( DBhh != null )
        {
            if(!JSONhh.equals(DBhh)) {
                return Response.serverError().entity("The supplied household id does not match one of the same id in the database").build();
            }
            else {
                newPerson.setHouseHold(em.find(HouseholdEntity.class, JSONhh.getId()));
            }
        }
        else
        {
            return Response.serverError().entity("The supplied household does not exist in the database").build();
        }
        em.persist(newPerson);
        return Response.ok(newPerson, MediaType.APPLICATION_JSON).build();
    }

    /**
     * Deletes a from from the DB
     * @param id, the id of the person being deleted
     * @return, a succces or failure message
     */
    @DELETE
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String deletePerson( @PathParam("id") long id)
    {
        if(em.find(PersonEntity.class,id) == null)
        {
            return "Person with id " + id + " not found";
        }
        else
        {
            em.remove(em.find(PersonEntity.class,id));
            return "Person with id " + id + " was deleted";
        }
    }


    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("people")
    @Produces(MediaType.APPLICATION_JSON)
    public List<PersonEntity> getPeople() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(PersonEntity.class)).getResultList();
    }

}