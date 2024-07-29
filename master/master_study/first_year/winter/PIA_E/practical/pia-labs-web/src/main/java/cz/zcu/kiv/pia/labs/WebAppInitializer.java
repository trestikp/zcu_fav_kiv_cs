
package cz.zcu.kiv.pia.labs;

import org.springframework.http.server.reactive.HttpHandler;
import org.springframework.http.server.reactive.ServletHttpHandlerAdapter;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.server.adapter.WebHttpHandlerBuilder;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;
import java.nio.charset.StandardCharsets;

public class WebAppInitializer implements WebApplicationInitializer {
    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        // create the 'root' Spring application context
        AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
        rootContext.register(WebAppConfig.class);
        rootContext.refresh();
        rootContext.start();

        // manage the lifecycle of the root application context
        servletContext.addListener(new ContextLoaderListener(rootContext));

        // set default request/response encoding
        servletContext.setRequestCharacterEncoding(StandardCharsets.UTF_8.name());
        servletContext.setResponseCharacterEncoding(StandardCharsets.UTF_8.name());

        // register and map the dispatcher servlet
        HttpHandler httpHandler = WebHttpHandlerBuilder.applicationContext(rootContext).build();
        ServletHttpHandlerAdapter servlet = new ServletHttpHandlerAdapter(httpHandler);

        ServletRegistration.Dynamic servletRegistration = servletContext.addServlet("dispatcher", servlet);
        servletRegistration.addMapping("/spring/*");
        servletRegistration.setLoadOnStartup(1);
        servletRegistration.setAsyncSupported(true);
    }
}
