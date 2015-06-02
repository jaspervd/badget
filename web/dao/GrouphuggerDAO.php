<?php
require_once __DIR__ . '/DAO.php';
class GrouphuggerDAO extends DAO {
    public function selectById($id) {
        $sql = "SELECT * FROM `bg_grouphugger` WHERE `id` = :id";
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

    public function selectByUserId($user_id) {
        $sql = "SELECT * FROM `bg_grouphugger` WHERE `user_id` = :user_id";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':user_id', $user_id);
        if($stmt->execute()) {
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
            if (!empty($user)) {
                return $user;
            }
        }

        return array();
    }

    public function insert($user_id, $day, $friends) {
        $sql = "INSERT INTO `bg_grouphugger` (`user_id`, `day`, `friends`) VALUES (:user_id, :day, :friends)";
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
