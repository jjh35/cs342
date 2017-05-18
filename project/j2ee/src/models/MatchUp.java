package models;

import javax.persistence.*;

/**
 * Created by jjh35 on 5/11/2017.
 *provides the match_up object that is mapped from the relational DB
 */
@Entity
@Table(name = "MATCH_UP", schema = "USER1", catalog = "")
@IdClass(MatchUpPK.class)
public class MatchUp {
    private long team1Id;
    private long team2Id;
    private Long team1Score;
    private Long team2Score;
    private long weekNumber;

    @Id
    @Column(name = "TEAM1_ID")
    public long getTeam1Id() {
        return team1Id;
    }

    public void setTeam1Id(long team1Id) {
        this.team1Id = team1Id;
    }

    @Id
    @Column(name = "TEAM2_ID")
    public long getTeam2Id() {
        return team2Id;
    }

    public void setTeam2Id(long team2Id) {
        this.team2Id = team2Id;
    }

    @Basic
    @Column(name = "TEAM1_SCORE")
    public Long getTeam1Score() {
        return team1Score;
    }

    public void setTeam1Score(Long team1Score) {
        this.team1Score = team1Score;
    }

    @Basic
    @Column(name = "TEAM2_SCORE")
    public Long getTeam2Score() {
        return team2Score;
    }

    public void setTeam2Score(Long team2Score) {
        this.team2Score = team2Score;
    }

    @Id
    @Column(name = "WEEK_NUMBER")
    public long getWeekNumber() {
        return weekNumber;
    }

    public void setWeekNumber(long weekNumber) {
        this.weekNumber = weekNumber;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        MatchUp matchUp = (MatchUp) o;

        if (team1Id != matchUp.team1Id) return false;
        if (team2Id != matchUp.team2Id) return false;
        if (weekNumber != matchUp.weekNumber) return false;
        if (team1Score != null ? !team1Score.equals(matchUp.team1Score) : matchUp.team1Score != null) return false;
        if (team2Score != null ? !team2Score.equals(matchUp.team2Score) : matchUp.team2Score != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (team1Id ^ (team1Id >>> 32));
        result = 31 * result + (int) (team2Id ^ (team2Id >>> 32));
        result = 31 * result + (team1Score != null ? team1Score.hashCode() : 0);
        result = 31 * result + (team2Score != null ? team2Score.hashCode() : 0);
        result = 31 * result + (int) (weekNumber ^ (weekNumber >>> 32));
        return result;
    }
}
