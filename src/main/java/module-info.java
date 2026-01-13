module game.game_hard {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.desktop;
    requires jpro.webapi;

    opens game.game_hard to javafx.fxml;
    exports game.game_hard;
}