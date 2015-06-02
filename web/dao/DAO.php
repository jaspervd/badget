<?php
class DAO {
	private static $dbHost = 'localhost';
	private static $dbName = 'maiv_badget';
	private static $dbUser = 'usr_badget';
	private static $dbPass = '$bg123';
	private static $sharedPDO;
	protected $pdo;

	function __construct() {
		if(empty(self::$sharedPDO)) {
			self::$sharedPDO = new PDO('mysql:host=' . self::$dbHost . ';dbname=' . self::$dbName, self::$dbUser, self::$dbPass);
			self::$sharedPDO->exec('SET CHARACTER SET utf8');
			self::$sharedPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			self::$sharedPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
		}
		$this->pdo =& self::$sharedPDO;
	}
}