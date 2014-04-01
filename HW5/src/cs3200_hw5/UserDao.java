package cs3200_hw5;

import javax.persistence.Query;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Created by tlunter on 3/31/14.
 */
public class UserDao {
    private static EntityManagerFactory factory = Persistence.createEntityManagerFactory("cs3200_hw5");
    private static final SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");

    public void createUser(User newUser) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        em.persist(newUser);

        em.getTransaction().commit();
        em.close();
    }

    public User getUser(int userId) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        User user = em.find(User.class, userId);

        em.getTransaction().commit();
        em.close();

        return user;
    }

    public List<Review> getReviewsForUser(int userId) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        User user = getUser(userId);

        Query query = em.createNamedQuery("User.getReviewsForUser");
        query.setParameter("reviewer", user);
        List<Review> reviews = (List<Review>)query.getResultList();

        em.getTransaction().commit();
        em.close();

        return reviews;
    }

    public void addReviewForMovie(int userId, int movieId, Review review) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        User user = em.find(User.class, userId);
        Movie movie = em.find(Movie.class, movieId);

        review.setReviewer(user);
        review.setMovieReviewed(movie);

        em.persist(review);

        em.getTransaction().commit();
        em.close();
    }

    public static void main(String[] args) {
        UserDao udo = new UserDao();

        System.out.println("Making initial user");

        User user = new User();
        user.setFirstName("Todd");
        user.setLastName("Lunter");
        try {
            user.setDateOfBirth(dateFormatter.parse("1991-09-18"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        user.setUsername("tlunter");
        user.setPassword("s0s3cr37");
        user.setEmail("tlunter@gmail.com");

        udo.createUser(user);

        System.out.println("Get first user");

        User newUser = udo.getUser(1);
        System.out.println("Name: " + newUser.getFirstName() + " " + newUser.getLastName());
        System.out.println("Adding review for first movie and user");

        Review review = new Review();
        review.setComment("It was AIGHT");
        try {
            review.setDateCommented(dateFormatter.parse("2014-04-01"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        review.setStars(5);
        udo.addReviewForMovie(1, 1, review);

        System.out.println("Getting reviews for user");
        List<Review> reviews = udo.getReviewsForUser(1);

        for (Review r : reviews) {
            System.out.println("Review #" + r.getId() + " Comment: " + r.getComment() + " User: " + r.getReviewer().getUsername());
        }
    }
}
