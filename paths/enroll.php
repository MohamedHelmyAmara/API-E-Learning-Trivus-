<?php

require_once "../config.php";
require_once "../vendor/phpmailer/phpmailer/src/PHPMailer.php";
require_once "../vendor/phpmailer/phpmailer/src/SMTP.php";
require_once "../vendor/phpmailer/phpmailer/src/Exception.php";

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// استقبال البيانات من الطلب
$data = json_decode(file_get_contents("php://input"), true);
$userId = $data["userId"] ?? null;
$courseId = $data["courseId"] ?? null;

// التحقق من صحة البيانات
if (!$userId || !$courseId) {
    http_response_code(400);
    echo json_encode(["success" => false, "message" => "جميع الحقول مطلوبة"]);
    exit();
}

try {
    // التحقق مما إذا كان المستخدم مسجلًا بالفعل في الكورس
    $stmt = $conn->prepare("SELECT enroll_id FROM enrollment WHERE user_id = ? AND course_id = ?");
    $stmt->execute([$userId, $courseId]);

    if ($stmt->rowCount() > 0) {
        http_response_code(409);
        echo json_encode(["success" => false, "message" => "المستخدم مسجل بالفعل في هذا الكورس"]);
        exit();
    }

    // تسجيل المستخدم في الكورس
    $stmt = $conn->prepare("INSERT INTO enrollment (user_id, course_id) VALUES (?, ?)");
    if ($stmt->execute([$userId, $courseId])) {
        // جلب بيانات المستخدم والبريد الإلكتروني
        $userStmt = $conn->prepare("SELECT username, email FROM users WHERE user_id = ?");
        $userStmt->execute([$userId]);
        $user = $userStmt->fetch(PDO::FETCH_ASSOC);

        // جلب عنوان الكورس
        $courseStmt = $conn->prepare("SELECT course_title FROM courses WHERE course_id = ?");
        $courseStmt->execute([$courseId]);
        $course = $courseStmt->fetch(PDO::FETCH_ASSOC);

        if ($user && $course) {
            // إرسال البريد الإلكتروني
            $mail = new PHPMailer(true);

            try {
                // إعدادات SMTP
                $mail->isSMTP();
                $mail->Host = "smtp.gmail.com";
                $mail->SMTPAuth = true;
                $mail->Username = "trivusteam@gmail.com"; // البريد الإلكتروني الخاص بك
                $mail->Password = "pgwt aodb wlbk wtkx"; // كلمة مرور التطبيق
                $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
                $mail->Port = 587;
                $mail->CharSet = "UTF-8";

                $mail->SMTPOptions = [
                    'ssl' => [
                        'verify_peer' => false,
                        'verify_peer_name' => false,
                        'allow_self_signed' => true,
                    ],
                ];
                

                // إعداد بيانات البريد
                $mail->setFrom("trivusteam@gmail.com", "Trivus Team");
                $mail->addAddress($user["email"], $user["username"]);
                $mail->Subject = "تهانينا على التسجيل في الكورس الجديد!";
                $mail->Body = "مرحبًا {$user["username"]},\n\nتهانينا على تسجيلك في الكورس \"{$course["course_title"]}\". نحن متحمسون لرحلتك التعليمية ونتمنى لك التوفيق!\n\nفريق Trivus.";

                $mail->send();
            } catch (Exception $e) {
                error_log("فشل إرسال البريد الإلكتروني: " . $mail->ErrorInfo);
            }
        }

        // استجابة النجاح
        http_response_code(201);
        echo json_encode([
            "success" => true,
            "message" => "تم التسجيل بنجاح وتم إرسال البريد الإلكتروني",
        ], JSON_UNESCAPED_UNICODE);
    } else {
        http_response_code(500);
        echo json_encode(["success" => false, "message" => "حدث خطأ أثناء التسجيل"]);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "خطأ في قاعدة البيانات: " . $e->getMessage()]);
}

?>
