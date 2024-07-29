package view;

import javafx.scene.control.ColorPicker;
import javafx.scene.control.TableCell;
import javafx.scene.paint.Color;
import model.MyFont;

public class ColorPickerCell extends TableCell<MyFont, Color> {
    ColorPicker picker;

    public ColorPickerCell() {
        picker = new ColorPicker();

        this.itemProperty().bindBidirectional(picker.valueProperty());

        picker.setOnAction(event -> {
            // this is probably better to do in commitEdit? (so the tableview sees it as edit?)
//            this.getTableView().getItems().get(this.getIndex()).setColor(picker.getValue());

            this.commitEdit(picker.getValue());
            this.getTableView().refresh();
        });

        setGraphic(picker);
        picker.prefWidthProperty().bind(this.widthProperty());
    }

    @Override
    protected void updateItem(Color item, boolean empty) {
        super.updateItem(item, empty);

        if(empty) {
            setGraphic(null);
        } else {
            picker.setValue(item);
            setGraphic(picker);
        }
    }

    @Override
    public void commitEdit(Color newValue) {
        super.commitEdit(newValue);

        this.getTableView().getItems().get(this.getIndex()).setColor(newValue);
    }
}
