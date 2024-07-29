package logic;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.Node;
import javafx.scene.control.*;
import javafx.scene.input.KeyCode;
import javafx.scene.layout.HBox;
import javafx.util.Callback;
import model.Person;
import model.PersonList;

import java.util.Comparator;
import java.util.Optional;


/**
 * V teto uloze jsem se pokousel udelat 3 vrstvou architekturu, proto jsem nepouzival property a binding na ne
 *
 * Disclaimer: Data nejsou zadnym zpusobem error checkovana, takze je mozne jeden zaznam pridat libovolnekrat.
 *      Jedine co je checked je, ze postCode je cislo
 *
 * Neumi to seradit seznam po zmene jmena primo v ListView, s tim uz se fakt delat nebudu....
 *
 */
public class ListExampleCtrl {

    private final String EDIT_TEXT = "Edit person";
    private final String ADD_TEXT = "Add person";

    private boolean personWasLoaded = false;
    private int lastLoadedIndex = -1;
    private PersonList data;

    @FXML
    protected Button loadBtn;
    @FXML
    protected Button showBtn;
    @FXML
    protected Button removeBtn;
    @FXML
    protected ListView<Person> listView;
    @FXML
    protected Button addEditBtn;
    @FXML
    protected TextField firstTF;
    @FXML
    protected TextField lastTF;
    @FXML
    protected TextField emailTF;
    @FXML
    protected TextField postTF;
    @FXML
    protected Button cancelEditBtn;


    @FXML
    public void initialize() {
        /*
            Tohle jsou jedine bindingy co jsem pouzival. Tyto bindingy ale pouze upravujou view, tudiz by to nemelo
            narusovat 3 vrstvou architekturu... doufam
         */
        loadBtn.prefWidthProperty().bind(((HBox) loadBtn.getParent()).widthProperty().multiply(0.75));
        showBtn.prefWidthProperty().bind(((HBox) showBtn.getParent()).widthProperty().multiply(0.75));
        removeBtn.prefWidthProperty().bind(((HBox) removeBtn.getParent()).widthProperty().multiply(0.75));

        addEditBtn.prefWidthProperty().bind(((HBox) addEditBtn.getParent()).widthProperty().multiply(0.75));
        cancelEditBtn.prefWidthProperty().bind(((HBox) cancelEditBtn.getParent()).widthProperty().multiply(0.75));


        addEditBtn.setText(ADD_TEXT);

        /*
            Pozor!: vsechna data osob jsou nahodne generovana, takze nebudou davat smysl
         */
        data = new PersonList(50);

        /*
            Tohle je jedina vec, kde si nejsem jistej, jestli mi to na "pozadi" nenarusuje 3 vrstvou architekturu
            protoze ja jsem manualne nebindoval data na view, ale nejsem si jisty, co dela setItem(), protoze
            po uprave dat, se data automaticky zmeni i v ListView (bez toho aniz bych to ja musel jakkoliv refreshovat)
         */
        listView.setItems(data.getPersonList());

        listView.setEditable(true);

        // btw, vytvoril jsem vlastni ListCell.... nevim jestli jste to takhle zamysleli, nebo jste chteli, abychom do
        // seznamu davali pouze ObservableList<String> jmen, ale tak... znova uz to delat nechci, dekuju pekne
        listView.setCellFactory(PersonCell.forListView());
    }

    public void loadPersonToEdit(ActionEvent actionEvent) {
        if(listView.getSelectionModel().isEmpty()) {
            showAlert("Failed loading attempt", "Person loading error occurred",
                    "No person was selected. Please select a person", Alert.AlertType.WARNING);

            return;
        }

        lastLoadedIndex = listView.getSelectionModel().getSelectedIndex();
        Person p = listView.getSelectionModel().getSelectedItem();

        firstTF.setText(p.getFirstName());
        lastTF.setText(p.getLastName());
        emailTF.setText(p.getEmail());
        postTF.setText(p.getPostCode() + "");

        personWasLoaded = true;

        addEditBtn.setText(EDIT_TEXT);
    }

    public void showPersonInDialog(ActionEvent actionEvent) {
        if(listView.getSelectionModel().isEmpty()) {
            showAlert("Failed info attempt", "Person loading error occurred",
                    "No person was selected. Please select a person", Alert.AlertType.WARNING);

            return;
        }

        Person p = listView.getSelectionModel().getSelectedItem();

        if(p != null) {
            String text = "First name: " + p.getFirstName() +
                    "\nLast name:" + p.getLastName() +
                    "\nE-mail: " + p.getEmail() +
                    "\nPost code: " + p.getPostCode();

            showAlert("Person information", "All personal information", text, Alert.AlertType.INFORMATION);
        }
    }

    public void removePerson(ActionEvent actionEvent) {
        if(listView.getSelectionModel().isEmpty()) {
            showAlert("Failed deletion attempt", "Person deletion error occurred",
                    "No person was selected. Please select a person", Alert.AlertType.WARNING);

            return;
        }

        int selectedIndex = listView.getSelectionModel().getSelectedIndex();
        Person p = listView.getSelectionModel().getSelectedItem();

        Alert confirmation =  new Alert(Alert.AlertType.CONFIRMATION);

        confirmation.setTitle("Person deletion");
        confirmation.setHeaderText("Do you really wish to delete selected person?");
        confirmation.setContentText("Person to be deleted: " + p.getFirstName() + " " + p.getLastName());

        ButtonType confirm = new ButtonType("Yes, delete");
        ButtonType cancel = new ButtonType("No, cancel");

        //tlacitka a tohle poradi je uprimne spise proto, ze jsem nechtel resit focus na "cancel"
        confirmation.getButtonTypes().setAll(cancel, confirm);

        Optional<ButtonType> res = confirmation.showAndWait();

        if(res.get() == confirm) {
            data.getPersonList().remove(selectedIndex);

            listView.getSelectionModel().clearSelection();

            //if loaded person was removed, make it so it can be added from the loaded values (?)
            personWasLoaded = false;

//            data.printFirstThree();
        } else {
            listView.requestFocus();
        }
    }

    public void AddOrEditPerson(ActionEvent actionEvent) {
        try {
            if(checkForEmptyValues() || !hasEmail()) {
                showAlert("Add or edit error", "Cannot add or edit person. Invalid information",
                        "Please fill all information and ensure correctness", Alert.AlertType.ERROR);

                return;
            }

            if(personWasLoaded) {
                data.getPersonList().set(lastLoadedIndex, new Person(firstTF.getText(), lastTF.getText(),
                        emailTF.getText(), Integer.parseInt(postTF.getText())));

                personWasLoaded = false;

                //jestli bylo zmeneno jmeno -> seradit
                data.getPersonList().sort(Comparator.comparing(Person::getFirstName));

//                data.printFirstThree();
            } else {
                data.getPersonList().add(new Person(firstTF.getText(), lastTF.getText(),
                        emailTF.getText(), Integer.parseInt(postTF.getText())));

                data.getPersonList().sort(Comparator.comparing(Person::getFirstName));
            }

            resetTextFields();
            addEditBtn.setText(ADD_TEXT);
        } catch (NumberFormatException e) {
            markTextFieldError(postTF);

            showAlert("Information error", "One or more of requested information is incorrect",
                    "Please check entered information and retry", Alert.AlertType.ERROR);
        }
    }

    public void cancelEditMode(ActionEvent actionEvent) {
        resetTextFields();

        addEditBtn.setText(ADD_TEXT);

        personWasLoaded = false;
    }


    /********************************************************************************************
     *                                                                                          *
     *         private metody                                                                   *
     *                                                                                          *
     ********************************************************************************************/


    private boolean checkForEmptyValues() {
        TextField arr[] = new TextField[]{firstTF, lastTF, emailTF, postTF};

        for(TextField tf : arr) {
            if(tf.getText().equals("")) {
                return true;
            }
        }

        return false;
    }

    private boolean hasEmail() {
        if(!emailTF.getText().contains("@")) {
            markTextFieldError(emailTF);

            return false;
        }

        return true;
    }

    private void resetTextFields() {
        firstTF.setText("");
        lastTF.setText("");
        emailTF.setText("");
        postTF.setText("");

        postTF.setStyle("-fx-border-style: none");
        emailTF.setStyle("-fx-border-style: none");
    }

    private void markTextFieldError(TextField tf) {
        tf.setStyle("-fx-border-style: solid");
        tf.setStyle("-fx-border-width: 2");
        tf.setStyle("-fx-border-color: RED");
    }

    private void showAlert(String title, String header, String content, Alert.AlertType type) {
        Alert a = new Alert(type);

        a.setTitle(title);
        a.setHeaderText(header);
        a.setContentText(content);

        a.show();
    }
}




/**
 *  POZOR!!! POZOR!!! DALSI (PRIVATNI) TRIDA
 *
 * Vlastni ListCell, ktera je upravena v podstate TextFieldListCell
 *
 */
class PersonCell extends ListCell<Person> {

    private TextField textField;


    public static Callback<ListView<Person>, ListCell<Person>> forListView() {
        return list -> new PersonCell();
    }

    @Override
    protected void updateItem(Person item, boolean empty) {
        if(!empty) {
            this.setText(item.toString());
        }

        super.updateItem(item, empty);
    }

    @Override
    public void startEdit() {
        if (! isEditable() || ! getListView().isEditable()) {
            return;
        }
        super.startEdit();

        if (isEditing()) {
            if (textField == null) {
                textField = createTextField(this);
            }

            startEdit(this, null, null, textField);
        }
    }

    @Override
    public void cancelEdit() {
        super.cancelEdit();
        cancelEdit(this, null);
    }


    /****************************************************************************************************
     *                                                                                                  *
     *           Nasledujici metody jsou upravene kopie metod ze tridy CellUtils                        *
     *                                                                                                  *
     ****************************************************************************************************/

    private TextField createTextField(Cell<Person> cell) {
//        final TextField textField = new TextField(getItemText(cell, converter));
        Person p = cell.getItem();

        final TextField textField = new TextField(p.toString());

        // Use onAction here rather than onKeyReleased (with check for Enter),
        // as otherwise we encounter RT-34685
        textField.setOnAction(event -> {
            String[] parts = textField.getText().split(" ");

            if(parts.length == 2) {
                p.setFirstName(parts[0]);
                p.setLastName(parts[1]);
            } else {
                Alert a = new Alert(Alert.AlertType.WARNING);

                a.setTitle("Name edit failed");
                a.setHeaderText("Failed to edit name");
                a.setContentText("Only accepting first name and last name separated by space." +
                        " Please input name in that format");

                a.show();
            }

            cell.commitEdit(p);

            event.consume();
        });
        textField.setOnKeyReleased(t -> {
            if (t.getCode() == KeyCode.ESCAPE) {
                cell.cancelEdit();
                t.consume();
            }
        });
        return textField;
    }

    private void startEdit(Cell<Person> cell, HBox hbox, Node graphic, TextField textField) {
        if (textField != null) {
//            textField.setText(getItemText(cell, converter));
            textField.setText(cell.getItem().toString());
        }
        cell.setText(null);

        if (graphic != null) {
            hbox.getChildren().setAll(graphic, textField);
            cell.setGraphic(hbox);
        } else {
            cell.setGraphic(textField);
        }

        textField.selectAll();

        // requesting focus so that key input can immediately go into the
        // TextField (see RT-28132)
        textField.requestFocus();
    }

    private void cancelEdit(Cell<Person> cell, Node graphic) {
        cell.setText(cell.getItem().toString());
        cell.setGraphic(graphic);
    }
}
