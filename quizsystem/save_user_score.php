<?php 
require_once "../config.php";

try {
    $data = json_decode(file_get_contents("php://input"));

    if (!isset($data->test_id) || !isset($data->user_id) || !isset($data->score)) {
        http_response_code(400);
        echo json_encode(["error" => "Test ID, User ID, and Score are required"]);
        exit;
    }

    $test_id = $data->test_id;
    $user_id = $data->user_id;
    $score = $data->score;

    $sql = "SELECT score_id FROM scores WHERE test_id = :test_id AND user_id = :user_id";
    $stmt = $conn->prepare($sql);
    $stmt->bindValue(":test_id", $test_id, PDO::PARAM_INT);
    $stmt->bindValue(":user_id", $user_id, PDO::PARAM_INT);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        http_response_code(409); // Conflict
        echo json_encode(["error" => "User has already submitted a score for this test"]);
        exit;
    }

    $sql = "INSERT INTO scores (test_id, user_id, score) VALUES (:test_id, :user_id, :score)";
    $stmt = $conn->prepare($sql);
    $stmt->bindValue(":test_id", $test_id, PDO::PARAM_INT);
    $stmt->bindValue(":user_id", $user_id, PDO::PARAM_INT);
    $stmt->bindValue(":score", $score, PDO::PARAM_INT);
    $stmt->execute();

    echo json_encode(["success" => true, "message" => "Score saved successfully"]);


} catch (Exception $e) {
    
    http_response_code(500);
    echo json_encode(["error" => "Database error: " . $e->getMessage()]);
}

?>