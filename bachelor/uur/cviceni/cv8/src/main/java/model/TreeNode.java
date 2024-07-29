package model;

import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

public class TreeNode {

    private StringProperty name;
    private ObjectProperty<NodeType> type;

    public TreeNode(String name, NodeType type) {
        this.name = new SimpleStringProperty(name);
        this.type = new SimpleObjectProperty<>(type);
    }

    public String getName() {
        return name.get();
    }

    public StringProperty nameProperty() {
        return name;
    }

    public NodeType getType() {
        return type.get();
    }

    public ObjectProperty<NodeType> typeProperty() {
        return type;
    }

    public boolean isFile() {
        return type.getValue() == NodeType.FILE;
    }
}
