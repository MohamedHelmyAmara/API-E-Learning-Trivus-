<?php
require_once "../config.php";
require "../vendor/autoload.php"; // تحميل مكتبة PHPMailer

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;


$userdata = json_decode(file_get_contents("php://input"));

$username = $userdata->username;
$email = $userdata->email;
$password = $userdata->password;
$confirm_password = $userdata->confirm_password;
$created_at = date("Y-m-d H:i:s");

if (empty($username) || empty($email) || empty($password) || empty($confirm_password)) {
    echo json_encode(["success" => false, "message" => "❌ يرجى تعبئة جميع الحقول."]);
    exit;
}

if ($password !== $confirm_password) {
    echo json_encode(["success" => false, "message" => "❌ كلمتا المرور غير متطابقتين."]);
    exit;
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode(["success" => false, "message" => "❌ البريد الإلكتروني غير صالح."]);
    exit;
}


try {

    // إعداد PHPMailer
    $mail = new PHPMailer(true);
    $mail->isSMTP();
    $mail->Host = "smtp.gmail.com";
    $mail->SMTPAuth = true;
    $mail->Username = "trivusteam@gmail.com";
    $mail->Password = "pgwt aodb wlbk wtkx"; // كلمة مرور التطبيق الخاصة بـ Gmail
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port = 587;
    $mail->CharSet = "UTF-8";

    $mail->SMTPOptions = array(
        'ssl' => array(
            'verify_peer' => false,
            'verify_peer_name' => false,
            'allow_self_signed' => true
        )
    );

    // إعدادات البريد
    $mail->setFrom("trivusteam@gmail.com", "Trivus Team");
    $mail->addAddress($email, $username);
    $mail->isHTML(true);
    $mail->Subject = "مرحبًا بك في Trivus!";
    $mail->Body = "
        <h2 style='text-align: center; color: #2b6cb0;'>مرحبًا بك في <strong>Trivus</strong>!</h2>
        <p>أهلاً وسهلاً بك <strong>$username</strong> في مجتمع Trivus.</p>
        <p>شعارنا: <strong>تعلم - نافس - تعاون</strong></p>
        <p>نحن سعداء بانضمامك إلينا ونأمل أن تجد هنا تجربة تعليمية فريدة وممتعة.</p>
        <hr>
        <p>مع تحيات فريق <strong>Trivus</strong> 🎉</p>";

    // إرسال البريد الإلكتروني
    if ($mail->send()) {
        // تشفير كلمة المرور
        $hashed_password = password_hash($password, PASSWORD_BCRYPT);

        // إدخال البيانات في قاعدة البيانات
        $stmt = $conn->prepare("INSERT INTO users (username, email, `password`, created_at) VALUES (:username, :email, :password, :created_at)");
        $stmt->bindValue(":username", $username, PDO::PARAM_STR);
        $stmt->bindValue(":email", $email, PDO::PARAM_STR);
        $stmt->bindValue(":password", $hashed_password, PDO::PARAM_STR);
        $stmt->bindValue(":created_at", $created_at, PDO::PARAM_STR);

        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "تم التسجيل بنجاح!"]);
        } else {
            echo json_encode(["success" => false, "message" => "❌ فشل في إدخال البيانات."]);
        }
    } else {
        echo json_encode(["success" => false, "message" => "❌ فشل إرسال البريد."]);
    }
} catch (Exception $e) {
    echo json_encode([
        "success" => false,
        "message" => "حدث خطأ أثناء العملية.",
        "error_details" => $e->getMessage()
    ]);
}
 ?>
