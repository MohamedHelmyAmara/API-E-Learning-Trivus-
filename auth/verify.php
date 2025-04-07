<?php 
require_once "../config.php"; 

// استقبال البيانات JSON
$data = json_decode(file_get_contents("php://input"), true);

// تسجيل البيانات في `debug_verify.log` للتحقق من استقبالها
file_put_contents("debug_verify.log", print_r($data, true));

if (!isset($data['code'], $data['newPassword'], $data['confirmPassword'])) { 
    echo json_encode(["success" => false, "message" => "❌ جميع الحقول مطلوبة."]); 
    exit; 
} 

$code = trim($data['code']); 
$newPassword = trim($data['newPassword']); 
$confirmPassword = trim($data['confirmPassword']); 

// التحقق من تطابق كلمتي المرور 
if ($newPassword !== $confirmPassword) { 
    echo json_encode(["success" => false, "message" => "❌ كلمتا المرور غير متطابقتين."]); 
    exit; 
}  

// التحقق من وجود الكود في قاعدة البيانات
$stmt = $conn->prepare("SELECT user_id, reset_code FROM users WHERE reset_code = :code AND reset_code IS NOT NULL"); 
$stmt->bindValue(":code", $code, PDO::PARAM_STR);
$stmt->execute();
$confirm = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$confirm) { 
    echo json_encode(["success" => false, "message" => "❌ رمز التحقق غير صحيح أو منتهي الصلاحية."]); 
    exit; 
} 

$user = $confirm;  // الآن $user يحتوي على بيانات المستخدم

// تسجيل بيانات التحقق في ملف التصحيح (debug)
file_put_contents("debug_verify.log", "📌 الرمز المدخل: $code\n", FILE_APPEND);
file_put_contents("debug_verify.log", "📌 الرمز في DB: " . $user['reset_code'] . "\n", FILE_APPEND);

$userId = $user['user_id'];

// تحديث كلمة المرور الجديدة بعد التشفير
$hashedPassword = password_hash($newPassword, PASSWORD_BCRYPT);

$updateStmt = $conn->prepare("UPDATE users SET password = ?, reset_code = NULL WHERE user_id = ?");
$updateStmt->bindValue(1, $hashedPassword, PDO::PARAM_STR);
$updateStmt->bindValue(2, $userId, PDO::PARAM_INT);

if ($updateStmt->execute()) { 
    echo json_encode(["success" => true, "message" => "✅ تم إعادة تعيين كلمة المرور بنجاح."]); 
} else { 
    echo json_encode(["success" => false, "message" => "❌ حدث خطأ أثناء تحديث كلمة المرور."]); 
} 
?>
