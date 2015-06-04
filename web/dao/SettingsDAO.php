<?php
require_once __DIR__ . '/DAO.php';
class SettingsDAO extends DAO {
    public function getCurrentDay() {
        $sql = "SELECT `current_day` FROM `bg_settings` LIMIT 1";
        $stmt = $this->pdo->prepare($sql);
        if($stmt->execute()) {
            return $stmt->fetch(PDO::FETCH_ASSOC);
        }

        return array();
    }
}
