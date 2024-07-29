package cz.zcu.kiv.pia.bikesharing.business.configuration;

import cz.zcu.kiv.pia.bikesharing.business.configuration.security.JwtAuthExceptionHandler;
import cz.zcu.kiv.pia.bikesharing.business.configuration.security.JwtAuthTokenFilter;
import cz.zcu.kiv.pia.bikesharing.business.security.GithubUserAuthenticationProvider;
import cz.zcu.kiv.pia.bikesharing.business.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.Arrays;

/**
 * Configuration for spring security.
 */
@Configuration
@EnableMethodSecurity
public class SecurityConfiguration {
    private final JwtAuthExceptionHandler unauthorizedHandler;
    private final UserService userService;

    @Autowired
    public SecurityConfiguration(JwtAuthExceptionHandler unauthorizedHandler, UserService userService) {
        this.unauthorizedHandler = unauthorizedHandler;
        this.userService = userService;
    }


    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf(AbstractHttpConfigurer::disable)
                .exceptionHandling(exception -> exception.authenticationEntryPoint(unauthorizedHandler))
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(auth -> auth
                        // NOTE: for some reason some requests are denied by JwtAuthTokenFilter, by not having jwt,
                        //  but the jwt should be there (in browser it is). Its possibly caused by receiving some
                        //  automatically generated requests, that didn't go through interceptor to get Authorization header

//                        .requestMatchers("/auth/**").permitAll() // permit everything from auth (login, register, logout)
//                        .requestMatchers(HttpMethod.GET, "/stand").permitAll() // permit getting all stands (so anyone can see them)
//                        .requestMatchers("/error").permitAll() // spring default error endpoint (this is called when something goes wrong)
//                        .anyRequest().authenticated()

                        // permit everything to make it work. Authorization is done by AuthService on each authorized
                        // endpoint instead of using Spring security (this)
                        .anyRequest().permitAll()
                );

        http.addFilterBefore(authenticationJwtTokenFilter(), UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(@NonNull CorsRegistry registry) {
                // this is probably not good practice for production, because this allows anything from anywhere
                registry.addMapping("/**")
                        .allowedOrigins("*")
                        .allowedMethods("*")
                        .allowedHeaders("*");
            }
        };
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationProvider githubUserAuthenticationProvider() {
        return new GithubUserAuthenticationProvider();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();

        authProvider.setUserDetailsService(userService);
        authProvider.setPasswordEncoder(passwordEncoder());

        return authProvider;
    }

    @Bean
    public JwtAuthTokenFilter authenticationJwtTokenFilter() {
        return new JwtAuthTokenFilter();
    }

    @Bean
    public AuthenticationManager authenticationManager() {
        return new ProviderManager(Arrays.asList(authenticationProvider(), githubUserAuthenticationProvider()));
    }
}
