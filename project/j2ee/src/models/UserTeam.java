package models;

import javax.persistence.*;
import java.util.List;

/**
 * @author Created by  Jesse Hulse(jjh35) on 5/11/2017.
 * This class models the User_team (a user's fantasy team). It also includes (through a many to many relationship) each player on the user team with his scores
 * It includes the user's fantasy leauge info (through a many to one relationship) and the user's account information (through a many to one relationship)
 */
@Entity
@Table(name = "USER_TEAM", schema = "USER1", catalog = "")
public class UserTeam {
    private long id;
    private String name;
    private String record;
    private FantasyLeague fantasyLeague;
    private List<Player> players;
    private UserProfile userId;

	//Get the associated fantasy league information
    @ManyToOne
    @JoinColumn(name = "fantasy_league", referencedColumnName = "ID")
    public FantasyLeague getFantasyLeague(){return fantasyLeague;}
    public void setFantasyLeague(FantasyLeague l) {this.fantasyLeague= l;}

	//get the assocaited user profile information
    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "ID")
    public UserProfile getUserProfile(){return userId;}
    public void setUserProfile(UserProfile user) {this.userId = user;}


	//get all the players on a user team
    @ManyToMany
    @JoinTable(name = "team_player", schema = "USER1",
            joinColumns = @JoinColumn(name = "team_id", referencedColumnName = "ID", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "player_id", referencedColumnName = "id", nullable = false))
    public List<Player> getPlayers(){return players;}
    public void setPlayers(List<Player> newPlayers){this.players = newPlayers;}

    @Id
    @Column(name = "ID")
    @GeneratedValue(generator = "userTeam_sequence")
    @SequenceGenerator(name = "userTeam_sequence", sequenceName = "userTeam_sequence", allocationSize = 1)
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
    @Column(name = "RECORD")
    public String getRecord() {
        return record;
    }

    public void setRecord(String record) {
        this.record = record;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserTeam userTeam = (UserTeam) o;

        if (id != userTeam.id) return false;
        if (name != null ? !name.equals(userTeam.name) : userTeam.name != null) return false;
        if (record != null ? !record.equals(userTeam.record) : userTeam.record != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (record != null ? record.hashCode() : 0);
        return result;
    }
}
