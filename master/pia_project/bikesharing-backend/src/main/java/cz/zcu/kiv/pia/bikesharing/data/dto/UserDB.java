package cz.zcu.kiv.pia.bikesharing.data.dto;

import jakarta.persistence.*;

import java.util.UUID;

/**
 * Database representation of {@link cz.zcu.kiv.pia.bikesharing.business.domain.User}. User by JPA for ORM.
 */
@Entity(name = "User")
@Table(name = "user")
public class UserDB {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "uuid4")
    @Column(columnDefinition = "BINARY(16)")
    private UUID id;
    @Column
    private String name;
    @Column
    private String emailAddress;
    @Enumerated(EnumType.STRING)
    @Column(length = 2)
    private RoleDB role;
    @Column
    private String username;
    @Column
    private String password;
    /** Flag marking if user is authentication via github or native authentication */
    @Column
    private Boolean github;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public RoleDB getRole() {
        return role;
    }

    public void setRole(RoleDB role) {
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getGithub() {
        return github;
    }

    public void setGithub(Boolean github) {
        this.github = github;
    }

    public enum RoleDB {
        /**
         * REGULAR
         */
        R,
        /**
         * SERVICEMAN
         */
        S,
    }
}
