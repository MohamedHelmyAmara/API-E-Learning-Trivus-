<?php
require_once "../config.php";

try {
    // تعديل أسماء الأعمدة بناءً على الأسماء الموجودة فعليًا في قاعدة البيانات
    $stmt = $conn->prepare("
    SELECT 
        courses.course_id, 
        courses.course_title,
        courses.description,
        courses.rating, 
        courses.created_at, 
        categories.category_name,
        (
            SELECT COUNT(*) 
            FROM lessons 
            WHERE lessons.course_id = courses.course_id
        ) AS lessons_count
    FROM 
        courses 
    JOIN 
        categories 
    ON 
        courses.category_id = categories.category_id 
    ORDER BY 
        courses.course_id DESC
");

    $stmt->execute();
    $courses = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "success" => true,
        "message" => "Courses fetched successfully",
        "courses" => $courses
    ], JSON_UNESCAPED_UNICODE);
} catch (Exception $e) {
    echo json_encode(["success" => false, "message" => "Error: " . $e->getMessage()]);
}
?>
