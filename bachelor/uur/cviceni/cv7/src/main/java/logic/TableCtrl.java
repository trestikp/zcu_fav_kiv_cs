package logic;

import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.control.cell.ComboBoxTableCell;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.control.cell.TextFieldTableCell;
import javafx.scene.layout.HBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.util.StringConverter;
import javafx.util.converter.BooleanStringConverter;
import model.Emphasis;
import model.FontGenerator;
import model.MyFont;
import view.ColorPickerCell;

public class TableCtrl {

    @FXML
    protected Button infoBtn;
    @FXML
    protected Label infoLbl;
    @FXML
    protected TableView<MyFont> tableView;

    private final ObservableList<MyFont> data = FontGenerator.createData();

    @FXML
    public void initialize() {
        infoBtn.prefWidthProperty().bind(((HBox) infoBtn.getParent()).widthProperty().multiply(0.1));
        infoLbl.prefWidthProperty().bind(((HBox) infoLbl.getParent()).widthProperty().multiply(0.9));

        /*
            Init columns
         */
        TableColumn<MyFont, String> nameCol = new TableColumn<>("Name");
        TableColumn<MyFont, Color> colorCol = new TableColumn<>("Color");
        TableColumn<MyFont, Emphasis> emphasisCol = new TableColumn<>("Emphasis");
        TableColumn<MyFont, Integer> sizeCol = new TableColumn<>("Size");
        TableColumn<MyFont, Boolean> visibilityCol = new TableColumn<>("Visibility");
        TableColumn<MyFont, Text> previewCol = new TableColumn<>("Preview");

        /*
            Bind column values
         */
        nameCol.setCellValueFactory(new PropertyValueFactory<>("name"));
        colorCol.setCellValueFactory(new PropertyValueFactory<>("color"));
        emphasisCol.setCellValueFactory(new PropertyValueFactory<>("emphasis"));
        sizeCol.setCellValueFactory(new PropertyValueFactory<>("size"));
        visibilityCol.setCellValueFactory(new PropertyValueFactory<>("visibility"));
        previewCol.setCellValueFactory(cellData -> cellData.getValue().previewProperty());

        /*
            Make columns editable
         */
        nameCol.setCellFactory(TextFieldTableCell.forTableColumn());

        //Check if new font is in the system
        nameCol.setOnEditCommit(event -> {
            if(!Font.getFamilies().contains(event.getNewValue())) {
                tableView.refresh();
                return;
            } else {
                tableView.getSelectionModel().getSelectedItem().nameProperty().set(event.getNewValue());
            }
        });

        colorCol.setCellFactory(event -> new ColorPickerCell());
        emphasisCol.setCellFactory(ComboBoxTableCell.forTableColumn(Emphasis.values()));
        visibilityCol.setCellFactory(ComboBoxTableCell.forTableColumn(new BooleanStringConverter(),
                                                                      new Boolean[]{true, false}));
        //IntegerStringConverter doesn't handle NumberFormatException
        sizeCol.setCellFactory(TextFieldTableCell.forTableColumn(new StringConverter<Integer>() {
            @Override
            public String toString(Integer object) {
                return object.toString();
            }

            @Override
            public Integer fromString(String string) {
                int current = tableView.getSelectionModel().getSelectedItem().getSize();
                try {
                    int val = Integer.parseInt(string);

                    if(val <= 0) {
                        return current;
                        //dialog or something?
                    }

                    return val;
                } catch (NumberFormatException e) {
                    return current;
                }
            }
        }));

        //attempt to automatically show resized rows, after font size change
//        sizeCol.onEditCommitProperty().addListener(observable -> tableView.refresh());

        /*
            ContextMenu for "Adding" (Copying) and removing items
         */
        tableView.setRowFactory(param -> {
            TableRow<MyFont> row = new TableRow<>();

            row.contextMenuProperty().set(createContextMenu());

            return row;
        });

        /*
            Add columns and data
         */
        tableView.setEditable(true);
        tableView.getColumns().addAll(nameCol, colorCol, emphasisCol, sizeCol, visibilityCol, previewCol);
        tableView.setItems(data);

        /*
            Column widths
         */
        //min sizes
        //min windows size is 800 - paddings, borders and w/e lets say 750
        nameCol.setMinWidth(150);
        colorCol.setMinWidth(70);
        emphasisCol.setMinWidth(95);
        sizeCol.setMinWidth(60);
        visibilityCol.setMinWidth(95);
        previewCol.setMinWidth(280);

        //dynamic sizes
        nameCol.prefWidthProperty().bind(tableView.widthProperty().multiply(0.2));
        colorCol.prefWidthProperty().bind(tableView.widthProperty().multiply(0.12));
        emphasisCol.prefWidthProperty().bind(tableView.widthProperty().multiply(0.15));
        sizeCol.prefWidthProperty().bind(tableView.widthProperty().multiply(0.08));
        visibilityCol.prefWidthProperty().bind(tableView.widthProperty().multiply(0.15));
        previewCol.prefWidthProperty().bind(tableView.widthProperty().multiply(0.3));
    }

    private ContextMenu createContextMenu() {
        ContextMenu cm = new ContextMenu();
        MenuItem copy = new MenuItem("Copy entry");
        MenuItem delete = new MenuItem("Remove entry");

        copy.setOnAction(event -> {
            MyFont item = tableView.getSelectionModel().getSelectedItem();
            int index = tableView.getSelectionModel().getSelectedIndex();

            try {
                data.add(index + 1, item.clone());
            } catch (CloneNotSupportedException e) {
                //again dialog or something would be nice there
                return;
            }
        });

        delete.setOnAction(event -> {
            MyFont item = tableView.getSelectionModel().getSelectedItem();
            data.remove(item);
        });

        cm.getItems().addAll(copy, delete);

        return cm;
    }

    public void showInfo(ActionEvent actionEvent) {
        if(tableView.getSelectionModel().getSelectedItem() != null) {
//            infoLbl.setText(tableView.getSelectionModel().getSelectedItem().toString());
            int index = tableView.getSelectionModel().getSelectedIndex();
            infoLbl.setText(data.get(index).toString());
        } else {
            infoLbl.setText("No font selected (Tip: You can add (copy)/" +
                    " delete fonts through context menu (right click))");
        }
    }
}
