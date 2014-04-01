package cs3200_hw5;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Created by tlunter on 3/31/14.
 */
public class MovieDao {
    private static EntityManagerFactory factory = Persistence.createEntityManagerFactory("cs3200_hw5");
    private static final SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");

    public void createMovie(Movie movie) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        em.persist(movie);

        em.getTransaction().commit();
        em.close();
    }

    public List<Movie> getAllMovies() {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Query query = em.createNamedQuery("Movie.getAllMovies");
        List<Movie> movies = (List<Movie>)query.getResultList();

        em.getTransaction().commit();
        em.close();

        return movies;
    }

    public Movie getMovie(int movieId) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Movie movie = em.find(Movie.class, movieId);

        em.getTransaction().commit();
        em.close();

        return movie;
    }

    public List<Review> getReviewsForMovie(int movieId) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Movie movie = getMovie(movieId);

        Query query = em.createNamedQuery("Movie.getReviewsForMovie");
        query.setParameter("movieReviewed", movie);
        List<Review> reviews = (List<Review>)query.getResultList();

        em.getTransaction().commit();
        em.close();

        return reviews;
    }

    public List<Casting> getCastingForMovie(int movieId) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Movie movie = getMovie(movieId);

        Query query = em.createNamedQuery("Movie.getCastingForMovie");
        query.setParameter("movieActedIn", movie);
        List<Casting> casting = (List<Casting>)query.getResultList();

        em.getTransaction().commit();
        em.close();

        return casting;
    }

    public static void main(String[] args) {
        MovieDao mdo = new MovieDao();

        System.out.println("Creating single movie");

        Movie movie = new Movie();
        movie.setTitle("New Tom Cruise Movie");
        movie.setPosterImage("file:///tmp/poster.jpg");
        try {
            movie.setReleaseDate(dateFormatter.parse("2014-10-01"));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        mdo.createMovie(movie);

        System.out.println("Getting first movie");

        Movie newMovie = mdo.getMovie(1);

        System.out.println("Title: " + newMovie.getTitle() + " for " + newMovie.getReleaseDate().toString());
        System.out.println("Printing all movies");

        List<Movie> movies = mdo.getAllMovies();

        for (Movie m : movies) {
            System.out.println("Movie #" + m.getId() + " Title: " + m.getTitle());
        }
    }
}
