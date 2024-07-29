package cz.pte.soaptest;

import java.util.HashMap;
import java.util.Map;

public class Constants {
    // test suites (keys) and test cases (values in array)
    public static final Map<String, String[]> testMap;

    static {
        testMap = new HashMap<>();
        testMap.put("TS.01 Zalozeni zaznamu kocky",
                new String[]{"TC.01.01 Novy zaznam"});
        testMap.put("TS.02 Exsitence zaznamu kocky",
                new String[]{"TC.02.01 Jmeno kocky", "TC.02.02 Vlastnosti kocky", "TC.02.03 ID zaznamu"});
        testMap.put("TS.03 Vsechna zvirata",
                new String[]{"TC.03.01 Pablo je tam"});
        testMap.put("TS.04 Vymazani zaznamu kocky",
                new String[]{"TC.04.01 Vymazani zaznamu"});
        testMap.put("TS.05 Zalozeni uzivatele",
                new String[]{"TC.05.01 Novy zaznam"});
        testMap.put("TS.06 Prihlaseni a odhlaseni uzivatele",
                new String[]{"TC.06.01 Prihlaseni", "TC.06.01 Odhlaseni"});
        testMap.put("TS.07 Testy k selhani",
                new String[]{"TC.07.01 Pablo je v sold", "TC.07.02 Vlastnosti kocky spatne"});
    }

    // running soapui tests
    public static final String CURRENT_DIR          = ".";
    public static final String RUN_SOAPUI_SCRIPT    = "run_soapui.sh";

    // test results
    public static final String RESULT_DIR           = "soap_res";
    public static final String RES_MAIN_XML_REPORT  = "test_case_run_log_report.xml";
    public static final String RES_MXR_ROOT_NODE    = "con:testCaseRunLogTestStep";
    public static final String RES_MXR_MESSAGE_NODE = "con:message";

    public static final String REC_PROP_TIMESTAMP   = "timestamp";
    public static final String REC_PROP_CONTENT_LEN = "contentLength";
    public static final String REC_PROP_TTF_BYTE   = "timeToFirstByte";
}
