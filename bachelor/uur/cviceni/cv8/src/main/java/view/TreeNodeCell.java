package view;

import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.scene.control.TreeCell;
import javafx.scene.image.ImageView;
import javafx.scene.input.KeyCode;
import model.TreeNode;

public class TreeNodeCell extends TreeCell<TreeNode> {
    private TextField tf;

    @Override
    public void startEdit() {
        super.startEdit();

        if(tf == null) {
            tf = new TextField();

            tf.setOnKeyReleased(event -> {
                if(event.getCode() == KeyCode.ENTER) {
                    TreeNode nd = this.getItem();
                    nd.nameProperty().set(tf.getText());
                    commitEdit(nd);
                    setGraphic(null);
                }
            });
        }

        setText(null);
        tf.setText(this.getItem().getName());
        setGraphic(tf);
    }

    @Override
    public void cancelEdit() {
        super.cancelEdit();

        setGraphic(null);
        //TODO format
        this.setText(this.getItem().getName());
    }

    @Override
    protected void updateItem(TreeNode item, boolean empty) {
        super.updateItem(item, empty);

        if(empty) {
            setText(null);
            setGraphic(null);
        } else {
            if(this.isEditing()) {
                if(tf != null) {
                    tf.setText(item.getName());
                    this.setText(null);
                    setGraphic(tf);
                }
            } else {
                this.setText(item.getName());
                setGraphic(createIcon());
            }
        }
    }

    @Override
    public void commitEdit(TreeNode newValue) {
        if(newValue.getName().equals("")) {
            Alert a = new Alert(Alert.AlertType.ERROR);

            a.setTitle("Node edit error");
            a.setHeaderText("Cannot save this change");
            a.setContentText("Name mustn't be empty!");

            a.showAndWait();
        } else {
            super.commitEdit(newValue);

            this.getTreeView().refresh();
        }
    }

    private ImageView createIcon() {
        ImageView icon;

        switch (this.getItem().getType()) {
            case FILE: icon = new ImageView(String.valueOf(this.getClass().getResource("/img/file_icon.png"))); break;
            case DIR: icon = new ImageView(String.valueOf(this.getClass().getResource("/img/dir_icon.png"))); break;
            default:
                throw new IllegalStateException("Unexpected value: " + this.getItem().getType());
        }

        icon.setFitHeight(30);
        icon.preserveRatioProperty().set(true);

        return icon;
    }
}