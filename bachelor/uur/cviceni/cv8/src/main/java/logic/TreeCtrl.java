package logic;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import model.NodeType;
import model.TreeNode;
import view.TreeNodeCell;

import java.util.Optional;

public class TreeCtrl {

    @FXML
    protected TreeView<TreeNode> treeView;


    @FXML
    public void initialize() {
        TreeNode root = new TreeNode("Virtual root", NodeType.DIR);
        TreeNode etc = new TreeNode("etc", NodeType.DIR);
        TreeNode usr = new TreeNode("usr", NodeType.DIR);
        TreeNode lib = new TreeNode("lib", NodeType.DIR);
        TreeNode jvm = new TreeNode("jvm", NodeType.DIR);
        TreeNode etc_fstab = new TreeNode("fstab", NodeType.FILE);
        TreeNode etc_resolv = new TreeNode("resolv", NodeType.FILE);
        TreeNode hacked = new TreeNode("Hacked", NodeType.FILE);

        TreeItem<TreeNode> rootItem = new TreeItem<>(root);
        /*--*/TreeItem<TreeNode> etcItem = new TreeItem<>(etc);
        /*-- --*/TreeItem<TreeNode> fstabItem = new TreeItem<>(etc_fstab);
        /*-- --*/TreeItem<TreeNode> resolvItem = new TreeItem<>(etc_resolv);
        /*--*/TreeItem<TreeNode> usrItem = new TreeItem<>(usr);
        /*--*/TreeItem<TreeNode> libItem = new TreeItem<>(lib);
        /*-- --*/TreeItem<TreeNode> jvmItem = new TreeItem<>(jvm);
        /*--*/TreeItem<TreeNode> hackedItem = new TreeItem<>(hacked);

        //noinspection unchecked
        rootItem.getChildren().addAll(etcItem, usrItem, libItem, hackedItem);
        //noinspection unchecked
        etcItem.getChildren().addAll(fstabItem, resolvItem);
        libItem.getChildren().add(jvmItem);

        treeView.setRoot(rootItem);
        treeView.setCellFactory(e -> new TreeNodeCell());
        treeView.setCellFactory(e -> {
            TreeNodeCell item = new TreeNodeCell();

            item.contextMenuProperty().set(createContextMenu());

            return item;
        });
    }

    private ContextMenu createContextMenu() {
        ContextMenu menu = new ContextMenu();
        MenuItem createDir = new MenuItem("Create dir");
        MenuItem createFile = new MenuItem("Create file");
        MenuItem delete = new MenuItem("Remove node");

        createFile.setOnAction(e -> createNode(NodeType.FILE));
        createDir.setOnAction(e -> createNode(NodeType.DIR));
        delete.setOnAction(this::removeNode);

        menu.getItems().addAll(createDir, createFile, delete);

        return menu;
    }

    private void createNode(NodeType type) {
        TreeItem<TreeNode> selected = treeView.getSelectionModel().getSelectedItem();

        if(selected.getValue().isFile()) {
            showAlert("Node creation error", "Cannot create node",
                    "The parent node is a file! Cannot create children for a file.", Alert.AlertType.ERROR);
            return;
        }

        //// START
        /*
            Puvodne jsem chtel udelat, ze nova polozka nema jmeno a po vytvoreni se zacne editovat (startEdit),
            bohuzel to se mi nevydarilo, takze delam nejake genericke jmena
         */

        String name;

        if(type == NodeType.DIR) {
            name = "NewDir";
        } else {
            name = "NewFile";
        }

        int counter = 0;
        for(var i : selected.getChildren()) {
            if(i.getValue().getName().matches(name + "\\d+") || i.getValue().getName().matches(name)) {
                counter++;
            }
        }
        name += counter;

        //// END

        TreeItem<TreeNode> ti = new TreeItem<>(new TreeNode(name, type));

        selected.getChildren().add(ti);
        selected.setExpanded(true);

//        treeView.refresh();
    }

    private void removeNode(ActionEvent event) {
        TreeItem<TreeNode> item = treeView.getSelectionModel().getSelectedItem();

        if(item == treeView.getRoot()) {
            showAlert("Node removal error", "Cannot remove node",
                    "You cannot remove ROOT node!!!", Alert.AlertType.ERROR);
            return;
        }

        Alert confirmation =  new Alert(Alert.AlertType.CONFIRMATION);

        confirmation.setTitle("Node deletion");
        confirmation.setHeaderText("Do you wish to delete selected node and all its children?");
        confirmation.setContentText("Node " + item.getValue().getName() + " and all its children will be" +
                " irreversibly removed");

        ButtonType confirm = new ButtonType("Yes, delete");
        ButtonType cancel = new ButtonType("No, cancel");

        confirmation.getButtonTypes().setAll(cancel, confirm);

        Optional<ButtonType> res = confirmation.showAndWait();

        if(res.get() == confirm) {
            item.getParent().getChildren().remove(item);

            treeView.getSelectionModel().clearSelection();
        }
    }

    private void showAlert(String title, String header, String content, Alert.AlertType type) {
        Alert a = new Alert(type);

        a.setTitle(title);
        a.setHeaderText(header);
        a.setContentText(content);

        a.show();
    }
}
