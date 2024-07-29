package robotController.view;

import javafx.beans.binding.NumberBinding;
import javafx.beans.property.DoubleProperty;
import javafx.beans.property.SimpleDoubleProperty;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.ToggleGroup;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.HBox;

public class LayoutCtrl {

    @FXML
    protected ToggleGroup energy_source_grp;
    @FXML
    protected Button turnOnBtn;
    @FXML
    protected Button turnOffBtn;
    @FXML
    protected Button restartBtn;
    @FXML
    protected Button moveForward;
    @FXML
    protected Button rotateLeft;
    @FXML
    protected Button rotateRight;
    @FXML
    protected Button moveBackward;

    @FXML
    public void initialize() {
        // control buttons

        NumberBinding onBtn_w = ((HBox) turnOnBtn.getParent()).widthProperty().multiply(0.4);
        turnOnBtn.prefWidthProperty().bind(onBtn_w);

        NumberBinding offBtn_w = ((HBox) turnOffBtn.getParent()).widthProperty().multiply(0.4);
        turnOffBtn.prefWidthProperty().bind(offBtn_w);

        NumberBinding resBtn_w = ((HBox) restartBtn.getParent()).widthProperty().multiply(0.4);
        restartBtn.prefWidthProperty().bind(resBtn_w);

        // movement buttons

        /*
            Texty jsou incializovany tady, protoze jsem se puvodne pokousel udelat tlacitka s obrazkama, ale uplne to
            nevyslo, ale muzete si je zkusit :)
         */

        moveForward.setText("Forward");
        moveBackward.setText("Backward");
        rotateLeft.setText("Left");
        rotateRight.setText("Right");


        NumberBinding rotLeft_w = ((HBox) rotateLeft.getParent()).widthProperty().multiply(0.8);
        rotateLeft.prefWidthProperty().bind(rotLeft_w);

        NumberBinding rotRight_w = ((HBox) rotateRight.getParent()).widthProperty().multiply(0.8);
        rotateRight.prefWidthProperty().bind(rotRight_w);

        NumberBinding mvFor_w = ((HBox) moveForward.getParent()).widthProperty().multiply(0.6);
        moveForward.prefWidthProperty().bind(mvFor_w);

        NumberBinding mvBack_w = ((HBox) moveBackward.getParent()).widthProperty().multiply(0.6);
        moveBackward.prefWidthProperty().bind(mvBack_w);

        /*
            Chtel jsem udelat tlacitka na movement s obrazkama misto textu, a skoro se povedlo, ale
            po zapnuti tlacitka nejsou spravne nascalovani a nascalujou se spravne az po prejeti po nich/ resizu okna
         */

//        NumberBinding nbf_h = ((HBox) moveForward.getParent()).heightProperty().multiply(0.6);
//        NumberBinding nbf_w = ((HBox) moveForward.getParent()).widthProperty().multiply(0.4);
//        moveForward.prefHeightProperty().bind(nbf_h);
//        moveForward.prefWidthProperty().bind(nbf_w);
//
//        init_button_img(moveForward, "/img/triangle_up.png");
//
//        NumberBinding nbb_h = ((HBox) moveBackward.getParent()).heightProperty().multiply(0.6);
//        NumberBinding nbb_w = ((HBox) moveBackward.getParent()).widthProperty().multiply(0.4);
//        moveBackward.prefHeightProperty().bind(nbb_h);
//        moveBackward.prefWidthProperty().bind(nbb_w);
//
//        init_button_img(moveBackward, "/img/triangle_down.png");
//
//        NumberBinding nbl_h = ((HBox) rotateLeft.getParent()).heightProperty().multiply(0.8);
//        NumberBinding nbl_w = ((HBox) rotateLeft.getParent()).widthProperty().multiply(0.3);
//        rotateLeft.prefHeightProperty().bind(nbl_h);
//        rotateLeft.prefWidthProperty().bind(nbl_w);
//
//        init_button_img(rotateLeft, "/img/arrow_left.png");
//
//        NumberBinding nbr_h = ((HBox) rotateRight.getParent()).heightProperty().multiply(0.8);
//        NumberBinding nbr_w = ((HBox) rotateRight.getParent()).widthProperty().multiply(0.3);
//        rotateRight.prefHeightProperty().bind(nbr_h);
//        rotateRight.prefWidthProperty().bind(nbr_w);
//
//        init_button_img(rotateRight, "/img/arrow_right.png");
    }

    private void init_button_img(Button btn, String img_path) {
        ImageView up = new ImageView(this.getClass().getResource(img_path).toString());
        up.fitWidthProperty().bind(btn.prefWidthProperty());
        up.fitHeightProperty().bind(btn.prefHeightProperty());
        btn.setGraphic(up);
    }
}
