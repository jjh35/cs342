package models;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * Created by jjh35 on 5/11/2017.
 */
@Entity
public class Player {
    private long id;
    private String name;
    private Long goals;
    private Long assists;
    private Long cleanSheets;

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "NAME")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
    @Column(name = "CLEAN_SHEETS")
    public Long getCleanSheets() {
        return cleanSheets;
    }

    public void setCleanSheets(Long cleanSheets) {
        this.cleanSheets = cleanSheets;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Player player = (Player) o;

        if (id != player.id) return false;
        if (name != null ? !name.equals(player.name) : player.name != null) return false;
        if (goals != null ? !goals.equals(player.goals) : player.goals != null) return false;
        if (assists != null ? !assists.equals(player.assists) : player.assists != null) return false;
        if (cleanSheets != null ? !cleanSheets.equals(player.cleanSheets) : player.cleanSheets != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (goals != null ? goals.hashCode() : 0);
        result = 31 * result + (assists != null ? assists.hashCode() : 0);
        result = 31 * result + (cleanSheets != null ? cleanSheets.hashCode() : 0);
        return result;
    }
}
