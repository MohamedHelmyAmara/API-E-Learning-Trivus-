<?php 
require_once "../config.php"; 
require "../vendor/autoload.php"; 

use PHPMailer\PHPMailer\PHPMailer;  
use PHPMailer\PHPMailer\Exception;  

$mail = new PHPMailer(true);  

error_reporting(E_ALL);  
ini_set('display_errors', 1);  

// استقبال البيانات JSON  
$data = json_decode(file_get_contents("php://input"), true);  

// تخزين البيانات في ملف `debug.log` للتحقق  
file_put_contents("debug.log", print_r($data, true));  

if (!$data || !isset($data['email'])) {  
    echo json_encode(["success" => false, "message" => "❌ البريد الإلكتروني مطلوب."]);  
    exit();  
}  

$email = $data['email'];


// حذف أي رمز تحقق قديم لهذا البريد الإلكتروني
$deleteOldCode = $conn->prepare("UPDATE users SET reset_code = NULL WHERE email = :email");
$deleteOldCode->bindValue(":email", $email, PDO::PARAM_STR);
$deleteOldCode->execute();

// إنشاء رمز تحقق جديد
$reset_code = rand(100000, 999999);

// تحديث قاعدة البيانات برمز التحقق الجديد
$updateStmt = $conn->prepare("UPDATE users SET reset_code = :reset_code WHERE email = :email");
$updateStmt->bindValue(":reset_code", $reset_code, PDO::PARAM_STR);
$updateStmt->bindValue(":email", $email, PDO::PARAM_STR);

if ($updateStmt->execute()) {
    echo json_encode(["success" => true, "message" => "تم إنشاء رمز التحقق بنجاح.", "reset_code" => $reset_code]);
} else {
    echo json_encode(["success" => false, "message" => "حدث خطأ أثناء تحديث رمز التحقق."]);
}


// **إرسال البريد الإلكتروني مع رمز التحقق**  
try {  
    $mail->isSMTP();  
    $mail->Host = "smtp.gmail.com";  
    $mail->SMTPAuth = true;  
    $mail->Username = "trivusteam@gmail.com";  
    $mail->Password = "pgwt aodb wlbk wtkx";  
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;  
    $mail->Port = 587;  
    $mail->CharSet = "UTF-8";  

    // تجاوز التحقق من SSL (اختياري)  
    $mail->SMTPOptions = array(  
        'ssl' => array(  
            'verify_peer' => false,  
            'verify_peer_name' => false,  
            'allow_self_signed' => true  
        )  
    );  

    $mail->setFrom("trivusteam@gmail.com", "Trivus Team");  
    $mail->addAddress($email);  

    $mail->isHTML(true);  
    $mail->Subject = "إعادة تعيين كلمة المرور";  
    $mail->Body = "رمز التحقق الخاص بك هو: <b>$reset_code</b>";  

    if ($mail->send()) {  
        echo json_encode(["success" => true, "message" => "✅ تم إرسال رمز التحقق إلى بريدك.", "reset_code" => $reset_code]);  
    } else {  
        file_put_contents("mail_error.log", "فشل إرسال البريد: " . $mail->ErrorInfo . "\n", FILE_APPEND);
        echo json_encode(["success" => false, "message" => "❌ فشل إرسال البريد: " . $mail->ErrorInfo]);  
    }  
} catch (Exception $e) {  

  
    file_put_contents("mail_error.log", "خطأ أثناء الإرسال: " . $e->getMessage() . "\n", FILE_APPEND);
    echo json_encode(["success" => false, "message" => "❌ خطأ أثناء الإرسال: " . $e->getMessage()]);  
}
?>

