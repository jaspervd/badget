<?php
require_once __DIR__ . '/DAO.php';
class MasterscoutDAO extends DAO {
    public function selectById($id) {
        $sql = "SELECT * FROM `bg_masterscout` WHERE `id` = :id";
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
        $sql = "SELECT * FROM `bg_masterscout` WHERE `user_id` = :user_id";
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

    public function insert($user_id, $day, $time, $distance) {
        $sql = "INSERT INTO `bg_masterscout` (`user_id`, `day`, `time`, `distance`) VALUES (:user_id, :day, :time, :distance)";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':user_id', $user_id);
        $stmt->bindValue(':day', $day);
        $stmt->bindValue(':time', $time);
        $stmt->bindValue(':distance', $distance);
        if ($stmt->execute()) {
            return $this->selectById($this->pdo->lastInsertId());
        }

        return array();
    }
}
