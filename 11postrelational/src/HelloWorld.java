import javax.ws.rs.*;

/*Jesse Hulse, Exercise 11.3 of lab 11 (HW)
 *This is a basic RestFul APi that implements GET, POST, PUT, and DELETE http request.
 */
@Path("/hello")
public class HelloWorld {
    @DefaultValue("0") @QueryParam("number") int number;

    /* The GET request path for .../hello
     * returns the string "I hope this lab is short"
     */
    @GET
    @Produces("text/plain")
    public String getClichedMessage() {
        // Return some cliched textual content
        return "I hope this lab is short";
    }
    /* The GET request path for .../hello/api
     * returns the string "Getting"
     */
    @Path("/api")
    @GET
    @Produces("text/plain")
    public String getting()
    {
        return "Getting";
    }
    /* The PUT request path for .../hello/api
     * int number comes from a Query Parameter
     * returns Putting number
     */
    @Path("/api")
    @PUT
    @Produces("text/plain")
    public String putNumber() {
        return "Putting: " + number;
    }
    /* The POST request path for .../hello/api
     * String body is the body of the http request
     * returns posting body
     */
    @Path("/api")
    @POST
    @Produces("text/plain")
    public String postNumber(String body)
    {
        return "Posting: " + body;
    }
    /* The Delete request path for .../hello/api/integer
     * int value is the URL parameter
     * returns deleting value if the value is between 0 and 9 (Inclusive)
     */
    @Path("/api/{singleDigit}")
    @DELETE
    @Produces("test/plain")
    public String deleteNumber(@PathParam("singleDigit") int value)
    {
        if (value >= 0 && value <10)
            return "deleting: " + value;
        else
            return "value should be a single digit";
    }
}
