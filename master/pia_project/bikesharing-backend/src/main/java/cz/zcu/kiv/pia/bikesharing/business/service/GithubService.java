package cz.zcu.kiv.pia.bikesharing.business.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URI;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * Service for handling Github authorization. Authorization is handled using HTTP requests to Github API instead
 * of using spring security OAuth2. OAuth2 should also be usable, but it is more complicated to set up.
 */
@Service
public class GithubService implements IGithubService {
    private static final Logger logger = getLogger(GithubService.class);

    @Value("${spring.security.oauth2.client.registration.github.clientId}")
    private String clientId;
    @Value("${spring.security.oauth2.client.registration.github.clientSecret}")
    private String clientSecret;
    @Value("${spring.security.oauth2.client.registration.github.redirectUri}")
    private String redirectUri;
    @Value("${spring.security.oauth2.client.provider.github.tokenUri}")
    private String tokenUri;
    @Value("${spring.security.oauth2.client.provider.github.userInfoUri}")
    private String userInfoUri;

    @Override
    public String authorizeViaGithub(String code) {
        logger.debug("Authorizing user via Github.");
        return handleGithubAuthorization(code);
    }

    /**
     * Gets token, then uses the token to get user details and finally extracts the login from the user details.
     * @param code The authorization code received from Github
     * @return The username of the user if the authorization was successful, null otherwise
     */
    private String handleGithubAuthorization(String code) {
        var authToken = getAccessToken(code);
        if (authToken == null || authToken.isBlank()) {
            return null;
        }

        var userDetailString = getUserDetails(authToken);
        if (userDetailString == null || userDetailString.isBlank()) {
            return null;
        }

        return extractLogin(userDetailString);
    }

    /**
     * Sends a POST request to Github API to exchange the authorization code for an access token.
     * @param code The authorization code received from Github
     * @return The access token if the request was successful, null otherwise
     */
    private String getAccessToken(String code) {
        try (CloseableHttpClient client = HttpClientBuilder.create().build()) {
            // construct the request URL
            URI uri = new URIBuilder(tokenUri)
                    .addParameter("client_id", clientId)
                    .addParameter("client_secret", clientSecret)
                    .addParameter("code", code)
                    .addParameter("redirect_uri", redirectUri)
                    .build();

            HttpPost postRequest = new HttpPost(uri);
            postRequest.setEntity(new StringEntity("", ContentType.APPLICATION_FORM_URLENCODED));

            // send the request and parse the response into string. Then extract the token and return it
            try (CloseableHttpResponse response = client.execute(postRequest)) {
                // get the response body as a string
                HttpEntity entity = response.getEntity();
                String responseBody = EntityUtils.toString(entity);

                // extract the access token from the response body
                return extractAccessToken(responseBody);
            }
        } catch (Exception ex) {
            logger.error("Failed to retrieve access token from Github.", ex);
        }

        return null;
    }

    /**
     * Sends a GET request to Github API to retrieve user details.
     * @param accessToken The access token received from Github
     * @return The user details as a string if the request was successful, null otherwise
     */
    private String getUserDetails(String accessToken) {
        try (CloseableHttpClient client = HttpClientBuilder.create().build()) {
            URI uri = new URIBuilder(userInfoUri).build();

            // create GET request with authorization header
            HttpGet getRequest = new HttpGet(uri);
            getRequest.setHeader("Authorization", "Bearer " + accessToken);

            // make the request and parse the response into String. The String will be in JSON format
            try (CloseableHttpResponse response = client.execute(getRequest)) {
                HttpEntity entity = response.getEntity();
                return EntityUtils.toString(entity);
            }
        } catch (Exception ex) {
            logger.error("Failed to retrieve user details from Github.", ex);
        }

        return null;
    }

    /**
     * Extracts the username from the user details JSON.
     * @param userDetails The user details JSON
     * @return The username of the user if the login field is present, null otherwise
     */
    private String extractLogin(String userDetails) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            JsonNode jsonTree = mapper.readTree(userDetails);

            if (jsonTree.has("login")) {
                return jsonTree.get("login").asText();
            }
        } catch (JsonProcessingException ex) {
            logger.error("Failed to parse user details JSON.", ex);
        }

        return null; // return null if the login field is not present
    }

    /**
     * Extracts the access token from the response body.
     * @param responseBody The response body
     * @return The access token if it can be extracted, null otherwise
     */
    private String extractAccessToken(String responseBody) {
        String prefix = "access_token=";
        String suffix = "&scope";
        int startIndex = responseBody.indexOf(prefix);
        int endIndex = responseBody.indexOf(suffix);
        if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
            return responseBody.substring(startIndex + prefix.length(), endIndex);
        }

        logger.error("Failed to extract access token from Github response.");
        return null; // return null if the access token cannot be extracted
    }
}
