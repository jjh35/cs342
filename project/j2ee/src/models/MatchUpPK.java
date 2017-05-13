package models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by jjh35 on 5/11/2017.
 */
public class MatchUpPK implements Serializable {
    private long team1Id;
    private long team2Id;
    private long weekNumber;

    @Column(name = "TEAM1_ID")
    @Id
    public long getTeam1Id() {
        return team1Id;
    }

    public void setTeam1Id(long team1Id) {
        this.team1Id = team1Id;
    }

    @Column(name = "TEAM2_ID")
    @Id
    public long getTeam2Id() {
        return team2Id;
    }

    public void setTeam2Id(long team2Id) {
        this.team2Id = team2Id;
    }

    @Column(name = "WEEK_NUMBER")
    @Id
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

        MatchUpPK matchUpPK = (MatchUpPK) o;

        if (team1Id != matchUpPK.team1Id) return false;
        if (team2Id != matchUpPK.team2Id) return false;
        if (weekNumber != matchUpPK.weekNumber) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (team1Id ^ (team1Id >>> 32));
        result = 31 * result + (int) (team2Id ^ (team2Id >>> 32));
        result = 31 * result + (int) (weekNumber ^ (weekNumber >>> 32));
        return result;
    }
}
