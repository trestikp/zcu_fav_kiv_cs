package cz.zcu.kiv.pia.bikesharing.business.security;

import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

/**
 * Token used by Github provider to authenticate users.
 */
public class GithubUserAuthenticationToken extends AbstractAuthenticationToken {
    private final Object principal;

    public GithubUserAuthenticationToken(Object principal) {
        super(null); // No authorities
        this.principal = principal;
        setAuthenticated(false);
    }

    public GithubUserAuthenticationToken(Object principal, Collection<? extends GrantedAuthority> authorities) {
        super(authorities);
        this.principal = principal;
        super.setAuthenticated(true); // Use this constructor if you have authorities and want to set authenticated to true
    }
    @Override
    public Object getCredentials() {
        return null; // credentials are not used for github user auth (github does the authentication)
    }

    @Override
    public Object getPrincipal() {
        return principal;
    }
}
