
import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

//Defines the base URI for all resource URIs.
@ApplicationPath("/")
/**
* @author Created by  Jesse Hulse(jjh35) on 5/11/2017.
*The java class declares root resource and provider classes
* This gives out web application access to the java object and the  DB
*/
public class MyApplication extends Application{
    //The method returns a non-empty collection with classes, that must be included in the published JAX-RS application
    @Override
    public Set<Class<?>> getClasses() {
        HashSet h = new HashSet<Class<?>>();
        h.add(FantasyLeagueResource.class );
        return h;
    }
}