package osobni_cislo;

import io.cucumber.java.AfterAll;
import io.cucumber.java.BeforeAll;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import support.Drivers;
import support.Id;
import support.Utils;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class OsobniCisloStep {

    @BeforeAll
    public static void startWebDriver() {
        Drivers.setWebDriver();
    }

    @AfterAll
    public static void stopWebDriver() {
        Drivers.getDriver().quit();
    }

    @Given("je otevrena stranka generovani")
    public void je_otevrena_stranka_generovani() {
        Utils.otevriStranku();
    }

//    @And("vymaz formular")
//    public void vymaz_formular() {
//
//    }

    @Given("zmackni generovani")
    public void zmackni_generovani() {
        Utils.stiskniTlacitkoGeneruj();
    }

    @Then("vyhozena celkova chyba")
    public void vyhozena_celkova_chyba() {
        assertEquals(Utils.CELKOVA_CHYBA, Utils.textChyby());
    }

    @When("zadam fakulu {word}")
    @When("zadam fakulu {string}")
    public void zadamFakuluFakulta(String fakulta) {
        Utils.setFakulta(fakulta);
    }

    @When("zadam rok {word}")
    @When("zadam rok {string}")
    public void zadamRokRok(String rok) {
        Utils.setRok(rok);
    }

    @When("zadam typ {word}")
    @When("zadam typ {string}")
    public void zadamTypTyp(String typ) {
        Utils.setTyp(typ);
    }

    @When("zadam poradi {word}")
    @When("zadam poradi {string}")
    public void zadamPoradiPoradi(String poradi) {
        Utils.setPoradi(poradi);
    }

    @When("zadam formu {word}")
    @When("zadam formu {string}")
    public void zadamFormuForma(String forma) {
        Utils.setForma(forma);
    }

    @Then("dostanu {word}")
    public void dostanuVysledek(String vysledek) {
        assertEquals(vysledek, Utils.getVysledek());
    }

    @And("zvolim zahranicniho studenta")
    public void zvolimZahranicnihoStudenta() {
        Utils.setZahranicni(true);
    }

    @Then("chyba nevyplnene fakulty")
    public void chybaNevyplneneFakulty() {
        assertEquals("Fakulta nezvolena", Utils.chybaVstupu(Id.GEN_CHYBA_FAKULTA));
    }

    @Then("chyba nevyplnene hodnoty")
    public void chybaNevyplneneHodnoty() {
        assertEquals("Prázdný vstup", Utils.textChyby());
    }

    @Then("chyba nevyplnene formy")
    public void chybaNevyplneneFormy() {
        assertEquals("Forma nezvolena", Utils.chybaVstupu(Id.GEN_CHYBA_FORMA));
    }
}
