<?php 
require_once "../config.php";

try { 
    $data = json_decode(file_get_contents("php://input"));

    if (!isset($data->user_id)) {
        http_response_code(400);
        echo json_encode(["error" => "User ID is required"]);
        exit;
    }

    $user_id = $data->user_id;

    $sql = "SELECT s.score_id, s.test_id, t.title, s.score, s.submitted_at 
            FROM scores s
            JOIN tests t ON s.test_id = t.test_id
            WHERE s.user_id = :user_id
            ORDER BY s.submitted_at DESC";
            
    $stmt = $conn->prepare($sql);
    $stmt->bindValue(":user_id", $user_id, PDO::PARAM_INT);
    $stmt->execute();
    
    $scores = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($scores);
} catch (Exception $e) {
    
    http_response_code(500);
    echo json_encode(["error" => "Database error: " . $e->getMessage()]);
}
?>