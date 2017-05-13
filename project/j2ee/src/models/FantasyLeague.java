package models;

import javax.persistence.*;

/**
 * Created by jjh35 on 5/11/2017.
 */
@Entity
@Table(name = "FANTASY_LEAGUE", schema = "USER1", catalog = "")
public class FantasyLeague {
    private long id;
    private long gameCount;
    private String name;

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "GAME_COUNT")
    public long getGameCount() {
        return gameCount;
    }

    public void setGameCount(long gameCount) {
        this.gameCount = gameCount;
    }

    @Basic
    @Column(name = "NAME")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        FantasyLeague that = (FantasyLeague) o;

        if (id != that.id) return false;
        if (gameCount != that.gameCount) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) (gameCount ^ (gameCount >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        return result;
    }
}
