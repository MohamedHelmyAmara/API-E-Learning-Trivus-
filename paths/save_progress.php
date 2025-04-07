<?php 
    require_once "../config.php";
    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    $data = json_decode(file_get_contents("php://input"));

    $user_id = $data->userId;
    $course_id = $data->pathId;
    $watched_items = isset($data->watchedItems) ? json_encode($data->watchedItems) : json_encode([]);
    $completed_tests = isset($data->completedTests) ? json_encode($data->completedTests) : json_encode([]);
    $unlocked_lessons = isset($data->unlockedLessons) ? json_encode($data->unlockedLessons) : json_encode([]);



    $checkQuery = "SELECT * FROM progress WHERE user_id = :user_id AND course_id = :course_id";
    $stmt = $conn->prepare($checkQuery);
    $stmt->execute([
      ':user_id' => $user_id,
      ':course_id' => $course_id
    ]);

    $exists = $stmt->fetchColumn();

    if ($exists) {

        $updateQuery = "UPDATE progress 
        SET 
          watched_items = JSON_MERGE_PRESERVE(watched_items, :watched_items),
          completed_tests = JSON_MERGE_PRESERVE(completed_tests, :completed_tests),
          unlocked_lessons = JSON_MERGE_PRESERVE(unlocked_lessons, :unlocked_lessons),
          updated_at = NOW()
        WHERE user_id = :user_id AND course_id = :course_id";
    
        $updateStmt = $conn->prepare($updateQuery);
        $updateStmt->execute([
          ':watched_items' => $watched_items,
          ':completed_tests' => $completed_tests,
          ':unlocked_lessons' => $unlocked_lessons,
          ':user_id' => $user_id,
          ':course_id' => $course_id
        ]);

    } else { 
        
        $insertQuery = "INSERT INTO progress (user_id, course_id, watched_items, completed_tests, unlocked_lessons, created_at, updated_at) 
        VALUES (:user_id, :course_id, :watched_items, :completed_tests, :unlocked_lessons, NOW(), NOW())";
        $insertStmt = $conn->prepare($insertQuery);
        $insertStmt->execute([
        ':user_id' => $user_id,
        ':course_id' => $course_id,
        ':watched_items' => $watched_items,
        ':completed_tests' => $completed_tests,
        ':unlocked_lessons' => $unlocked_lessons
        ]);
    }

    echo json_encode(["status" => "success", "message" => "تم حفظ التقدم بنجاح"]);
?>