package model;

import javafx.beans.binding.ObjectBinding;
import javafx.beans.property.*;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontPosture;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;

public class MyFont implements Cloneable {

    private final StringProperty name = new SimpleStringProperty();
    private final ObjectProperty<Color> color = new SimpleObjectProperty<>();
    private final ObjectProperty<Emphasis> emphasis = new SimpleObjectProperty<>();
    private final IntegerProperty size = new SimpleIntegerProperty();
    private final BooleanProperty visibility = new SimpleBooleanProperty();

    private final ObjectBinding<Text> preview = new ObjectBinding<Text>() {
        {
            bind(name, color, emphasis, size, visibility);
        }

        @Override
        protected Text computeValue() {
            if(name.getValue() == null || color.getValue() == null || emphasis.getValue() == null ||
               size.getValue() == null || visibility.getValue() == null) {
                return null;
            } else {
                Text out = new Text();

                out.setText("Text Preview");
                switch (emphasis.get()) {
                    case PLAIN: out.setFont(Font.font(name.get(), size.get())); break;
                    case ITALIC: out.setFont(Font.font(name.get(), FontPosture.ITALIC, size.get())); break;
                    case BOLD: out.setFont(Font.font(name.get(), FontWeight.BOLD, size.get())); break;
                }
                out.setVisible(visibility.get());
                out.setStyle("-fx-fill: #" + color.get().toString().substring(2) + ";");

                return out;
            }
        }
    };

    public MyFont(String name, Color color, Emphasis emphasis, int size, boolean visibility) {
        this.name.set(name);
        this.color.set(color);
        this.emphasis.set(emphasis);
        this.size.set(size);
        this.visibility.set(visibility);
    }

    public String getName() {
        return name.get();
    }

    public StringProperty nameProperty() {
        return name;
    }

    public Color getColor() {
        return color.get();
    }

    public ObjectProperty<Color> colorProperty() {
        return color;
    }

    public Emphasis getEmphasis() {
        return emphasis.get();
    }

    public ObjectProperty<Emphasis> emphasisProperty() {
        return emphasis;
    }

    public int getSize() {
        return size.get();
    }

    public IntegerProperty sizeProperty() {
        return size;
    }

    public boolean isVisibility() {
        return visibility.get();
    }

    public BooleanProperty visibilityProperty() {
        return visibility;
    }

    public Text getPreview() {
        return preview.get();
    }

    public ObjectBinding<Text> previewProperty() {
        return preview;
    }

    @Override
    public String toString() {
        return name.get() + " of size " + size.get() + " in style " + emphasis.get() + " with color " + color.get() +
                " is " + (visibility.get() ? "visible" : "invisible");
    }

    public void setColor(Color color) {
        this.color.set(color);
    }

    @Override
    public MyFont clone() throws CloneNotSupportedException {
        return new MyFont(this.getName(), this.getColor(), this.getEmphasis(), this.getSize(), this.isVisibility());
    }
}