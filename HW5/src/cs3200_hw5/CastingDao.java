package cs3200_hw5;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.List;

/**
 * Created by tlunter on 3/31/14.
 */
public class CastingDao {
    private static EntityManagerFactory factory = Persistence.createEntityManagerFactory("cs3200_hw5");

    public void createCast(int actorId, int movieId, Casting casting) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Actor actor = em.find(Actor.class, actorId);
        Movie movie = em.find(Movie.class, movieId);

        casting.setActorInMovie(actor);
        casting.setMovieActedIn(movie);

        em.persist(casting);

        em.getTransaction().commit();
        em.close();
    }

    public Casting getCasting(int castingId) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Casting casting = em.find(Casting.class, castingId);

        em.getTransaction().commit();
        em.close();

        return casting;
    }

    public List<Casting> getCastingForMovie(int movieId) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Movie movie = new MovieDao().getMovie(movieId);

        Query query = em.createNamedQuery("Movie.getCastingForMovie");
        query.setParameter("movieActedIn", movie);
        List<Casting> casting = (List<Casting>)query.getResultList();

        em.getTransaction().commit();
        em.close();

        return casting;
    }

    public void changeCharacterForCasting(int castingId, String newCharacter) {
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        Casting casting = getCasting(castingId);
        casting.setCharacterName(newCharacter);

        em.merge(casting);

        em.getTransaction().commit();
        em.close();
    }

    public static void main(String[] args) {
        CastingDao cdao = new CastingDao();

        System.out.println("Creating first casting for actor 1 movie 1");

        Casting casting = new Casting();
        casting.setCharacterName("Tom Cruise");

        cdao.createCast(1, 1, casting);

        System.out.println("Getting casting for movie 1");

        List<Casting> castings = cdao.getCastingForMovie(1);

        for (Casting c : castings) {
            System.out.println("Casting #" + c.getId() + " Character Name: " + c.getCharacterName() + " Actor: " + c.getActorInMovie().getFirstName() + " " + c.getActorInMovie().getLastName());
        }

        Casting newCasting = cdao.getCasting(1);
        cdao.changeCharacterForCasting(newCasting.getId(), newCasting.getCharacterName() + "1");

        Casting newChangedCasting = cdao.getCasting(1);

        System.out.println("New name: " + newChangedCasting.getCharacterName());
    }
}
