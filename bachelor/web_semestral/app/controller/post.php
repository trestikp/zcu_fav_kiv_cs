<?php

/**
 * Class Post is a controller for post adding
 */
class Post extends Controller {

    /**
     * Default function called. Only for logged users in users.
     */
    public function index() {
        // if a users isn't logged in redirect to home
        if ($_SESSION["logged"] == false) {
            header('Location: /web_semestral/public/home/not_logged_in');
        }

        $this->prepare_parts();
        $form = file_get_contents('../app/view/static/post_form.html');
        $html = $this->twig->render('post.html', ['body' => $form]);
        $this->params['obsah'] = $html;
        $this->render();
    }

    /**
     * Submits post to database. Does some basic error checking like if all the fields required are filled.
     */
    public function submit_post() {
        $first = $_POST['post_name'];
        $second = $_POST['post_desc'];

        if ($first == "" || $first == null) {
            die(json_encode(array('message' => 'TITLE_ERROR', 'code' => 1)));
        }

        if ($second == "" || $first == null) {
            die(json_encode(array('message' => 'TEXT_ERROR', 'code' => 2)));
        }

        $filename = $_FILES['pdf_input']['name'];

        if ($filename == "" || $filename == null) {
            $this->model->submit_post($first, $second, '');
            //successful die
            die(json_encode(array('message' => 'TEXT_ERROR', 'code' => 0)));
        }

        $destination = '../app/uploads/'.$filename;
        $extension = pathinfo($filename, PATHINFO_EXTENSION);

        $file = $_FILES['pdf_input']['tmp_name'];
        $size = $_FILES['pdf_input']['size'];

        if ($extension != 'pdf') {
//            header('HTTP/1.1 500 Internal Server Error');
//            header('Content-Type: application/json; charset=UTF-8');
            die(json_encode(array('message' => 'FILE_TYPE_ERROR', 'code' => 3)));
        } elseif ($size > 5000000) {
            die(json_encode(array('message' => 'FILE_SIZE_ERROR', 'code' => 4)));
        } else {
            if (move_uploaded_file($file, $destination)) {
                $this->model->submit_post($first, $second, $filename);
                //successful die
                die(json_encode(array('message' => 'SUCCESS!', 'code' => 0)));
            } else {
                die(json_encode(array('message' => 'FILE_UPLOAD_ERROR', 'code' => 5)));
            }
        }
    }

    /**
     * Renders html after successful post submit.
     */
    public function submit_success() {
        if ($_SESSION["logged"] == false) {
            header('Location: /web_semestral/public/home/not_logged_in');
        }

        $this->prepare_parts();
        $html = "<dl>
                    <dd>
                        <p>Váš příspěvek byl úspěšně odeslán.<br>
                        Stav zveřejnění příspěvku můžete vidět v sekci \"Mé příspěvky\"</p>
                    </dd>
                    <dt>
                        <dd>
                            <input class='float-left' id='my_posts_red' type='button' value='Mé příspěvky'>
                            <input class='float-right' id='new_post_red' type='button' value='Napsat další příspěvek'>
                        </dd>
                    </dt>
                 </dl>";
        $this->params['obsah'] = $html;
        $this->render();
    }
}