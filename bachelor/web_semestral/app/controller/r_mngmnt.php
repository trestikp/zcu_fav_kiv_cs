<?php

/**
 * Class R_mngmnt handles accepting/ denying reviewes
 */
class R_mngmnt extends Controller {

    /**
     * @var array of ReviewManagment objects holding info about a post and its reviews
     */
    private $objs = array();

    /**
     * Default function called. Shows table of reviews ready to be accepted/ deny. Only allows logged in admins.
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
     * Constructs shown table.
     * @return string table html of posts with review ratings overview and buttons to accept/ deny.
     */
    function construct_table() {
        $html = "";
        $posts = $this->model->get_unpublished_reviewed();
//        $objs = array();

        if (empty($posts)) {
            $html .= "Žádné příspěvky připravené k publikaci.";
            return $html;
        }

        $html .= "\n<table class='table table-striped table-borderless'>\n<tbody>\n";

        for ($i = 0; $i < count($posts); $i++) {
            $this->objs[$i] = new ReviewManagment($posts[$i]['id'], $posts[$i]['title'],
                                            $this->model->get_reviews_of_post($posts[$i]['id']));
        }

        foreach ($this->objs as $item) {
            $html .= "<tr>
                        <td scope='row' class='align-middle'><a href='review_post/".$item->get_id()."'>".$item->get_title()."</a></td>".
//                        <td>".$objs[$i]->get_reviews()[$i]['overall']."</td>
                "<td>".$this->construct_sub_table($item->get_reviews())."</td>".
                "<td>".$this->get_avarage_overall($item->get_reviews())."</td>".
                "<td class='align-middle'>".$item->get_accept()."<br>".$item->get_deny()."</td>\n";
            $html .= "</tr>\n";
        }


        $html .= "</tbody>\n</table>\n";

        return $html;
    }

    /**
     * Constructs subtable that shows review overview.
     * @param $reviews reviews to be shown
     * @return string html table of review overview
     */
    function construct_sub_table($reviews) {
        $html = "\n<table class='table-sm'>
                    <tr>".
//                       <th>recenzent</th>
                       "<th>jaz.</th>
                       <th>téma</th>
                       <th>kval.</th>
                       <th>celk.</th>
                    </tr>";

        foreach ($reviews as $review) {
            $html .= "<tr>".
//                        <td>" . $review['username'] . "</td>
                        "<td>" . $review['criterium1'] . "</td>
                        <td>" . $review['criterium2'] . "</td>
                        <td>" . $review['criterium3'] . "</td>
                        <td>" . $review['overall'] . "</td>".
//                        <td><a href='' class='show-review' id='r_show_".$review['id']."'>Zobrazit</a></td>
                "<td><button class='button-link show-review' name='r_show_".$review['id']."'>Zobrazit</button></td>"
                    ."</tr>
                      <tr hidden>
                        <td>
                            <span class='r_shower_".$review['id']."'>text</span>
                        </td>
                      </tr>";
        }

         $html .= "</table>";

        return $html;
    }

    /**
     * Action to show full review from the subtable
     */
    public function show_review() {
        $id = $_POST['r_id'];
        $review = $this->model->get_review_by_id($id);

        echo $review['text'];
    }

    /**
     * Counts review overall average to make it easier.
     * @param $reviews array
     * @return string returns html table with the average
     */
    function get_avarage_overall($reviews) {
        $sum = 0;
        $cnt = 0;

        foreach ($reviews as $rv) {
            $sum += $rv['overall'];
            $cnt++;
        }

        $html = "<table>\n";
        if ($cnt == 0) {
            $html .= "<tr></tr>\n
                      <tr><th>Celkový průměr</th></tr>\n
                      <tr><td>---</td></tr>\n
                      <tr></tr>\n";
        } else {
            $html .= "<tr><th>Celkový<br>průměr</th></tr>\n
                     <tr><td>".round(($sum / $cnt), 2)."</td></tr>\n";
        }
        $html .= "</table>\n";

        return $html;
    }

    /**
     * Publishes post
     */
    function accept() {
        $p_id = $_POST['p_id'];
        $p_title = $_POST['p_title'];

        $this->model->publish_post($p_id);
    }

    /**
     * Denies post publishing
     */
    function deny() {
        $p_id = $_POST['p_id'];
        $p_title = $_POST['p_title'];

        $this->model->deny_post($p_id);
    }

    /**
     * Finds post by id, title is more or less a confirmation
     * @param $p_id post id
     * @param $p_title post title
     * @return mixed posts information
     */
    function find_post($p_id, $p_title) {
        foreach ($this->objs as $item) {
            if ($item->get_id() == $p_id && $item->get_title() == $p_title) {
                return $item;
            }
        }
    }
}

/**
 * Class ReviewManagment information container
 */
class ReviewManagment {
    /**
     * @var post id
     */
    private $p_id;

    /**
     * @var post title
     */
    private $p_title;

    /**
     * @var array of reviews
     */
    private $reviews = array();

    /**
     * @var accept button html
     */
    private $accept_btn;

    /**
     * @var denies button html
     */
    private $deny_btn;

    /**
     * ReviewManagment constructor. Constructs the class and constructs buttons.
     * @param $p_id
     * @param $p_title
     * @param $reviews
     */
    function __construct($p_id, $p_title, $reviews) {
        $this->p_id = $p_id;
        $this->p_title = $p_title;
        $this->reviews = $reviews;
        $this->construct_accept();
        $this->construct_deny();
    }

    /**
     * constructs the html of the accept button
     */
    function construct_accept() {
        $this->accept_btn = "<input class='w-100 accept-button  ' type='button' id='r_accept_".$this->p_id."_".$this->p_title."' value='Přijmout'
                             class='r_manage_btn'>";
    }

    /**
     * constructs the html of the deny button
     */
    function construct_deny() {
        $this->deny_btn = "<input class='w-100 deny-button' type='button' id='r_deny_".$this->p_id."_".$this->p_title."' value='Zamítnout'
                           class='r_manage_btn'>";
    }

    /**
     * @return array of reviews
     */
    function get_reviews() {
        return $this->reviews;
    }

    /**
     * @return accept button html
     */
    function get_accept() {
        return $this->accept_btn;
    }

    /**
     * @return deny button html
     */
    function get_deny() {
        return $this->deny_btn;
    }

    /**
     * @return post title
     */
    function get_title() {
        return $this->p_title;
    }

    /**
     * @return post id
     */
    function get_id() {
        return $this->p_id;
    }
}