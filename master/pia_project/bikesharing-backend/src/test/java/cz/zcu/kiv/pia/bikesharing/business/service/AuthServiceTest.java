package cz.zcu.kiv.pia.bikesharing.business.service;

import cz.zcu.kiv.pia.bikesharing.business.configuration.security.JwtUtils;
import cz.zcu.kiv.pia.bikesharing.business.domain.User;
import cz.zcu.kiv.pia.bikesharing.business.exception.InsufficientPermissionException;
import cz.zcu.kiv.pia.bikesharing.business.exception.InvalidTokenException;
import cz.zcu.kiv.pia.bikesharing.business.exception.UnauthorizedException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.UUID;
import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.lenient;
import static org.mockito.Mockito.when;


@ExtendWith(MockitoExtension.class)
class AuthServiceTest {
    @Mock
    private JwtUtils jwtUtils;

    @Mock
    private UserService userService;

    private AuthService authService;

    @BeforeEach
    void setUp() {
        this.authService = new AuthService(jwtUtils, userService);
    }

    @Test
    void givenValidToken_whenAuthenticateUser_returnUser() throws UnauthorizedException, UsernameNotFoundException, InvalidTokenException {
        // prepare
        String validAuthorization = "Bearer validToken";
        User mockUser = new User(UUID.randomUUID());
        when(jwtUtils.validateJwtToken(any())).thenReturn(true);
        when(jwtUtils.getUserNameFromJwtToken(any())).thenReturn("mockUser");
        when(userService.loadUserByUsername(any())).thenReturn(mockUser);

        // test
        User result = authService.authenticateUser(validAuthorization);

        // assert
        assertNotNull(result);
        assertEquals(mockUser, result);
    }

    @Test
    void givenInvalidToken_whenAuthenticateUser_throwInvalidToken() {
        // prepare
        String invalidAuthorization = "Bearer invalidToken";
        when(jwtUtils.validateJwtToken(any())).thenReturn(false);

        // test
        assertThrows(InvalidTokenException.class, () -> authService.authenticateUser(invalidAuthorization));
    }

    @Test
    void givenNullAuthorization_whenAuthenticateUser_throwUnauthorizedException() {
        assertThrows(UnauthorizedException.class, () -> authService.authenticateUser(null));
    }

    @Test
    void givenInvalidAuthorizationString_whenAuthenticateUser_throwUnauthorizedException() {
        assertThrows(UnauthorizedException.class, () -> authService.authenticateUser("Fail"));
    }

    @Test
    void givenValidTokenForInvalidUser_whenAuthenticateUser_throwUsernameNotFoundException() {
        // prepare
        String validToken = "Bearer validToken";
        when(jwtUtils.validateJwtToken(any())).thenReturn(true);
        when(jwtUtils.getUserNameFromJwtToken(any())).thenReturn("mockUser");
        when(userService.loadUserByUsername(any())).thenThrow(UsernameNotFoundException.class);

        assertThrows(UsernameNotFoundException.class, () -> authService.authenticateUser(validToken));
    }

    @ParameterizedTest
    @MethodSource("prepareUserRoleAndRequiredRoleParameters")
    void givenValidAuthAndUserWithRole_whenAuthenticateUserWithValidRole_returnUser(User.Role userRole, User.Role requiredRole) throws UnauthorizedException, UsernameNotFoundException, InvalidTokenException, InsufficientPermissionException {
        // prepare
        String validAuthorization = "Bearer validToken";
        User mockUser = Mockito.mock(User.class);
        lenient().when(mockUser.getRole()).thenReturn(userRole); // lenient, because when requiredRole = REGULAR, doesn't call this
        when(jwtUtils.validateJwtToken(any())).thenReturn(true);
        when(jwtUtils.getUserNameFromJwtToken(any())).thenReturn("mockUser");
        when(userService.loadUserByUsername(any())).thenReturn(mockUser);

        // test
        User result = authService.authenticateUser(validAuthorization, requiredRole);

        // assert
        assertNotNull(result);
    }

    @Test
    void givenValidAuthAndUserWithRole_whenAuthenticateUserWithInsufficientRole_throwInsufficientPermissionException() throws UnauthorizedException, UsernameNotFoundException, InvalidTokenException, InsufficientPermissionException {
        // prepare
        String validAuthorization = "Bearer validToken";
        User mockUser = Mockito.mock(User.class);
        lenient().when(mockUser.getRole()).thenReturn(User.Role.REGULAR);
        when(jwtUtils.validateJwtToken(any())).thenReturn(true);
        when(jwtUtils.getUserNameFromJwtToken(any())).thenReturn("mockUser");
        when(userService.loadUserByUsername(any())).thenReturn(mockUser);

        // test
        assertThrows(InsufficientPermissionException.class, () -> authService.authenticateUser(validAuthorization, User.Role.SERVICEMAN));
    }

    private static Stream<Arguments> prepareUserRoleAndRequiredRoleParameters() {
        // user role, required role
        return Stream.of(
                Arguments.of(User.Role.REGULAR, User.Role.REGULAR),
                Arguments.of(User.Role.SERVICEMAN, User.Role.REGULAR),
//                Arguments.of(User.Role.REGULAR, User.Role.SERVICEMAN), // this throws an exception -> custom test
                Arguments.of(User.Role.SERVICEMAN, User.Role.SERVICEMAN)
        );
    }

}