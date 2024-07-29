package core;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;


/**
 * Java 11.0.10 a JavaFX 11.0.2, nezapomente pridat cestu k FX ;)
 */
public class Launcher extends Application {

    @Override
    public void start(Stage stage) throws Exception {
        FXMLLoader loader = new FXMLLoader(this.getClass().getResource("/fxml/table_layout.fxml"));

        try {
            Parent pane = loader.load();

            stage.setTitle("UUR - cv7 - Pavel Trestik - A17B0380P");

            stage.setMinWidth(800);
            stage.setMinHeight(600);

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
