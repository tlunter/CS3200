package cs3200_hw4;

public class Cast {
    Integer id;
    String characterName;
    Integer movieId;
    Integer actorId;
    
    public Cast() {}
    public Cast(Integer id, String characterName, Integer movieId, Integer actorId) {
        this.id = id;
        this.characterName = characterName;
        this.movieId = movieId;
        this.actorId = actorId;
    }
    public Cast(Integer id, String characterName, Movie movie, Actor actor) {
        this.id = id;
        this.characterName = characterName;
        this.movieId = movie.getId();
        this.actorId = actor.getId();
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return this.id;
    }

    public void setCharacterName(String characterName) {
        this.characterName = characterName;
    }

    public String getCharacterName() {
        return this.characterName;
    }

    public void setActor(Actor actor) {
        this.actorId = actor.getId();
    }

    public void setActor(Integer actorId) {
        this.actorId = actorId;
    }

    public Integer getActor() {
        return this.actorId;
    }

    public void setMovie(Movie movie) {
        this.movieId = movie.getId();
    }

    public void setMovie(Integer movieId) {
        this.movieId = movieId;
    }

    public Integer getMovie() {
        return this.movieId;
    }
}
