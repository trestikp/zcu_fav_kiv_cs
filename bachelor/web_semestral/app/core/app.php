<?php

/**
 * Class App heart of the whole application. Parses the url and calls (creates) appropriate controllers.
 */
class App {
    /**
     * @var is the controller object/ string - default = home
     */
    protected $controller = 'home';

    /**
     * @var is the function string - default = index
     */
    protected $method = 'index';

    /**
     * @var array of params
     */
    protected $url_params = [];

    /**
     * App constructor.
     */
    public function __construct() {
        $this->parseURL();
        $this->createPage();

        call_user_func_array([$this->controller, $this->method], $this->url_params);
    }

    /**
     * Parses the url to extract controller, method and params
     */
    protected function parseURL() {
        if(isset($_GET['url'])) {


            //$url = explode('/', filter_var(rtrim($_GET['url'], '/')));
            // Need to use $_SERVER['REQUEST_URI'] because $_GET['url'] ignores dots ('.') (atleast at the end)
            $url = explode('/', filter_var(rtrim(urldecode($_SERVER['REQUEST_URI']), '/')));

            // Removing unnecessary information from url
            unset($url[0], $url[1], $url[2]);

            // If controller name is set, checks for existence. Else returns (home stays as default value).
            // Maybe not needed, since checking if url is set?*
            if(isset($url[3])) {
                if(file_exists('../app/controller/'.$url[3].'.php')) {
                    $this->controller = $url[3];
                    unset($url[3]);

                    // If controller is set and exists, checks for existence of method. If second part of url
                    // isn't set, returns, because parameters are not expected.
                    if(isset($url[4])) {
                        $this->method = $url[4];
                        unset($url[4]);

                        // The rest of the array as params
                        $this->url_params = $url ? array_values($url) : [];
                    } else {
                        /* If method isn't set assume index (default) method */
                        $this->method = 'index';
                        return;
                    }
                } else {
                    /* Set to error controller (something like page doesn't exit) */
                    $this->controller = 'my_error';
                    $this->method = 'index';
                }
            } else {
                /* If controller isn't set assume home (default) controller */
                $this->controller = 'home';
                return;
            }
        }
    }

    /**
     * Creates the controller instance
     */
    protected function createPage() {
        /* Already checked for file existence in url parsing */
        require_once '../app/controller/'.$this->controller.'.php';
        $this->controller = new $this->controller;

        /* If acquired method doesn't exists use error method */
        if(!method_exists($this->controller, $this->method)) {
            //TODO: method error
            $this->method = 'index';
        }

        /* Parameter handling? */
        if (!empty($this->url_params)) {
            $this->controller->url_params = $this->url_params;
        }
    }
}