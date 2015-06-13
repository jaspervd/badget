<?php
require_once __DIR__ . '/DAO.php';
class BadgesDAO extends DAO {
    public function selectById($id) {
        $sql = "SELECT * FROM `bg_badges` WHERE `id` = :id";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':id', $id);
        if($stmt->execute()) {
            $badge = $stmt->fetch(PDO::FETCH_ASSOC);
            if (!empty($badge)) {
                return $badge;
            }
        }

        return array();
    }

    public function selectByUserId($user_id) {
        $sql = "SELECT * FROM `bg_badges` WHERE `user_id` = :user_id";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':user_id', $user_id);
        if($stmt->execute()) {
            $badges = $stmt->fetchAll(PDO::FETCH_ASSOC);
            if (!empty($badges)) {
                return $badges;
            }
        }

        return array();
    }

    public function insert($user_id, $title, $goal, $photo_url) {
        $sql = "INSERT INTO `bg_badges` (`user_id`, `title`, `goal`, `photo_url`) VALUES (:user_id, :title, :goal, :photo_url)";
        $stmt = $this->pdo->prepare($sql);
        $stmt->bindValue(':user_id', $user_id);
        $stmt->bindValue(':title', $title);
        $stmt->bindValue(':goal', $goal);
        $stmt->bindValue(':photo_url', $photo_url);
        if ($stmt->execute()) {
            return $this->selectById($this->pdo->lastInsertId());
        }

        return array();
    }
}
