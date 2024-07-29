<?php

/**
 * Class user_mngmnt class handles user managment. Admin can alter user role.
 */
class user_mngmnt extends Controller {

    /**
     * Default function called. Renders a table of users with a drop list and button for each of them to set a new role.
     */
    public function index() {
        if ($_SESSION["logged"] == false) {
            header('Location: /web_semestral/public/home/not_logged_in');
        }

        if ($_SESSION['role'] < 3) {
            header('Location: /web_semestral/public/home/insufficient_permissions');
        }

        $this->prepare_parts();
        $html = $this->construct_table();
        $this->params['obsah'] = $html;
        $this->render();
    }

    /**
     * Constructs table of users.
     * @return string html table with users, drop lists and buttons
     */
    function construct_table() {
        $html = "";
        $users = $this->model->get_all_users();

        $html .= "\n<table class='table table-striped'>\n<tbody>\n";
        foreach ($users as $item){
            $html .= "<tr>\n
                        <td scope='row' class='align-middle role-user'>".$item['username']."</td>\n
                        <td>".$this->construct_select($item['role'])."</td>\n
                        <td><input type='button' value='Změň roli' class='role-changer'></td>\n";
        }
        $html .= "</tbody>\n</table>\n";

        return $html;
    }

    /**
     * Constructs the droplists for the users
     * @param $role Role the user already has
     * @return string html of the drop list
     */
    function construct_select($role) {
        $html = "<select class='role-select'>\n";
        for($i = 1; $i <= 3; $i++) {
            if ($i == $role) {
                switch ($i) {
                    case 1: $html .= "<option value='".$i."' disabled selected value>Autor</option>\n"; break;
                    case 2: $html .= "<option value='".$i."' disabled selected value>Recenzent</option>\n"; break;
                    case 3: $html .= "<option value='".$i."' disabled selected value>Admin</option>\n"; break;
                }
                continue;
            }

            switch ($i) {
                case 1: $html .= "<option value='".$i."'>Autor</option>\n"; break;
                case 2: $html .= "<option value='".$i."'>Recenzent</option>\n"; break;
                case 3: $html .= "<option value='".$i."'>Admin</option>\n"; break;
            }

        }
        $html .= "</select>\n";

        return $html;
    }

    /**
     * Change users role in db
     */
    public function change_role() {
        $username = $_POST['username'];
        $role = $_POST['role'];

        $this->model->alter_role($username, $role);
    }
}