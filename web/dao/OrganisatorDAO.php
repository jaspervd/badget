<?php
require_once __DIR__ . '/DAO.php';
class OrganisatorDAO extends DAO {
    public function selectById($id) {
        $sql = "SELECT * FROM `bg_organisator` WHERE `id` = :id";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':id', $id);
        if($stmt->execute()) {
            $organisator = $stmt->fetch(PDO::FETCH_ASSOC);
            if (!empty($organisator)) {
                return $organisator;
            }
        }

        return array();
    }

    public function selectByUserId($user_id) {
        $sql = "SELECT * FROM `bg_organisator` WHERE `user_id` = :user_id";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':user_id', $user_id);
        if($stmt->execute()) {
            $organisator = $stmt->fetch(PDO::FETCH_ASSOC);
            if (!empty($organisator)) {
                return $organisator;
            }
        }

        return array();
    }

    public function insert($user_id, $day, $friends) {
        $sql = "INSERT INTO `bg_organisator` (`user_id`, `day`, `friends`) VALUES (:user_id, :day, :friends)";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':user_id', $user_id);
        $stmt->bindValue(':day', $day);
        $stmt->bindValue(':friends', $friends);
        if ($stmt->execute()) {
            return $this->selectById($this->pdo->lastInsertId());
        }

        return array();
    }
}
