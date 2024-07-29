<?php

/**
 * Class My_error error controller for non-existent controller being accessed or the controller failing to load
 */
class My_error extends Controller {

    /**
     * Default function called. Shows simple html without any template, css nor javascript.
     */
    public function index() {
        echo file_get_contents('../app/view/static/error.html');
    }
}