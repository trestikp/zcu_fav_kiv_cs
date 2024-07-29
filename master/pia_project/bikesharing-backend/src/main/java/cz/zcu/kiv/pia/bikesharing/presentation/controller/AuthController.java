package cz.zcu.kiv.pia.bikesharing.presentation.controller;

import cz.zcu.kiv.pia.bikesharing.business.configuration.security.JwtUtils;
import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.business.exception.EmailAlreadyTakenException;
import cz.zcu.kiv.pia.bikesharing.business.exception.UsernameAlreadyTakenException;
import cz.zcu.kiv.pia.bikesharing.business.security.GithubUserAuthenticationToken;
import cz.zcu.kiv.pia.bikesharing.business.service.IGithubService;
import cz.zcu.kiv.pia.bikesharing.business.service.IUserService;
import cz.zcu.kiv.pia.bikesharing.controller.AuthApi;
import cz.zcu.kiv.pia.bikesharing.model.*;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * Implementation of {@link AuthApi}, which is generated from OpenAPI specification.
 */
@RestController
public class AuthController implements AuthApi {
    private static final Logger logger = getLogger(AuthController.class);
    final AuthenticationManager authenticationManager;
    final PasswordEncoder encoder;
    final JwtUtils jwtUtils;
    final IUserService userService;
    final IGithubService githubService;

    @Autowired
    public AuthController(AuthenticationManager authenticationManager, PasswordEncoder encoder, JwtUtils jwtUtils,
                          IUserService userService, IGithubService githubService) {
        this.authenticationManager = authenticationManager;
        this.encoder = encoder;
        this.jwtUtils = jwtUtils;
        this.userService = userService;
        this.githubService = githubService;
    }

    /**
     * Uses Spring Security authentication manager to authenticate user using form.
     * Spring security returns 401 and a message on failure to authenticate.
     * @param loginForm User login form data
     * @return AuthResponse with JWT token
     */
    @Override
    public ResponseEntity<AuthResponse> loginUser(LoginForm loginForm) {
        // this is a little hack, but this is probably the only place, that actually needs to load user by name for auth
        var user = userService.findByUsernameAndGithub(loginForm.getUsername(), false);
        var username = user != null ? user.getId() : null;

        logger.debug("Authenticating user {} via login form", username);

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(username, loginForm.getPassword()));

        var response = setAuthenticationAndCreateAuthResponse(authentication);

        return ResponseEntity.ok(response);
    }

    /**
     * Authorizes user via Github OAuth. Creates a new user for the github username if it doesn't exist yet.
     * Then uses spring security to generate authentication context for the user.
     * @param code Github OAuth code (required)
     * @return AuthResponse with JWT token
     */
    @Override
    public ResponseEntity<AuthResponse> githubLoginUser(String code) {
        logger.debug("Authenticating user via github OAuth");

        var username = githubService.authorizeViaGithub(code);
        if (username == null || username.isBlank()) {
            logger.info("Failed to authenticate user via github OAuth");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        var user = userService.findByUsernameAndGithub(username, true);

        // user doesn't exist yet -> register new user
        if (user == null) {
            user = userService.registerNewGithubUser(username);

            // we failed to create user even tho github auth was OK -> 500
            if (user == null) {
                logger.error("Failed to create new user for github username {}", username);
                return ResponseEntity.internalServerError().build();
            }
        }

        Authentication authentication = authenticationManager.authenticate(new GithubUserAuthenticationToken(user));

        var response = setAuthenticationAndCreateAuthResponse(authentication);

        return ResponseEntity.ok(response);
    }

    /**
     * Registers new user via form.
     * @param registrationForm User registration form data (optional)
     * @return On success returns 201 CREATED, on failure returns 409 CONFLICT with GenericErrorResponse.
     */
    @Override
    public ResponseEntity<Object> registerUser(RegistrationForm registrationForm) {
        logger.debug("Registering new user via registration form");

        try {
            User newUser = userService.registerNewUser(registrationForm.getName(), registrationForm.getUsername(),
                    registrationForm.getPassword(), registrationForm.getEmail());

            if (newUser != null) {
                return ResponseEntity.status(HttpStatus.CREATED).build();
            }
        } catch (UsernameAlreadyTakenException ex) {
            var error = new GenericErrorResponse();
            error.addMessagesItem(new GenericErrorItem().code("USERNAME").message("Username is already taken."));
            return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
        } catch (EmailAlreadyTakenException ex) {
            var error = new GenericErrorResponse();
            error.addMessagesItem(new GenericErrorItem().code("EMAIL").message("Email is already taken."));
            return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
        } catch (DataIntegrityViolationException ex) {
            var error = new GenericErrorResponse();
            error.addMessagesItem(new GenericErrorItem().code("UNEXPECTED").message("Unexpected constraint error."));
            return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
        } catch (Exception ex) {
            logger.error("Failed to register new user via form due to unexpected exception", ex);
            return ResponseEntity.internalServerError().build();
        }

        logger.error("Failed to register new user via form due to unknown reason (user was not saved successfully but no exception was thrown?)");
        return ResponseEntity.internalServerError().build();
    }

    /**
     * Sets authentication context and creates AuthResponse object.
     * @param authentication Authentication object
     * @return AuthResponse object
     */
    private AuthResponse setAuthenticationAndCreateAuthResponse(Authentication authentication) {
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = jwtUtils.generateJwtToken(authentication);

        User userDetails = (User) authentication.getPrincipal();
        List<String> roles = userDetails.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .toList();

        AuthResponse response = new AuthResponse();
        response.message("Login successful");
        response.token(jwt);

        AuthResponseUser responseUser = new AuthResponseUser();
        responseUser.setUsername(userDetails.getUsername());
        responseUser.setRoles(roles);
        response.setUser(responseUser);

        return response;
    }
}
