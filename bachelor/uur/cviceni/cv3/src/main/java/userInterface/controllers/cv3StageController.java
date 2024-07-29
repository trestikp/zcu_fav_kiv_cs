package userInterface.controllers;

import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ScrollPane;
import javafx.scene.layout.HBox;
import javafx.stage.Stage;

public class cv3StageController {

    final String text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut" +
            " labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi" +
            " ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse" +
            " cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa" +
            " qui officia deserunt mollit anim id est laborum.";

    @FXML
    protected HBox mainPane;

    @FXML
    protected Button showActionsBtn;
    @FXML
    protected Button printTextBtn;
    @FXML
    protected Button changeTitleBtn;
    @FXML
    protected Button addLabelBtn;
    @FXML
    protected Button hideActionsBtn;
    @FXML
    protected ScrollPane labelPane;
    @FXML
    protected Label textLabel;

    private Button[] visibilityVars;
    private boolean buttonsAlreadyShown;
    private int clickedCounter = 0;

    //libilo by se mi to final, ale co nadelam
    private String initialTitle;

    @FXML
    public void initialize() {
        visibilityVars = new Button[]{printTextBtn, changeTitleBtn, addLabelBtn, hideActionsBtn};

        for(Button btn : visibilityVars) {
            btn.setVisible(false);
        }

        buttonsAlreadyShown = false;

        mainPane.getChildren().removeIf(n -> n.equals(labelPane));

        //tak to mam lambdu
        printTextBtn.setOnAction(event -> lambdaPrintText());

        //a anon tridu
        changeTitleBtn.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent actionEvent) {
                clickedCounter++;

                ((Stage) changeTitleBtn.getScene().getWindow()).setTitle(initialTitle + " - clicked " + clickedCounter);
            }
        });

        labelPane.widthProperty().addListener((obs, var1, var2) -> labelResizer());
        labelPane.heightProperty().addListener((obs, var1, var2) -> labelResizer());
    }

    /**
     * Scaluje to aspon do sirky, nechce se mi otravovat se scalovanim vysky labelu podle textu, protoze to label neumi
     * sam, takze bych musel nejak pocitat jaka je vyska, kolik je tam textu a podle toho vysku pridavat...
     */
    private void labelResizer() {
        double width = labelPane.getWidth(), height = labelPane.getHeight();

        //20 je magicka konstanta, aby se mi nepridaval slider do strany (vim ze ho muzu disablenout, ale to nechci),
        // mam podezreni ze je treba proto, ze mam marginy 10 ze vsech stran
        textLabel.setPrefSize(width - 20, height);

//        textLabel.resize(width, height);
    }

    /**
     * Zobrazi ostatni akce (tlacitka akci)
     * @param actionEvent
     */
    public void showMoreActions(ActionEvent actionEvent) {
        if(buttonsAlreadyShown) {
            System.err.println("Buttons are already showing!");

            return;
        }

        for(Button btn : visibilityVars) {
            btn.setVisible(true);
        }

        buttonsAlreadyShown = true;
    }

//    public void printTextToConsole(ActionEvent actionEvent) {
//        System.out.println(text.substring(0, 64));
//    }

    /**
     * Obsluha psani do konzole
     */
    private void lambdaPrintText() {
        System.out.println(text.substring(0, 64));
    }

//    public void changeWindowTitle(ActionEvent actionEvent) {
//
//    }

    /**
     * Pomocna metoda k nastaveni/ pridani textu do labelu
     */
    private void setOrAppendText() {
        if(textLabel.getText().equals("")) {
            textLabel.setText(text);
        } else {
            textLabel.setText(textLabel.getText() + "\n" + text);
        }
    }

    /**
     * Prida text do labelu, pokud label (s jeho panem) neni zobrazen (ve scene), prida ho do sceny
     * @param actionEvent
     */
    public void addLabelOrText(ActionEvent actionEvent) {
        if(mainPane.getChildren().contains(labelPane)) {
            setOrAppendText();
        } else {
            setOrAppendText();
            mainPane.getChildren().add(labelPane);
        }
    }

    /**
     * Akce tlacitka na schovani tlacitek krome tlacitka na zobrazeni
     * @param actionEvent
     */
    public void hideMoreActions(ActionEvent actionEvent) {
        if(!buttonsAlreadyShown) {
            System.err.println("Wow you managed to call this event without a button?!");

            return;
        }

        for(Button btn : visibilityVars) {
            btn.setVisible(false);
        }

        buttonsAlreadyShown = false;
    }

    /**
     * Pomocny setter pro nastavovani titlu
     * @param initialTitle puvodni title okna
     */
    public void setInitialTitle(String initialTitle) {
        this.initialTitle = initialTitle;
    }
}
