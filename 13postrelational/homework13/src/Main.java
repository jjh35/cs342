import java.util.ArrayList;

public class Main {

    public static void main(String[] args) {
        try
        {
            LoadDB load = new LoadDB();
            load.getTableValues();
            load.getMovieActorRoles("429719","92616", true);
            load.getMovieActorRoles("809383","350424", true);
            load.getMovieActors("92616");
            load.getSortedMovies();
            load.deleteMoviesActors();
            load.deleteRoles();
            load.deleteMovies();
            load.deleteActors();
        }
        catch (Exception e)
        {
            System.out.println("exception thrown: " + e);
        }

    }
}
