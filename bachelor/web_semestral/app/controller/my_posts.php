<?php

/**
 * Class My_posts is a controller to show posts of a logged in user (no matter the sate)
 */
class My_posts extends Controller {

    /**
     * Default function called. No accessible for logged out users.
     */
    public function index() {
        if ($_SESSION["logged"] == false) {
            header('Location: /web_semestral/public/home/not_logged_in');
        }

        $this->prepare_parts();
        $html = $this->construct_posts();
        $this->params['obsah'] = $html;
        $this->render();
    }

    /**
     * This function is identical to published read_post()
     * The thought is changing this to allow post editing.
     */
    public function read_my_post() {
        if ($_SESSION["logged"] == false) {
            header('Location: /web_semestral/public/home/not_logged_in');
        }

        $this->prepare_parts();
        //gets specific post by title
        $posts = $this->model->get_post_by_title($this->url_params[0]);

        if (count($posts) <= 0) {
            $html = file_get_contents('../app/view/static/post_error.html');
            $this->params['obsah'] = $html;
            $this->render();
            return;
        }

        //presuming only one post with the same title name and author
        $author = $posts[0]["username"];
        $title = $posts[0]["title"];
        $text = $posts[0]["text"];

        $file_html = '';
        if ($posts[0]['file'] != '') {
            $file_html = '<div><b>Soubor pdf: </b>';
            $file = $posts[0]["file"];

            if (file_exists("../app/uploads/$file"))
                $file_html .= "<embed src=\"/web_semestral/app/uploads/$file\" type='application/pdf'
                                width='100%' height='1080px'/>";
            else
                $file_html .= "Tento příspěvek měl připnutý pdf soubor.
                                    Tento soubor se ale bohužel nepodařilo otevřít.";
        }
        $file_html .= '</div>';

        $html = $this->twig->render('post_reader.html', ["post_title" => $title,
            "author" => $author, "post_text" => $text,
            "post_file" => $file_html]);
        $this->params['obsah'] = $html;
        $this->render();
    }

    /**
     * Constructs a string that makes a html of a table with all users posts
     * @return string html of a user post table
     */
    function construct_posts() {
        $html = "";
        // gets all users posts from db
        $posts = $this->model->get_users_posts();

        if (empty($posts)) {
            $html = "Zatím jste nenapsal žadný příspěvek!";
        }

        $html .= "\n<table class='table table-striped'>\n<tbody>\n";
        /*
         * state 0 = just submitted - waiting for reviewer assignments
         * state 1 = waiting for reviews
         * state 2 = waiting for decision
         * state 3 = accepted/denied
         */
        foreach ($posts as $item){
            $html .= "<tr>
                        <td><a href='read_my_post/".$item['title']."'>".$item['title']."</a></td>";

            switch ($item['state']) {
                case 0: $html .= "<td>Čekám na přiřazení recenzentů</td>"; break;
                case 1: $html .= "<td>Čekám na recenze</td>"; break;
                case 2: $html .= "<td>Čekám na adminovo rozhodnutí</td>"; break;
                case 3: if ($item['published'] == 1) {
                            $html .= "<td>Publikován</td>";
                            break;
                        } else {
                            $html .= "<td>Zamítnut</td>";
                            break;
                        }
            }
            $html .= "</tr>\n";
        }
        $html .= "</tbody>\n</table>\n";

        return $html;
    }
}