<?php

/**
 * Class LoginForm is a class that constructs the html for login form and changes the login form html
 * to a logged in user when user logs in
 */
class LoginForm {

    /**
     * @var bool|string log form html
     */
    private $log_form;

    /**
     * LoginForm constructor. Loads the form from a html file.
     */
    public function __construct() {
        $this->log_form = file_get_contents('../app/view/static/login_form.html');
    }

    /**
     * @return bool|string returns login form html
     */
    public function get_log_form() {
        return $this->log_form;
    }

    /**
     * Changes login form html to a logged in user line
     * @param $username of logged in user
     */
    public function change_to_logged($username) {
        $this->log_form = "<dl>
                                <dt><p>Přihlášený uživatel: ".$username."</p></dt>
                                <dt><input type='button' name='logout' id='logout' value='Odhlásit'></dt>
                           </dl>";
    }
}