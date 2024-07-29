<?php

/**
 * Class Nav constructs nav depending on what role a user is
 */
class Nav {

    /**
     * @var string nav html
     */
    private $nav;

    /**
     * Nav constructor. Initializes nav attribute
     */
    public function __construct() {
        $this->nav = '';
    }

    /**
     * Constructs the nav for a user with a role
     * @param $user role of the user
     * 0 - no user logged in
     * 1 - author is logged in
     * 2 - reviewer is logged in
     * 3 - admin is logged in
     */
    public function create_nav($user) {
        // basically useless if, 0 is (should be) always done
        if(0 <= $user) {
            $this->add_nav_element('/web_semestral/public/home/index', 'Úvod');
            $this->add_nav_element('/web_semestral/public/published/index', 'Příspěvky');
            $this->add_nav_element('/web_semestral/public/rules/index', 'Pravidla');
            $this->add_nav_element('/web_semestral/public/us/index', 'O nás');
        }

        if(1 <= $user) {
            $this->add_nav_element('/web_semestral/public/post/index', 'Přidat příspěvek');
            $this->add_nav_element('/web_semestral/public/my_posts/index', 'Mé příspěvky');
        }

        if(2 <= $user) {
            $this->add_nav_element('/web_semestral/public/review/index', 'Review příspěvku');
        }

        if(3 <= $user) {
            $this->add_nav_element('/web_semestral/public/r_assignment/index',
                                    'Přiřaď recenzenty k příspěvkům');
            $this->add_nav_element('/web_semestral/public/r_mngmnt/index', 'Správa příspěvků');
            $this->add_nav_element('/web_semestral/public/user_mngmnt/index', 'Správa uživatelů');
        }
    }

    /**
     * Returns nav
     * @return string nav html
     */
    public function get_nav() {
        return $this->nav;
    }

    /**
     * Adds html to @nav
     * @param $href target of the nav
     * @param $title name of the nav
     */
    private function add_nav_element($href, $title) {
//        if ($title == $_SESSION['active_l']) {
//            $this->nav = $this->nav."<li class='page nav-item list-unstyled'>
//                                 <a id='link' class='nav-link navigation-link active' href=$href>$title</a></li>\n";
//        } else {
//            $this->nav = $this->nav."<li class='page nav-item list-unstyled'>
//                                 <a id='link' class='nav-link navigation-link' href=$href>$title</a></li>\n";
//        }
        $this->nav = $this->nav."<li class='page nav-item list-unstyled'>
                                 <a id='link' class='nav-link navigation-link' href=$href>$title</a></li>\n";
    }
}