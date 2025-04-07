<?php
require_once "../config.php";

try {
    $data = json_decode(file_get_contents("php://input"));

    if (!isset($data->course_id)) {
        http_response_code(400);
        echo json_encode(["error" => "Course ID is required"]);
        exit;
    }

    $course_id = $data->course_id;

    $sql = "SELECT test_id, title, questions FROM tests WHERE course_id = :course_id";
    $stmt = $conn->prepare($sql);
    $stmt->bindValue(":course_id", $course_id, PDO::PARAM_INT);
    $stmt->execute();
    $tests = $stmt->fetchAll(PDO::FETCH_ASSOC);

    foreach ($tests as &$test) {
        $test['questions'] = json_decode($test['questions']);
    }

    echo json_encode($tests);

}catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => "Database error: " . $e->getMessage()]);
}

?>