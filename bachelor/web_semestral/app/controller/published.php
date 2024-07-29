<?php

/**
 * Class Published controller that shows published posts
 */
class Published extends Controller {

    /**
     * Default function called. Shows all published posts.
     */
    public function index() {
        $this->prepare_parts();
        $html = $this->construct_posts();
        $this->params['obsah'] = $html;
        $this->render();
    }

    /**
     * Action of a specific post being clicked and to show it. Gets the posts name through url.
     */
    public function read_post() {
        $this->prepare_parts();

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
            $file_html .= '<div><b>Soubor pdf: </b>';
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
     * Constructs html table of published posts
     * @return string html of posts table
     */
    private function construct_posts() {
        $html = "\n<h3>Seznam příspěvků</h3><br>\n";
        $posts = $this->model->get_all_published_posts();

        if (empty($posts)) {
            $html = "Vypadá to, že zatím nebyly zveřejněny žádné příspěvky.";
        }

        $html .= "\n<table class='table table-striped'>\n<tbody>\n";
        foreach ($posts as $item){
            $html .= "<tr>
                        <td scope='row'><a href='read_post/".$item['title']."'>".$item['title']."</a></td>
                        <td scope='row'>by: ".$item['username']."</td>
                      </tr>\n";
        }
        $html .= "</tbody>\n</table>\n";

        return $html;
    }
}