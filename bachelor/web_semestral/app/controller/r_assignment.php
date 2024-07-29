<?php

/**
 * Class R_assignment handles reviewer assignment to posts
 */
class R_assignment extends Controller
{

    /**
     * Default function called. Renders table of posts that are waiting to be reviewed. Only accessible for
     * logged in users with role reviewer or admin.
     */
    public function index()
    {
        if ($_SESSION["logged"] == false) {
            header('Location: /web_semestral/public/home/not_logged_in');
        }

        if ($_SESSION['role'] < 3) {
            header('Location: /web_semestral/public/home/insufficient_permissions');
        }

        $this->prepare_parts();
        $html = "<span id='r_assignment_err' style='color: red'></span>";
        $html .= $this->construct_table();
        $this->params['obsah'] = $html;
        $this->render();
    }

    /**
     * Constructs html table of posts that are not published and have less then 3 reviewers.
     * @return string html posts table
     */
    function construct_table()
    {
        $html = "";
        $posts = $this->model->get_review_assignment_posts();

        if (empty($posts)) {
            $html .= "Žádné příspěvky čekající na recenzenty.";
            return $html;
        }

        $html .= "\n<table class='table table-striped'>\n<tbody>\n";
        foreach ($posts as $item) {
            $html .= "<tr>\n
                        <td scope='row' class='align-middle'>" . $item['title'] . "</td>\n";
            $reviewers = $this->model->get_reviewers_of_post($item['id']);
            $html .= "<td>\n<table class='w-100'>\n";
            for ($i = 0; $i < 3; $i++) {
                $html .= "<tr>\n";
                if ($i < count($reviewers)) {
                    $html .= "<td>" . $reviewers[$i]['username'] . "</td>\n";
                    switch ($reviewers[$i]['reviewed']) {
                        case 0:
                            $html .= "<td scope='row'>Zatím nehodnoceno</td>\n";
                            break;
                        case 1:
                            $html .= "<td scope='row'>Ohodnoceno</td>\n";
                            break;
                    }
                } else {
                    $free_r = $this->model->get_free_reviewers($item['id']);
                    $html .= "<td>\n<select id='r_" . $item['id'] . "_select" . $i . "'>\n";
                    $html .= "<option disabled selected value> -- zvolte -- </option>";
                    foreach ($free_r as $rec) {
                        $html .= "<option value=\"" . $rec['id'] . "\">" . $rec['username'] . "</option>\n";
                    }
                    $html .= "</select>\n</td>\n";
                    $html .= "<td>\n
                                <input class='r_adding' type='button' id='r_" . $item['id'] . "_button" . $i . "' value='Přidat recenzeta'>
                              </td>\n";
                }
                $html .= "</tr>\n";
            }
            $html .= "</table>\n</td>\n</tr>\n";
        }
        $html .= "</tbody>\n</table>\n";

        return $html;
    }

    /**
     * Adds a row to the review_queue table = assigning reviewer to a post
     */
    function add_review_queue() {
        $p_id = $_POST['p_id'];
        $r_id = $_POST['r_id'];

        if ($p_id == '' || $r_id == '') {
            echo 1;
            return;
        }

        $this->model->assign_reviewer($r_id, $p_id);

        // if there is at least 3 reviewers assigned to post update state
        $this->review_count_check($p_id);
        echo 0;
    }

    /**
     * Support function checks for number of reviewers assigned to a post, updates the cont if less then 3
     * @param $p_id
     */
    function review_count_check($p_id) {
        $rc = $this->model->get_assigned_review_count($p_id);

        if ($rc['COUNT(*)'] >= 3) {
            $this->model->update_post_state($p_id, 1);
        }
    }
}