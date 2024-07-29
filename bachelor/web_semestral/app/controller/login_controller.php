<?php

/**
 * Class Login_controller handles the login form and logs user in
 */
class Login_controller extends Controller {

    /**
     * Verifies wether the user is in database and wether password is correct. echoes error codes to ajax.
     */
    public function verify() {
        $username = $_POST["username"];
        $password = $_POST["password"];

        $rc = $this->model->login($username, $password);

        if ($rc == 3) {
//            $this->params["log_error"] = "<p>Incorrect password!</p>";
            echo 3;
        }
        if ($rc == 1) {
//            $this->params["log_error"] = "<p>User doesn't exist!</p>";
            echo 1;
        }
    }

    /**
     * Refreshes page on successful user login for changes to take place
     */
    function log_in_user() {
        header("Refresh:0");
    }

    /**
     * Logs user out and refreshes page for changes to take place
     */
    function log_out_user() {
        $_SESSION["logged"] = false;
        header("Refresh:0");
    }
}