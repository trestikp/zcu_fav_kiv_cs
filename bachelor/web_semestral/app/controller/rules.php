<?php

/**
 * Class Rules shows the rules of the web
 */
class Rules extends Controller {

    /**
     * Default function called. Renders the rules html
     */
    public function index() {
        $this->prepare_parts();
        $this->params['obsah'] = file_get_contents('../app/view/static/rules.html');
        $this->render();
    }
}