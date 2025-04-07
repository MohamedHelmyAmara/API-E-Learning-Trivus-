<?php
require_once "../config.php";


$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['email'], $data['password'])) {
    echo json_encode(["success" => false, "message" => "جميع الحقول مطلوبة."]);
    exit;
}

$email = trim($data['email']);
$password = trim($data['password']);


$stmt = $conn->prepare("SELECT * FROM users WHERE email = ?");
$stmt->bindValue(1, $email, PDO::PARAM_STR); 
$stmt->execute();
$user = $stmt->fetch(PDO::FETCH_ASSOC);



if (!$user) {
    echo json_encode(["success" => false, "message" => "❌ البريد الإلكتروني غير مسجل."]);
    exit;
}

if (password_verify($password , $user['password'])) {
        echo json_encode([
            "success" => true,
            "message" => "تم تسجيل الدخول بنجاح.",
            "user" => [
                "id" => $user['user_id'],
                "username" => $user['username']
            ]
        ]);
} else {
    echo "كلمة المرور خاطئة!";
} 
?>