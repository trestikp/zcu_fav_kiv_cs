package cz.zcu.kiv.pia.bikesharing.business.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.Period;

/**
 * Configuration for custom beans.
 */
@Configuration
public class BeanConfiguration {

    /**
     * Reads service interval for bikes in months from properties file.
     * @param serviceInterval service interval in months
     * @return Period object representing service interval
     */
    @Bean
    public Period serviceInterval(@Value("${bike.service-interval}") int serviceInterval) {
        return Period.ofMonths(serviceInterval);
    }
}
