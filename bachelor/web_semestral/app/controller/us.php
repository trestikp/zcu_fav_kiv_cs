<?php

/**
 * Class Us shows the about us html
 */
class Us extends Controller {

    /**
     * Default function called.
     */
    public function index() {
        $this->prepare_parts();
        $this->params['obsah'] = file_get_contents('../app/view/static/us.html');
        $this->render();
    }
}