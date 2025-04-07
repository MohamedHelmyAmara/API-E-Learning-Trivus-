<?php 
require_once "../config.php";
error_reporting(E_ALL);
ini_set('display_errors', 1);

$data = json_decode(file_get_contents("php://input"));

$user_id = $data->userId;
$course_id = $data->pathId;

$query = "SELECT watched_items, completed_tests, unlocked_lessons FROM progress WHERE user_id = :user_id AND course_id = :course_id";
$stmt = $conn->prepare($query);
$stmt->execute([
  ':user_id' => $user_id,
  ':course_id' => $course_id
]);

$progress = $stmt->fetch(PDO::FETCH_ASSOC);

if ($progress) {
    echo json_encode([
        "status" => "success",
        "watchedItems" => json_decode($progress["watched_items"]),
        "completedTests" => json_decode($progress["completed_tests"]),
        "unlockedLessons" => $progress["unlocked_lessons"] ? json_decode($progress["unlocked_lessons"]) : [0]

    ]);
} else {
    echo json_encode([
        "status" => "success",
        "watchedItems" => [],
        "completedTests" => [],
        "unlockedLessons" => [0] 
    ]);
}

?>