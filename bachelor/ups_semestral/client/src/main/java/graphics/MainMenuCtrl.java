package graphics;

import game.Action;
import game.Client;
import javafx.application.Platform;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.shape.Ellipse;
import network.Instruction;

import java.io.IOException;

/**
 * FXML controller for file main_menu_disconnected.fxml and main_menu_connected.fmxl.
 * Extends OverlordCtrl and implements CtrlNecessities
 */
public class MainMenuCtrl extends OverlordCtrl implements CtrlNecessities {
    // Status bar elements
    public Ellipse clientConnectCircle;
    public Label responseLabel;
    public Label clientStateLabel;
    public Label clientNameLabel;
    public Label clientConnectionLabel;
    public Ellipse opponentConnectCircle;
    public Label opponentConnectionLabel;
    public Label opponentNameLabel;

    /** Join lobby Button */
    public Button joinLobbyBtn;
    /** Create lobby Button */
    public Button createLobbyBtn;
    /** Disconnect Button */
    public Button disconnectBtn;
    /** Quit Button */
    public Button quitBtn;

    //disconnected buttons
    /** Connect Button */
    public Button connect;
    /** About Button */
    public Button aboutBtn;

    /**
     * Called when creating instance. Used to get client instance from Handler
     */
    @FXML
    public void initialize() {
        client = Handler.getClient();

        setClient(client);
    }

    /**
     * Ref. to @CtrlNecessities
     * @param client instance
     */
    @Override
    public void setClient(Client client) {
//        setClient(client, statusController);
        StatusBar status = new StatusBar(clientConnectCircle, responseLabel, clientStateLabel, clientNameLabel,
                clientConnectionLabel, opponentConnectCircle, opponentConnectionLabel, opponentNameLabel);
        setClient(client, status);
    }

    /**
     * Button action for about screen. Loads about fxml. Doesn't set client connection
     * @param actionEvent autogenerated, isn't used
     */
    public void about(ActionEvent actionEvent) {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/fxml_res/about.fxml"));
        Parent pane;

        try {
            pane = loader.load();
        } catch (IOException e) {
            //TODO: logger
            System.out.println("Failed to load fxml");
            return;
        }

        Handler.setScene(new Scene(pane, Handler.getPrimaryStage().getWidth(), Handler.getPrimaryStage().getHeight()));
    }

    /**
     * Switcher Scene to connection_picker.fxml
     * @param actionEvent autogenerated, isn't used
     */
    public void connect(ActionEvent actionEvent) {
        genericSetScene("connection_picker.fxml");

        if(client.getAutomaton().validateTransition(Action.CONNECT)) {
            client.getAutomaton().makeTransition(Action.CONNECT);
        } else {
            responseLabel.setText("Invalid automaton transition");
        }
    }

    /**
     * Sets instruction to disconnect from the server
     * @param actionEvent autogenerated, isn't used
     */
    public void disconnect(ActionEvent actionEvent) {
        client.setInstruction(Instruction.DISCONNECT);
    }

    public void quit(ActionEvent actionEvent) {
        if(client.isClientConnected()) {
            client.setInstruction(Instruction.DISCONNECT);
            client.setQuitAfterDisconnect(true);
        } else {
            if(client.getAutomaton().validateTransition(Action.QUIT)) {
                client.getAutomaton().makeTransition(Action.QUIT);
            } else {
                responseLabel.setText("Invalid automaton transition");
            }

            System.exit(0);
        }
    }

    /**
     * Switcher to lobby_creation.fxml
     * @param actionEvent autogenerated, isn't used
     */
    public void createLobby(ActionEvent actionEvent) {
        if(client.getAutomaton().validateTransition(Action.CREATE)) {
            client.getAutomaton().makeTransition(Action.CREATE);
            genericSetScene("lobby_creation.fxml");
        } else {
            responseLabel.setText("Automaton: transition validation failed");
        }
    }

    /**
     * Switcher scene to lobby_list.fxml
     * @param actionEvent autogenerated, isn't used
     */
    public void joinLobby(ActionEvent actionEvent) {
        client.setInstruction(Instruction.LOBBY);
    }
}