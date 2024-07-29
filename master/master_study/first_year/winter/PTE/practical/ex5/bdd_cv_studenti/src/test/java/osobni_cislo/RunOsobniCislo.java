package osobni_cislo;

import org.junit.platform.suite.api.ConfigurationParameter;
import org.junit.platform.suite.api.IncludeEngines;
import org.junit.platform.suite.api.SelectClasspathResource;
import org.junit.platform.suite.api.Suite;

import static io.cucumber.junit.platform.engine.Constants.PLUGIN_PROPERTY_NAME;

@Suite
@IncludeEngines("cucumber")
@SelectClasspathResource("osobni_cislo")
@ConfigurationParameter(key = PLUGIN_PROPERTY_NAME, value = "pretty")
//@ConfigurationParameter(key = "cucumber.filter.tags", value = "@spravne")
//@ConfigurationParameter(key = "cucumber.filter.tags", value = "@zname_chyby")
@ConfigurationParameter(key = "cucumber.filter.tags", value = "@negative_inputs")
//@ConfigurationParameter(key = "cucumber.filter.tags", value = "@negativni")
//@ConfigurationParameter(key = "cucumber.filter.tags", value = "@zahranicni")
//@ConfigurationParameter(key = "cucumber.publish.enabled", value = "true")
public class RunOsobniCislo {
}
