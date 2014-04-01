package cs3200_hw5;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 * Created by tlunter on 3/30/14.
 */
public class ActorDao {

    private static EntityManagerFactory factory = Persistence.createEntityManagerFactory("cs3200_hw5");
    private static final SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");

    public void createActor(Actor newActor) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();
        em.persist(newActor);
        em.getTransaction().commit();
        em.close();
    }

    public List<Actor> getAllActors() {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Query query = em.createNamedQuery("Actor.findAll");
        List<Actor> actors = (List<Actor>)query.getResultList();

        em.getTransaction().commit();
        em.close();

        return actors;
    }

    public Actor getActor(int actorId) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Actor actor = em.find(Actor.class, actorId);

        em.getTransaction().commit();
        em.close();

        return actor;
    }

    public List<Casting> getCastingForActor(int actorId) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Actor actor = em.find(Actor.class, actorId);

        Query query = em.createNamedQuery("Actor.getCastingForActor");
        query.setParameter("actorInMovie", actor);
        List<Casting> castings = (List<Casting>)query.getResultList();

        em.getTransaction().commit();
        em.close();

        return castings;
    }

    public List<Movie> getMoviesForActor(int actorId) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Actor actor = em.find(Actor.class, actorId);

        Query query = em.createNamedQuery("Actor.getMoviesForActor");
        query.setParameter("actorInMovie", actor);
        List<Movie> movies = (List<Movie>)query.getResultList();

        em.getTransaction().commit();
        em.close();

        return movies;
    }

    public static void main(String[] args) {
        System.out.println("Creating Actor");

        ActorDao adao = new ActorDao();

        Actor actor = new Actor();
        actor.setFirstName("Todd");
        actor.setLastName("Lunter");

        try {
            actor.setDateOfBirth(dateFormatter.parse("1991-09-18"));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        adao.createActor(actor);

        System.out.println("Getting actor");

        Actor readActor = adao.getActor(1);

        System.out.println("Actor name: " + readActor.getFirstName() + " " + readActor.getLastName());
        System.out.println("Printing all actors");

        List<Actor> actors = adao.getAllActors();

        for (Actor a : actors) {
            System.out.println("Actor #" + a.getId() + " named " + a.getFirstName() + " " + a.getLastName());
        }
    }
}
