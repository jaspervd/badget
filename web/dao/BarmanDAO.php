<?php
require_once __DIR__ . '/DAO.php';
class BarmanDAO extends DAO {
    public function selectById($id) {
        $sql = "SELECT * FROM `bg_barman` WHERE `id` = :id";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':id', $id);
        if($stmt->execute()) {
            $barman = $stmt->fetch(PDO::FETCH_ASSOC);
            if (!empty($barman)) {
                return $barman;
            }
        }

        return array();
    }

    public function selectByUserId($user_id) {
        $sql = "SELECT * FROM `bg_barman` WHERE `user_id` = :user_id";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':user_id', $user_id);
        if($stmt->execute()) {
            $barman = $stmt->fetch(PDO::FETCH_ASSOC);
            if (!empty($barman)) {
                return $barman;
            }
        }

        return array();
    }

    public function insert($user_id, $day, $angle, $seconds) {
        $sql = "INSERT INTO `bg_barman` (`user_id`, `day`, `angle`, `seconds`) VALUES (:user_id, :day, :angle, :seconds)";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':user_id', $user_id);
        $stmt->bindValue(':day', $day);
        $stmt->bindValue(':angle', $angle);
        $stmt->bindValue(':seconds', $seconds);
        if ($stmt->execute()) {
            return $this->selectById($this->pdo->lastInsertId());
        }

        return array();
    }
}
