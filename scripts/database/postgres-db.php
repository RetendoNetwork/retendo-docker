<?php
$host = isset($host);
$port = isset($port);
$user = isset($user);
$password = isset($password);
$dbname = isset($dbname);

try {
    $dsn = "pgsql:host=$host;port=$port;";
    $pdo = new PDO($dsn, $user, $password);
    
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $sql = "CREATE DATABASE \"$dbname\"";
    $pdo->exec($sql);
    
} catch (PDOException $e) {
    echo "Error for creating the database:" . $e->getMessage();
}

$pdo = null;
?>