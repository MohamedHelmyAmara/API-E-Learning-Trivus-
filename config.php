<?php
header("Access-Control-Allow-Origin: *"); 
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: *");
header("Access-Control-Max-Age: 100000"); 
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Credentials: true");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

$usernameDB = "root";
$password = "";
$conn = $database = new PDO("mysql:host=localhost; dbname=trivus; charset=utf8;", $usernameDB, $password);
?>
