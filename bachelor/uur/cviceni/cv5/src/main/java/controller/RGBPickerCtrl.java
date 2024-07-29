package controller;

import javafx.beans.binding.Bindings;
import javafx.beans.binding.NumberBinding;
import javafx.fxml.FXML;
import javafx.scene.control.Slider;
import javafx.scene.control.TextField;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.util.converter.NumberStringConverter;
import model.RGBColor;

public class RGBPickerCtrl {

    private RGBColor model_data;

    @FXML
    protected TextField redTF;
    @FXML
    protected Slider redSlider;
    @FXML
    protected TextField greenTF;
    @FXML
    protected Slider greenSlider;
    @FXML
    protected TextField blueTF;
    @FXML
    protected Slider blueSlider;
    @FXML
    protected Rectangle previewRect;
    @FXML
    protected VBox previewPane;


    /**
     *      Nevim jestli si to prectete..., ale v programu je bug, o kterem vim a ani po nekolika hodinach, debugovani
     *      source code FX moc nevim, proc to vznika...
     *
     *      Bug si muzete vyzkouset hodnatama s 0 na zacatku. Napr.: 002333 nebo pouze 02333,
     *      ale (!) zajimave, napriklad 0400, exceptionu nevyhodi......
     *
     *
     *      Tento bug hazi exception, ale program zrejme funguje dal (!)
     */

    @FXML
    public void initialize() {
        model_data = new RGBColor(0, 0, 0);

        /* preview rect */
        NumberBinding nb = previewPane.heightProperty().multiply(0.5);

        previewRect.widthProperty().bind(nb);
        previewRect.heightProperty().bind(nb);

        previewRect.fillProperty().bind(
                Bindings.createObjectBinding(() -> Color.rgb(model_data.getRedValue(),
                model_data.getGreenValue(), model_data.getBlueValue()),
                model_data.getRedProperty(), model_data.getGreenProperty(), model_data.getBlueProperty()));

        /* setup textfield listeners */
        setListenersToTextFields();

        /* connect model with view */
        redSlider.valueProperty().bindBidirectional(model_data.getRedProperty());
        greenSlider.valueProperty().bindBidirectional(model_data.getGreenProperty());
        blueSlider.valueProperty().bindBidirectional(model_data.getBlueProperty());

        NumberStringConverter nsc = new NumberStringConverter();

        redTF.textProperty().bindBidirectional(model_data.getRedProperty(), nsc);
        greenTF.textProperty().bindBidirectional(model_data.getGreenProperty(), nsc);
        blueTF.textProperty().bindBidirectional(model_data.getBlueProperty(), nsc);

//        redTF.textProperty().bindBidirectional(model_data.getRedProperty(), new NumberStringConverter());
//        greenTF.textProperty().bindBidirectional(model_data.getGreenProperty(), new NumberStringConverter());
//        blueTF.textProperty().bindBidirectional(model_data.getBlueProperty(), new NumberStringConverter());
    }

    private void setListenerToTF(TextField tf) {
        tf.textProperty().addListener((obs, oldVal, newVal) -> {
            try {
                if(newVal.equals("")) {
                    return;
                }

                int n = Integer.parseInt(newVal);

                if(n > 255) {
                    tf.setText(Integer.toString(255));
                } else if(n < 0) {
                    tf.setText(Integer.toString(0));
                }
            } catch (NumberFormatException e) {
                tf.setText(oldVal);
            }
        });

        tf.focusedProperty().addListener((obs, oldVal, newVal) -> {
            if(tf.getText().equals("") && !newVal) tf.setText(0 + "");
        });
    }

    private void setListenersToTextFields() {
        setListenerToTF(redTF);
        setListenerToTF(greenTF);
        setListenerToTF(blueTF);
    }
}