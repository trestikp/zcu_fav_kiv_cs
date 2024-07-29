package cz.zcu.kiv.pia.bikesharing.business.service;

public interface IGithubService {
    /**
     * Handles the Github authorization process. It exchanges the authorization code for an access token and then
     * uses the access token to retrieve the user details. The user details are then parsed and the login is extracted.
     *
     * The whole process can fail at multiple steps. However regardless at which step it fails, the failure is treated
     * as authorization error.
     *
     * @param code The authorization code received from Github
     * @return The login of the user if the authorization was successful, null otherwise
     */
    String authorizeViaGithub(String code);
}
