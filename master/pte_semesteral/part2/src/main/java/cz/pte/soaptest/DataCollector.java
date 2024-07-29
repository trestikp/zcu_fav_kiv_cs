package cz.pte.soaptest;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class DataCollector {
    /**
     * Reads "test_case_run_log_report.xml" file from "soap_res" subdirectory in the project
     * @return List of parsed records
     */
    public static List<Record> loadTestCaseRunLogReportXML() {
        List<Record> records = new ArrayList<>();

        try {
            File inputFile = new File(Constants.RESULT_DIR + File.separator + Constants.RES_MAIN_XML_REPORT);
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(inputFile);
            doc.getDocumentElement().normalize();

            NodeList nList = doc.getElementsByTagName(Constants.RES_MXR_ROOT_NODE);

            for (int i = 0; i < nList.getLength(); i++) {
                Node nNode = nList.item(i);

                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Record r = new Record();

                    for (int j = 0; j < nNode.getAttributes().getLength(); j++) {
                        Node attribute = nNode.getAttributes().item(j);
                        r.setProperty(attribute.getNodeName(), attribute.getNodeValue());
                    }

                    NodeList chList = nNode.getChildNodes();
                    for (int j = 0; j < chList.getLength(); j++) {
                        Node chNode = chList.item(j);
                        if (chNode.getNodeType() == Node.ELEMENT_NODE &&
                            chNode.getNodeName().equals(Constants.RES_MXR_MESSAGE_NODE))
                                r.putMessage(chNode.getTextContent());
                    }

                    records.add(r);
                }
            }

            return records;
        } catch (ParserConfigurationException | SAXException | IOException ex) {
            ex.printStackTrace();
        }

        return records;
    }
}
