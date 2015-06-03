<?php
require_once __DIR__ . '/DAO.php';
class UsersDAO extends DAO {
    public function selectById($id) {
        $sql = "SELECT * FROM `bg_users` WHERE `id` = :id";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':id', $id);
        if($stmt->execute()) {
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
            if (!empty($user)) {
                return $user;
            }
        }

        return array();
    }

    public function register($name, $email, $photo_url) {
        $sql = "INSERT INTO `bg_users` (`name`, `email`, `photo_url`) VALUES (:name, :email, :photo_url)";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':name', $name);
        $stmt->bindValue(':email', $email);
        $stmt->bindValue(':photo_url', $photo_url);
        if ($stmt->execute()) {
            return $this->selectById($this->pdo->lastInsertId());
        }

        return array();
    }
}
