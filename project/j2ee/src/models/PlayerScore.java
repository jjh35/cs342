package models;

import javax.persistence.*;

/**
 * Created by jjh35 on 5/11/2017.
 * provides the PlayerScore object that is mapped from the relational DB
 */
@Entity
@Table(name = "PLAYER_SCORE", schema = "USER1", catalog = "")
@IdClass(PlayerScorePK.class)
public class PlayerScore {
    private long playerId;
    private long week;
    private Long score;
    private Long played;
    private Long goals;
    private Long assists;
    private Long cleanSheet;



    @Id
    @Column(name = "PLAYER_ID")
    public long getPlayerId() {
        return playerId;
    }

    public void setPlayerId(long playerId) {
        this.playerId = playerId;
    }

    @Id
    @Column(name = "WEEK")
    public long getWeek() {
        return week;
    }

    public void setWeek(long week) {
        this.week = week;
    }

    @Basic
    @Column(name = "SCORE")
    public Long getScore() {
        return score;
    }

    public void setScore(Long score) {
        this.score = score;
    }

    @Basic
    @Column(name = "PLAYED")
    public Long getPlayed() {
        return played;
    }

    public void setPlayed(Long played) {
        this.played = played;
    }

    @Basic
    @Column(name = "GOALS")
    public Long getGoals() {
        return goals;
    }

    public void setGoals(Long goals) {
        this.goals = goals;
    }

    @Basic
    @Column(name = "ASSISTS")
    public Long getAssists() {
        return assists;
    }

    public void setAssists(Long assists) {
        this.assists = assists;
    }

    @Basic
    @Column(name = "CLEAN_SHEET")
    public Long getCleanSheet() {
        return cleanSheet;
    }

    public void setCleanSheet(Long cleanSheet) {
        this.cleanSheet = cleanSheet;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PlayerScore that = (PlayerScore) o;

        if (playerId != that.playerId) return false;
        if (week != that.week) return false;
        if (score != null ? !score.equals(that.score) : that.score != null) return false;
        if (played != null ? !played.equals(that.played) : that.played != null) return false;
        if (goals != null ? !goals.equals(that.goals) : that.goals != null) return false;
        if (assists != null ? !assists.equals(that.assists) : that.assists != null) return false;
        if (cleanSheet != null ? !cleanSheet.equals(that.cleanSheet) : that.cleanSheet != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (playerId ^ (playerId >>> 32));
        result = 31 * result + (int) (week ^ (week >>> 32));
        result = 31 * result + (score != null ? score.hashCode() : 0);
        result = 31 * result + (played != null ? played.hashCode() : 0);
        result = 31 * result + (goals != null ? goals.hashCode() : 0);
        result = 31 * result + (assists != null ? assists.hashCode() : 0);
        result = 31 * result + (cleanSheet != null ? cleanSheet.hashCode() : 0);
        return result;
    }
}
