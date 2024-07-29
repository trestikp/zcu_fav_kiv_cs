<?php

/**
 * Class Model handles the data
 */
class Model {

    /**
     * @var db instance
     */
    protected $db;

    /**
     * Model constructor.
     * @param $db db got from controller
     */
    public function __construct($db) {
        $this->db = $db;
    }

    /**
     * Tries to log in the user, gets user data from the db
     * @param $username
     * @param $password
     * @return int exit code 0 = success, != 0 - failure
     */
    public function login($username, $password) {
//        $sql = "SELECT * FROM users WHERE username=\"$username\"";
        $sql = "SELECT * FROM users WHERE username=:username";
        $statement = $this->db->prepare($sql);
        $statement->execute(array('username' => $username));
        $result = $statement->fetchAll();

        if (count($result) < 1) {
            // if there is no result -> user doesn't exist
            return 1;
        } else if (count($result) > 1) {
            // if there is more then 1 result -> more of the same usernames
            // prevent this!
            return 2;
        } else {
            if ($password == $result[0]["password"]) {
                $_SESSION["id"] = $result[0]["id"];
                $_SESSION["username"] = $result[0]["username"];
                $_SESSION["role"] = $result[0]["role"];
                $_SESSION["email"] = $result[0]["email"];
                $_SESSION["logged"] = true;
                // for testing
                return 0;
            } else {
                // wrong password
                return 3;
            }
        }
    }

    /**
     * Inserts post into the database
     * @param $title
     * @param $description
     * @param $file location of the file
     */
    public function submit_post($title, $description, $file) {
//        $sql = "INSERT INTO posts(author, title, text, file) VALUES (".$_SESSION['id'].",'$title', '$description', '$file')";
        $sql = "INSERT INTO posts(author, title, text, file) VALUES (:id, :title, :description, :file)";
        $statement = $this->db->prepare($sql);
        $statement->execute(array('id' => $_SESSION['id'], 'title' => $title, 'description' => $description,
                                    'file' => $file));
//        $this->db->exec($sql);
    }

    /**
     * Gets all published posts
     * @return mixed array of posts
     */
    public function get_all_published_posts() {
        $sql = "SELECT author, published, title, username FROM posts, users WHERE published = 1 AND users.id = author";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);

        return $result;
    }

    /**
     * Gets posts of the logged in user
     * @return mixed posts
     */
    public function get_users_posts() {
//        $sql = "SELECT title, state, published, file FROM posts WHERE author = ".$_SESSION['id'];
        $sql = "SELECT title, state, published, file FROM posts WHERE author = :id";
        $statement = $this->db->prepare($sql);
        $statement->execute(array('id' => $_SESSION['id']));
//        $statement->execute();
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);

        return $result;
    }

    /**
     * Gets posts that are to be reviewed
     * @return mixed posts
     */
    public function get_posts_to_review() {
        $sql = "SELECT p.title, rq.reviewed FROM posts as p JOIN review_queue as rq ON p.id=rq.post WHERE
                p.id=rq.post AND 
                p.published=0 AND
                rq.reviewer=:id 
                ORDER BY rq.reviewed";
//        $sql = "SELECT p.title, rq.reviewed FROM posts as p JOIN review_queue as rq ON p.id=rq.post WHERE
//                p.id=rq.post AND
//                p.published=0 AND
//                rq.reviewer= ".$_SESSION['id']."
//                ORDER BY rq.reviewed";
        $statement = $this->db->prepare($sql);
//        $statement->execute();
        $statement->execute(array('id' => $_SESSION['id']));
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);

        return $result;
    }

    /**
     * Gets post by title (potentially could be more, but the rest of the app wouldn't handle it)
     * @param $title of the post
     * @return mixed post (s)
     */
    public function get_post_by_title($title) {
//        $sql = "SELECT a.username, p.title, p.text, p.file, p.id FROM posts as p, users as a
//                WHERE title = \"$title\" AND a.id = p.author";
        $sql = "SELECT a.username, p.title, p.text, p.file, p.id FROM posts as p, users as a 
                WHERE title =:title AND a.id = p.author";
        $statement = $this->db->prepare($sql);
        $statement->execute(array('title' => $title));
//        $statement->execute();
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);

        return $result;
    }

    /**
     * Checks if the username is in free to use or is already in db
     * @param $username
     * @return bool
     */
    public function username_occupied($username) {
//        $sql = "SELECT * FROM users WHERE username=\"$username\"";
        $sql = "SELECT * FROM users WHERE username=:username";
        $statement = $this->db->prepare($sql);
//        $statement->execute();
        $statement->execute(array('username' => $username));
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);

        if (count($result) >= 1) {
            // username already exists
            return true;
        } else {
            return false;
        }
    }

    /**
     * Inserts into users new user
     * @param $username
     * @param $password
     * @param $email
     */
    public function add_user($username, $password, $email) {
        // no need to set role -> role is automatically set to 1 (author) by the db
//        $sql = "INSERT INTO users(username, password, email) VALUES (\"$username\", \"$password\", \"$email\")";
        $sql = "INSERT INTO users(username, password, email) VALUES (:username, :password, :email)";
        $statement = $this->db->prepare($sql);
        $statement->execute(array('username' => $username, 'password' => $password, 'email' => $email));
//        $statement->execute();
    }

    /**
     * Inserts into the reviews table a new review
     * @param $criterium_1
     * @param $criterium_2
     * @param $criterium_3
     * @param $overall
     * @param $post_id
     * @param $text
     */
    public function add_review($criterium_1, $criterium_2, $criterium_3, $overall, $post_id, $text) {
//        $sql = "INSERT INTO reviews(post, reviewer, criterium1, criterium2, criterium3, overall, text)
//                VALUES ($post_id, ".$_SESSION['id'].", $criterium_1, $criterium_2, $criterium_3, $overall, \"$text\")";
        $sql = "INSERT INTO reviews(post, reviewer, criterium1, criterium2, criterium3, overall, text)
                VALUES (:p_id, :id, :c1, :c2, :c3, :ol, :text)";
        $statement = $this->db->prepare($sql);
//        $statement->execute();
        $statement->execute(array('p_id' => $post_id, 'id' => $_SESSION['id'], 'c1' => $criterium_1,
                                'c2' => $criterium_2, 'c3' => $criterium_3, 'ol' => $overall, 'text' => $text));
    }

    /**
     * Marks the post as reviewed in the connection table.
     * @param $reviewer
     * @param $post_id
     */
    public function set_as_reviewed($reviewer, $post_id) {
        $sql = "UPDATE review_queue SET reviewed=1 WHERE post=$post_id AND reviewer=$reviewer";
        $statement = $this->db->prepare($sql);
        $statement->execute();
    }

    /**
     * Checks if the post is reviewed
     * @param $reviewer
     * @param $post_id
     * @return bool
     */
    public function is_reviewed($reviewer, $post_id) {
        $sql = "SELECT reviewed FROM review_queue WHERE post=$post_id AND reviewer=$reviewer";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetch(PDO::FETCH_ASSOC);

        if ($result['reviewed'] == 1) {
//            $_SESSION['r_id'] =
            return true;
        } else {
            return false;
        }
    }

    /**
     * Updates review
     * @param $criterium_1
     * @param $criterium_2
     * @param $criterium_3
     * @param $overall
     * @param $post_id
     * @param $text
     */
    public function update_review($criterium_1, $criterium_2, $criterium_3, $overall, $post_id, $text) {
//        $sql = "UPDATE reviews SET criterium1=$criterium_1, criterium2=$criterium_2, criterium3=$criterium_3,
//                overall=$overall, text=\"$text\" WHERE reviewer=".$_SESSION['id']." AND post=$post_id";
        $sql = "UPDATE reviews SET criterium1=:c1, criterium2=:c2, criterium3=:c3,
                overall=:ol, text=:text WHERE reviewer=:id AND post=:p_id";
        $statement = $this->db->prepare($sql);
        $statement->execute(array('c1' => $criterium_1, 'c2' => $criterium_2, 'c3' => $criterium_3, 'ol' => $overall,
                                'text' => $text, 'p_id' => $post_id));
    }

    /**
     * Gets reviews that need reviewers assigned
     * @return mixed
     */
    public function get_review_assignment_posts() {
        $sql = "SELECT title, id FROM posts WHERE state=0";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $results = $statement->fetchAll(PDO::FETCH_ASSOC);

        return $results;
    }

    /**
     * Gets reviewers of a post by id
     * @param $p_id
     * @return mixed
     */
    public function get_reviewers_of_post($p_id) {
        $sql = "SELECT u.username, rq.reviewed FROM users AS u, review_queue AS rq WHERE
                u.id=rq.reviewer AND rq.post=$p_id";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $results = $statement->fetchAll(PDO::FETCH_ASSOC);

        return $results;
    }

    /**
     * Gets reviewers that are not assigned to the post already
     * @param $p_id
     * @return mixed
     */
    public function get_free_reviewers($p_id) {
        $sql = "SELECT DISTINCT username, id FROM users WHERE
                role>1 AND 
                id NOT IN 
                (SELECT DISTINCT u.id FROM users AS u JOIN review_queue AS rq ON u.id=rq.reviewer WHERE
                          rq.post=$p_id)";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $results = $statement->fetchAll(PDO::FETCH_ASSOC);

        return $results;
    }

    /**
     * Inserts into m:n connection table to connect reviewer to post
     * @param $r_id
     * @param $p_id
     */
    public function assign_reviewer($r_id, $p_id) {
//        $sql = "INSERT INTO review_queue(reviewer, post) VALUES ($r_id, $p_id)";
        $sql = "INSERT INTO review_queue(reviewer, post) VALUES (:r_id, :p_id)";
        $statement = $this->db->prepare($sql);
        $statement->execute(array('r_id' => $r_id, 'p_id' => $p_id));
    }

    /**
     * gets reviewed but not published posts
     * @return mixed
     */
    public function get_unpublished_reviewed() {
        $sql = "SELECT DISTINCT p.title, p.id, COUNT(*) FROM posts AS p JOIN review_queue AS rq ON rq.post=p.id WHERE
		rq.reviewed=1 AND
        p.published=0
        GROUP BY rq.post
        HAVING COUNT(*) >=3";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $results = $statement->fetchAll(PDO::FETCH_ASSOC);

        return $results;
    }

    /**
     * Get reviews of post
     * @param $p_id
     * @return mixed
     */
    public function get_reviews_of_post($p_id) {
        $sql = "SELECT r.*, u.username FROM reviews AS r, users AS u WHERE post=$p_id AND u.id=r.reviewer";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $results = $statement->fetchAll(PDO::FETCH_ASSOC);

        return $results;
    }

    /**
     * Publishes post
     * @param $p_id
     */
    public function publish_post($p_id) {
        $sql = "UPDATE posts SET published=1, state=3 WHERE id=$p_id";
//        $sql = "UPDATE posts SET published=1, state=3 WHERE id=:p_id";
        $statement = $this->db->prepare($sql);
        $statement->execute();
//        $statement->execute(array('p_id' => $p_id));
    }

    /**
     * Denies post
     * @param $p_id
     */
    public function deny_post($p_id) {
        $sql = "UPDATE posts SET published=2, state=3 WHERE id=$p_id";
        $statement = $this->db->prepare($sql);
        $statement->execute();
    }

    /**
     * Gets review by id
     * @param $p_id
     * @return mixed
     */
    public function get_review_by_id($r_id) {
        $sql = "SELECT * FROM reviews WHERE id=$r_id";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetch(PDO::FETCH_ASSOC);

        return $result;
    }

    /**
     * Gets all users
     * @return mixed
     */
    public function get_all_users() {
        $sql = "SELECT * FROM users";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetchAll(PDO::FETCH_ASSOC);

        return $result;
    }

    /**
     * Alters users role (permissions)
     * @param $username
     * @param $role
     */
    public function alter_role($username, $role) {
        $sql = "UPDATE users SET role=$role WHERE username=\"$username\"";
        $statement = $this->db->prepare($sql);
        $statement->execute();
    }

    /**
     * Get number of reviewers assigned to a post
     * @param $p_id
     * @return mixed
     */
    public function get_assigned_review_count($p_id) {
        $sql = "SELECT COUNT(*) FROM review_queue WHERE post=$p_id";
        $statement = $this->db->prepare($sql);
        $statement->execute();
        $result = $statement->fetch(PDO::FETCH_ASSOC);

        return $result;
    }

    /**
     * Update post state
     * @param $p_id
     * @param $state
     */
    public function update_post_state($p_id, $state) {
        $sql = "UPDATE posts SET state=$state WHERE id=$p_id";
        $statement = $this->db->prepare($sql);
        $statement->execute();
    }
}