package game.game_hard;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.text.Font;
import javafx.stage.Stage;

import java.io.IOException;

public class MainMenu {
    private Stage stage;

    @FXML
    private void handleBtn() throws IOException {
        stage = Main.getStage();
        dead();
        // stage.close(); // Removed for JPro compatibility
    }

    protected void dead() throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("gate1.fxml"));
        Parent root = loader.load();
        Scene scene = new Scene(root);
        // Stage stage = new Stage(); // Removed for JPro compatibility
        
        // Use the existing stage
        if (stage == null) {
            stage = Main.getStage();
        }

        Animation controller = loader.getController();
        controller.setStage(stage);
        controller.initialize(scene);

        stage.setScene(scene);
        stage.setTitle("Gate1");
        stage.show();
    }
}
