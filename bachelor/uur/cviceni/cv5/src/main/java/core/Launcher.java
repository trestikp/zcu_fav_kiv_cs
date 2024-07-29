package core;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;


/**
 *  Java 1.8
 *
 *  Jak jako lidi odevzdavaji verze bez FX?! Delal jsem to v 11, ale odevzdavat 50MB archiv s celym FX, se mi uplne
 *  nezda...
 */
public class Launcher extends Application {

    @Override
    public void start(Stage stage) throws Exception {
        FXMLLoader loader = new FXMLLoader(this.getClass().getResource("/fxml/rgb_picker_layout.fxml"));

        try {
            Parent pane = loader.load();

            stage.setTitle("UUR - cv5 - Pavel Trestik - A17B0380P");

            stage.setMinWidth(900);
            stage.setMinHeight(520);

            stage.setScene(new Scene(pane, 1280, 720));
            stage.show();
        } catch (IOException e) {
            System.err.println("Failed to load .fxml file!\n" + e.getMessage());
//            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        launch(args);
    }
}
