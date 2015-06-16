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

    public function register($name, $email, $gender, $photo_url) {
        $sql = "INSERT INTO `bg_users` (`name`, `email`, `gender`, `photo_url`) VALUES (:name, :email, :gender, :photo_url)";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':name', $name);
        $stmt->bindValue(':email', $email);
        $stmt->bindValue(':gender', $gender);
        $stmt->bindValue(':photo_url', $photo_url);
        if ($stmt->execute()) {
            return $this->selectById($this->pdo->lastInsertId());
        }

        return array();
    }

    public function selectAll() {
        $sql = "SELECT * FROM `bg_users`";
        $stmt = $this->pdo->prepare($sql);
        if($stmt->execute()) {
            $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
            if (!empty($users)) {
                return $users;
            }
        }

        return array();
    }
}
