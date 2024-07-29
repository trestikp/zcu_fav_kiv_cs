package cz.zcu.kiv.pia.bikesharing.business.security;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

/**
 * Provides authentication to user logged in via Github.
 */
public class GithubUserAuthenticationProvider implements AuthenticationProvider {
    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        return new GithubUserAuthenticationToken(authentication.getPrincipal(), authentication.getAuthorities());
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return GithubUserAuthenticationToken.class.isAssignableFrom(authentication);
    }
}
