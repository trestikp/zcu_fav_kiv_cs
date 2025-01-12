package cz.zcu.kiv.pia.bikesharing;

import org.slf4j.Logger;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;

import static org.slf4j.LoggerFactory.getLogger;

@SpringBootApplication
public class BikesharingApplication extends SpringBootServletInitializer {
    private static final Logger logger = getLogger(BikesharingApplication.class);

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(BikesharingApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(BikesharingApplication.class, args);
    }

    // prints all registered beans whenever application context is refreshed - most commonly on application startup
    @EventListener
    public void onContextRefreshed(ContextRefreshedEvent event) {
        logger.info("*************** APPLICATION CONTEXT REFRESHED ***************");

        for (String beanName : event.getApplicationContext().getBeanDefinitionNames()) {
            logger.info(beanName);
        }
    }

}
