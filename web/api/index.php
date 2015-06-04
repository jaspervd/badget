<?php
ini_set("display_errors", "1");
error_reporting(E_ALL);
session_start();
date_default_timezone_set('Europe/Brussels');
define("WWW_ROOT", dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR);

require_once WWW_ROOT . 'api' . DIRECTORY_SEPARATOR . 'Slim' . DIRECTORY_SEPARATOR . 'Slim.php';
require_once WWW_ROOT . 'dao' . DIRECTORY_SEPARATOR . 'UsersDAO.php';
require_once WWW_ROOT . 'dao' . DIRECTORY_SEPARATOR . 'GrouphuggerDAO.php';
require_once WWW_ROOT . 'dao' . DIRECTORY_SEPARATOR . 'MasterscoutDAO.php';
require_once WWW_ROOT . 'dao' . DIRECTORY_SEPARATOR . 'BeerkingDAO.php';
require_once WWW_ROOT . 'dao' . DIRECTORY_SEPARATOR . 'SettingsDAO.php';

\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();
$usersDAO = new UsersDAO();
$grouphuggerDAO = new GrouphuggerDAO();
$masterscoutDAO = new MasterscoutDAO();
$beerkingDAO = new BeerkingDAO();
$settingsDAO = new SettingsDAO();

$app->get('/day/?', function() use ($settingsDAO) {
    header('Content-Type: application/json');
    echo json_encode($settingsDAO->getCurrentDay());
    exit;
});

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
            $ext = 'jpg';
        }
        $fileName = time() . '_' . mt_rand(100, 999) . '.' . $ext;
        $uploadfile = '..' . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . $fileName;
        if (move_uploaded_file($fileTmp['tmp_name'], $uploadfile)) {
            $photo_url = $fileName;
        }
    }

    echo json_encode($usersDAO->register($post['name'], $post['email'], $photo_url));
    exit();
});

$app->post('/grouphugger/?', function () use ($app, $grouphuggerDAO) {
    header('Content-Type: application/json');
    $post = $app->request->post();
    if (empty($post)) {
        $post = (array)json_decode($app->request()->getBody());
    }
    echo json_encode($grouphuggerDAO->insert($post['user_id'], _DAY, $post['friends']));
    exit();
});

$app->post('/masterscout/?', function () use ($app, $masterscoutDAO) {
    header('Content-Type: application/json');
    $post = $app->request->post();
    if (empty($post)) {
        $post = (array)json_decode($app->request()->getBody());
    }
    echo json_encode($masterscoutDAO->insert($post['user_id'], _DAY, $post['time'], $post['distance']));
    exit();
});

$app->post('/beerking/?', function () use ($app, $beerkingDAO) {
    header('Content-Type: application/json');
    $post = $app->request->post();
    if (empty($post)) {
        $post = (array)json_decode($app->request()->getBody());
    }
    echo json_encode($beerkingDAO->insert($post['user_id'], _DAY, $post['angle'], $post['seconds']));
    exit();
});

$app->run();
