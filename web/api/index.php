<?php
ini_set("display_errors", "1");
error_reporting(E_ALL);
session_start();
date_default_timezone_set('Europe/Brussels');
define("WWW_ROOT", dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR);

require_once WWW_ROOT . 'api' . DIRECTORY_SEPARATOR . 'Slim' . DIRECTORY_SEPARATOR . 'Slim.php';
require_once WWW_ROOT . 'dao' . DIRECTORY_SEPARATOR . 'UsersDAO.php';
require_once WWW_ROOT . 'dao' . DIRECTORY_SEPARATOR . 'OrganisatorDAO.php';
require_once WWW_ROOT . 'dao' . DIRECTORY_SEPARATOR . 'CoordinatorDAO.php';
require_once WWW_ROOT . 'dao' . DIRECTORY_SEPARATOR . 'BarmanDAO.php';
require_once WWW_ROOT . 'dao' . DIRECTORY_SEPARATOR . 'BadgesDAO.php';

\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();
$usersDAO = new UsersDAO();
$organisatorDAO = new OrganisatorDAO();
$coordinatorDAO = new CoordinatorDAO();
$barmanDAO = new BarmanDAO();
$badgesDAO = new BadgesDAO();

$app->post('/users/?', function () use ($app, $usersDAO) {
    header('Content-Type: application/json');
    $post = $app->request->post();
    if (empty($post)) {
        $post = (array)json_decode($app->request()->getBody());
    }

    $photo_url = '';
    if(!empty($_FILES['photo'])) {
        $fileTmp = $_FILES['photo'];
        $ext = pathinfo($fileTmp['name'], PATHINFO_EXTENSION);
        if($ext == '') {
            $ext = 'png';
        }
        $fileName = time() . '_' . mt_rand(100, 999) . '.' . $ext;
        $uploadfile = '..' . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . $fileName;
        if (move_uploaded_file($fileTmp['tmp_name'], $uploadfile)) {
            $photo_url = $fileName;
        }
    }

    echo json_encode($usersDAO->register($post['name'], $post['email'], $post['gender'], $photo_url));
    exit();
});

$app->post('/organisator/?', function () use ($app, $organisatorDAO) {
    header('Content-Type: application/json');
    $post = $app->request->post();
    if (empty($post)) {
        $post = (array)json_decode($app->request()->getBody());
    }
    echo json_encode($organisatorDAO->insert($post['user_id'], $post['day'], $post['friends']));
    exit();
});

$app->post('/coordinator/?', function () use ($app, $coordinatorDAO) {
    header('Content-Type: application/json');
    $post = $app->request->post();
    if (empty($post)) {
        $post = (array)json_decode($app->request()->getBody());
    }
    echo json_encode($coordinatorDAO->insert($post['user_id'], $post['day'], $post['time'], $post['distance']));
    exit();
});

$app->post('/barman/?', function () use ($app, $barmanDAO) {
    header('Content-Type: application/json');
    $post = $app->request->post();
    if (empty($post)) {
        $post = (array)json_decode($app->request()->getBody());
    }
    echo json_encode($barmanDAO->insert($post['user_id'], $post['day'], $post['angle'], $post['seconds']));
    exit();
});

$app->post('/badges/?', function () use ($app, $badgesDAO) {
    header('Content-Type: application/json');
    $post = $app->request->post();
    if (empty($post)) {
        $post = (array)json_decode($app->request()->getBody());
    }
    echo json_encode($badgesDAO->insert($post['user_id'], $post['title'], $post['goal'], $post['photo_url']));
    exit();
});

$app->run();
