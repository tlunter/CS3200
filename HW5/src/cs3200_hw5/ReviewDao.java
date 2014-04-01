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
public class ReviewDao {
    private static EntityManagerFactory factory = Persistence.createEntityManagerFactory("cs3200_hw5");
    private static final SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");

    public void createReview(int userId, int movieId, Review review) {
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

    public Review getReview(int reviewId) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Review review = em.find(Review.class, reviewId);

        em.getTransaction().commit();
        em.close();

        return review;
    }

    public List<Review> getAllReviews() {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Query query = em.createNamedQuery("Review.getAllReviews");
        List<Review> reviews = (List<Review>)query.getResultList();

        em.getTransaction().commit();
        em.close();

        return reviews;
    }

    public void updateReview(Review review) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        em.merge(review);

        em.getTransaction().commit();
        em.close();
    }

    public void deleteReview(int reviewId) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Review review = em.find(Review.class, reviewId);

        em.remove(review);

        em.getTransaction().commit();
        em.close();
    }

    public static void main(String[] args) {
        ReviewDao rdo = new ReviewDao();

        System.out.println("Making review");
        Review review = new Review();
        review.setComment("It was kind of cool");
        try {
            review.setDateCommented(dateFormatter.parse("2014-03-31"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        review.setStars(12);
        rdo.createReview(1, 1, review);

        System.out.println("Get review 1");
        Review newReview = rdo.getReview(1);

        System.out.println("Review #" + newReview.getId() + " Comment: " + newReview.getComment() + " User: " + newReview.getReviewer().getUsername() + " Movie: " + newReview.getMovieReviewed().getTitle());
        System.out.println("Update first review");

        newReview.setComment(newReview.getComment() + " AGAIN");
        rdo.updateReview(newReview);

        System.out.println("Deleting last review");

        List<Review> reviews = rdo.getAllReviews();
        Review lastReview = reviews.get(reviews.size() - 1);

        rdo.deleteReview(lastReview.getId());
    }
}
