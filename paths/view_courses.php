<?php

require_once "../config.php";

// ضبط الترميز لدعم اللغة العربية عند استخدام PDO
$conn->exec("SET NAMES utf8mb4");

$method = $_SERVER['REQUEST_METHOD'];

if ($method === "GET") {
    if (isset($_GET['id'])) {
        $id = intval($_GET['id']);
        $stmt = $conn->prepare("
            SELECT c.course_id, c.course_title, c.description, c.rating, c.instructor, cat.category_name 
            FROM courses c 
            JOIN categories cat ON c.category_id = cat.category_id 
            WHERE c.course_id = ?
        ");
        $stmt->execute([$id]);
        $course = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($course) {
            // جلب المتطلبات
            $requirementsStmt = $conn->prepare("SELECT requirement_text FROM requirements WHERE course_id = ?");
            $requirementsStmt->execute([$course['course_id']]);
            $course['requirements'] = $requirementsStmt->fetchAll(PDO::FETCH_COLUMN);

            // جلب خارطة الطريق
            $roadmapStmt = $conn->prepare("SELECT step_number, step_description FROM roadmap WHERE course_id = ?");
            $roadmapStmt->execute([$course['course_id']]);
            $course['roadmap'] = $roadmapStmt->fetchAll(PDO::FETCH_ASSOC);

            // جلب الأسئلة الشائعة
            $faqsStmt = $conn->prepare("SELECT question, answer FROM faqs WHERE course_id = ?");
            $faqsStmt->execute([$course['course_id']]);
            $course['faqs'] = $faqsStmt->fetchAll(PDO::FETCH_ASSOC);

            // جلب عدد الدروس
            $lessonsCountStmt = $conn->prepare("SELECT COUNT(*) FROM lessons WHERE course_id = ?");
            $lessonsCountStmt->execute([$course['course_id']]);
            $course['lessons_count'] = $lessonsCountStmt->fetchColumn();

            $firstVideoStmt = $conn->prepare("SELECT video_url FROM lessons WHERE course_id = ? ORDER BY lesson_id ASC LIMIT 1");
            $firstVideoStmt->execute([$course['course_id']]);
            $course['first_video'] = $firstVideoStmt->fetchColumn();
        }

        echo json_encode($course, JSON_UNESCAPED_UNICODE);
    } else {
        $stmt = $conn->query("
            SELECT c.course_id, c.course_title, c.description, c.rating, c.instructor, cat.category_name 
            FROM courses c 
            JOIN categories cat ON c.category_id = cat.category_id
        ");
        $courses = $stmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($courses as &$course) {
            // جلب عدد الدروس
            $lessonsCountStmt = $conn->prepare("SELECT COUNT(*) FROM lessons WHERE course_id = ?");
            $lessonsCountStmt->execute([$course['course_id']]);
            $course['lessons_count'] = $lessonsCountStmt->fetchColumn();
        }

        echo json_encode($courses, JSON_UNESCAPED_UNICODE);
    }
} elseif ($method === "POST") {
    $data = json_decode(file_get_contents("php://input"), true);

    if (!$data) {
        echo json_encode(["error" => "البيانات المستلمة ليست JSON صالح"]);
        exit;
    }

    if (!isset($data['course_title'], $data['category_id'], $data['description'], $data['rating'], $data['instructor'], 
                $data['requirements'], $data['roadmap'], $data['faqs'], $data['lessons'])) {
        echo json_encode(["error" => "بيانات غير مكتملة"]);
        exit;
    }

    // إدخال الكورس
    $query = "INSERT INTO courses (category_id, course_title, description, rating, Instructor) 
              VALUES (:category_id, :course_title, :description, :rating, :instructor)";
    $stmt = $conn->prepare($query);
    $success = $stmt->execute([
        ":category_id" => intval($data['category_id']),
        ":course_title" => $data['course_title'],
        ":description" => $data['description'],
        ":rating" => intval($data['rating']),
        ":instructor" => $data['instructor']
    ]);

    if ($success) {
        $courseId = $conn->lastInsertId();

        // إدخال المتطلبات
        foreach ($data['requirements'] as $requirement) {
            $reqStmt = $conn->prepare("INSERT INTO requirements (course_id, requirement_text) VALUES (?, ?)");
            $reqStmt->execute([$courseId, $requirement]);
        }

        // إدخال خارطة الطريق
        foreach ($data['roadmap'] as $step) {
            $roadmapStmt = $conn->prepare("INSERT INTO roadmap (course_id, step_number, step_description) VALUES (?, ?, ?)");
            $roadmapStmt->execute([$courseId, intval($step['step_number']), $step['step_description']]);
        }

        // إدخال الأسئلة الشائعة
        foreach ($data['faqs'] as $faq) {
            $faqStmt = $conn->prepare("INSERT INTO faqs (course_id, question, answer) VALUES (?, ?, ?)");
            $faqStmt->execute([$courseId, $faq['question'], $faq['answer']]);
        }

        // إدخال الدروس
        foreach ($data['lessons'] as $lesson) {
            $lessonStmt = $conn->prepare("INSERT INTO lessons (course_id, lesson_title, video_url) VALUES (?, ?, ?)");
            $lessonStmt->execute([$courseId, $lesson['lesson_title'], $lesson['video_url']]);
        }

        echo json_encode(["message" => "تمت إضافة الكورس بنجاح"]);
    } else {
        echo json_encode(["error" => "حدث خطأ أثناء الإضافة"]);
    }
} else {
    echo json_encode(["error" => "الطريقة غير مدعومة"]);
}

?>
