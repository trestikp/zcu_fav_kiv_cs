<?php

/**
 * Class Home is a default class.
 */
class Home extends Controller {

    /**
     * This is the default function of home. If other function isnt specified this is called. Loads home.html.
     */
    public function index() {
        $this->prepare_parts();
        $this->params['obsah'] = file_get_contents('../app/view/static/home.html');
        $this->render();

//        $this->model->submit_post("mock", "ok", null);
    }

    /**
     * Changes the main displayer in the screen to and error state showing that someone is trying to access
     * a destination that is only accessible for logged in users
     */
    public function not_logged_in() {
        $this->prepare_parts();
        $this->params['obsah'] = file_get_contents('../app/view/static/for_logged.html');
        $this->render();
    }

    /**
     * Changes the main displayer in the screen to and error state showing that someone is trying to access
     * a destination that is only accessible for users with higher role (permissions)
     */
    public function insufficient_permissions() {
        $this->prepare_parts();
        $this->params['obsah'] = file_get_contents('../app/view/static/insufficient_role.html');
        $this->render();
    }
}