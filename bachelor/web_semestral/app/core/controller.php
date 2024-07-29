<?php

require_once dirname(__FILE__)."/../controller/nav_subcontroller.php";
require_once dirname(__FILE__)."/../controller/form_subcontroller.php";
require_once dirname(__FILE__)."/../controller/login_controller.php";

/**
 * Class Controller the 'abstract' controller class. Provides the main functions and their parent functions.
 */
class Controller {

    /**
     * @var the instance of twing - the template loader
     */
    protected $twig;

    /**
     * @var Nav the instance of nav (html)
     */
    protected $nav;

    /**
     * @var LoginForm the instance of login form (html)
     */
    protected $log_form;

    /**
     * @var array of params passed through url - loaded through app
     */
    public $url_params = [];

    /**
     * @var array params for the template
     */
    protected $params;

    /**
     * @var instance of the db class
     */
    protected $model;

    /**
     * @var db connection
     */
    protected $db;

    /**
     * Controller constructor.Constructs the controller.
     */
    public function __construct() {
        $this->params = array();
        $this->params['obsah'] = null;
        $this->params['nav'] = null;
        $this->params['log_form'] = null;
        $this->params['log_error'] = null;
        $this->nav = new Nav();
        $this->log_form = new LoginForm();
        $this->createModel();
        $this->loadTemplate();
    }

    /**
     * Creates the template loader
     */
    protected function loadTemplate() {
        require_once '../app/vendor/autoload.php';

        $loader = new Twig\Loader\FilesystemLoader('../app/view/templates');
        $this->twig = new Twig\Environment($loader);
    }

    /**
     * Renders params to template
     */
    protected function render() {
        echo $this->twig->render('main_template.html', array('obsah' => $this->params['obsah'], 'nav' => $this->params['nav'],
                                 'log_form' => $this->params['log_form'], 'log_error' => $this->params['log_error']));
    }

    /**
     * Creates model instance
     */
    protected function createModel() {
        require_once "../app/inc/db_info.php";
        try {
            $this->db = new PDO("mysql:host=".DB_HOST.";dbname=".DB_NAME, DB_USER, DB_PASSWORD);
        } catch (PDOException $e) {
            echo "Database connection failed: " . $e->getMessage();
            return;
        }

        require_once '../app/model/model.php';
        $this->model = new Model($this->db);
    }

    /**
     * Prepares some parts rendered in the template. Nav and log form.
     */
    protected function prepare_parts() {
        // generate appropriate nav
        if (isset($_SESSION["logged"]) && $_SESSION["logged"] == true) {
            switch ($_SESSION["role"]) {
                // if author is logged in
                case 1: $this->nav->create_nav(1); break;
                // if reviewer is logged in
                case 2: $this->nav->create_nav(2); break;
                // admin logged in
                case 3: $this->nav->create_nav(3); break;
            }
        } else {
            $this->nav->create_nav(0);
        }
        $this->params['nav'] = $this->nav->get_nav();

        // generate appropriate "form"
        if(isset($_SESSION["logged"]) && $_SESSION["logged"] == true) {
            $this->log_form->change_to_logged($_SESSION["username"]);
        } else {
            $this->log_form->__construct();
        }
        $this->params['log_form'] = $this->log_form->get_log_form();
    }

//    function active_nav_link() {
//        $_SESSION['active_l'] = $_POST['active_l'];
//    }
}