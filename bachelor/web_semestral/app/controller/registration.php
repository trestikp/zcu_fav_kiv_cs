<?php

/**
 * Class Registration handles the registration form and process
 */
class Registration extends Controller {

    /**
     * Default function called. Renders the register form.
     */
    public function index() {
        $reg_cancel = "<input class=\"float-left\" type='button' name='reg_cancel' value='Zrušit registraci' id='reg_cancel'>";
        $html = file_get_contents('../app/view/static/reg_form.html');
        echo $this->twig->render('registration_temp.html', ['obsah' => $html, 'cancel' => $reg_cancel]);
    }

    /**
     * Processes the registration. Saves data to db.
     */
    public function process() {
        $username = $_POST['username'];
        $password = $_POST['password'];
        $email = $_POST['email'];

        echo "$username $password $email";

        if($this->model->username_occupied($username)) {
            echo 1;
            return;
        }

        $this->model->add_user($username, $password, $email);
    }

    /**
     * Renders complete after successful registration.
     */
    public function complete() {
        $html = "<div>
                    <p>Registrace úspěšně dokončena. Nyní se můžete příhlásit a přidávat příspěvky.</p>
                    <input type='button' value='Zpět na Úvod' id='reg_finish'>
                 </div>";
        echo $this->twig->render('registration_temp.html', ['obsah' => $html]);
    }
}