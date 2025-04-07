<?php 

require_once "../config.php";

try {
    $course_id = $_GET['id'];

    $stmtCourse = $conn->prepare("SELECT * FROM courses WHERE course_id = ?");
    $stmtCourse->execute([$course_id]);
    $course = $stmtCourse->fetch(PDO::FETCH_ASSOC);

    $stmtLessons = $conn->prepare("SELECT * FROM lessons WHERE course_id = ?");
    $stmtLessons->execute([$course_id]);
    $lessons = $stmtLessons->fetchAll(PDO::FETCH_ASSOC);

    $response = [
        'id' => $course['course_id'],
        'title' => $course['course_title'],
        'items' => array_map(function($lesson) {
            return [
                'id' => $lesson['lesson_id'],
                'title' => $lesson['lesson_title'],
                'videoId' => $lesson['video_url']
            ];
        }, $lessons)
    ];

    echo json_encode($response, JSON_UNESCAPED_UNICODE);
} catch (Exception $e) {
	
	echo 'Caught exception: ',  $e->getMessage(), "\n";
}
?>