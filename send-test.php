<?php
require "vendor/autoload.php";
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

$mail = new PHPMailer(true);

try {
    // إعدادات SMTP
    $mail->SMTPOptions = array(
        'ssl' => array(
            'verify_peer' => false,
            'verify_peer_name' => false,
            'allow_self_signed' => true
        )
    );
    $mail->isSMTP();
    $mail->Host = "smtp.gmail.com";
    $mail->SMTPAuth = true;
    $mail->Username = "trivusteam@gmail.com";
    $mail->Password = "pgwt aodb wlbk wtkx"; // تأكد من إدخال كلمة مرور التطبيق الصحيحة
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS; 
    $mail->Port = 587;
    $mail->CharSet = "UTF-8";

    // تفعيل التصحيح لرؤية الأخطاء
    $mail->SMTPDebug = 2; // مستوى التصحيح (0: بدون تفاصيل، 2: جميع التفاصيل)
    $mail->Debugoutput = "html";

    // إعدادات المرسل والمستلم
    $mail->setFrom("trivusteam@gmail.com", "Trivus Team");
    $mail->addAddress("zhanzoov3@gmail.com", "Recipient Name");

    // محتوى الرسالة
    $mail->isHTML(true);
    $mail->Subject = "اختبار إرسال البريد الإلكتروني";
    $mail->Body = "<h1>مرحبًا بك في Trivus!</h1><p>هذا اختبار لإرسال البريد عبر Gmail.</p>";

    $mail->send();
    echo "✅ تم إرسال البريد بنجاح!";
} catch (Exception $e) {
    echo "❌ خطأ أثناء الإرسال: {$mail->ErrorInfo}";
}
