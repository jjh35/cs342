package models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by jjh35 on 5/11/2017.
 */
public class PlayerScorePK implements Serializable {
    private long playerId;
    private long week;

    @Column(name = "PLAYER_ID")
    @Id
    public long getPlayerId() {
        return playerId;
    }

    public void setPlayerId(long playerId) {
        this.playerId = playerId;
    }

    @Column(name = "WEEK")
    @Id
    public long getWeek() {
        return week;
    }

    public void setWeek(long week) {
        this.week = week;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PlayerScorePK that = (PlayerScorePK) o;

        if (playerId != that.playerId) return false;
        if (week != that.week) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (playerId ^ (playerId >>> 32));
        result = 31 * result + (int) (week ^ (week >>> 32));
        return result;
    }
}
