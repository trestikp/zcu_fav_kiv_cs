package userInterface;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import userInterface.controllers.cv3StageController;

import java.io.IOException;

/**
 * Java verze 1.8 - pro jednoduchost -> neni nutnost pouzivat moduly a pridavat fx knihovnu (jsem na to linej, abych
 * to delal pro kazdy cviceni)
 *
 * Vytvoril jsem to na Linuxu, kde mam pouze WM, takze si nejsem uplne jistej jak to bude vypadat na Win, po otevreni...
 * snad v pohode (melo by byt)
 */
public class Launcher extends Application {

    @Override
    public void start(Stage stage) throws Exception {
        FXMLLoader loader = new FXMLLoader(this.getClass().getResource("/fxml/cv3Stage.fxml"));

        try {
            Parent pane = loader.load();

            stage.setTitle("UUR - cv3 - Pavel Trestik - A17B0380P");

            //nebudu kecat, ze by se mi to libilo, ale je to asi(?) nejlepsi reseni
            ((cv3StageController) loader.getController()).setInitialTitle(stage.getTitle());

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
