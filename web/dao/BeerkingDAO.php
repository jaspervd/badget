<?php
require_once __DIR__ . '/DAO.php';
class BeerkingDAO extends DAO {
    public function selectById($id) {
        $sql = "SELECT * FROM `bg_beerking` WHERE `id` = :id";
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
        $sql = "SELECT * FROM `bg_beerking` WHERE `user_id` = :user_id";
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

    public function insert($user_id, $day, $angle, $time) {
        $sql = "INSERT INTO `bg_beerking` (`user_id`, `day`, `angle`, `time`) VALUES (:user_id, :day, :angle, :time)";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':user_id', $user_id);
        $stmt->bindValue(':day', $day);
        $stmt->bindValue(':angle', $angle);
        $stmt->bindValue(':time', $time);
        if ($stmt->execute()) {
            return $this->selectById($this->pdo->lastInsertId());
        }

        return array();
    }
}
