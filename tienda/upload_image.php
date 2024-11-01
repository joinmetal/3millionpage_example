<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header("Access-Control-Allow-Credentials: true");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(204);
    exit();
}

$targetDir = "uploads/";
if (!file_exists($targetDir)) {
    mkdir($targetDir, 0777, true);
}

// Set proper content type for images
$imageTypes = [
    'jpg' => 'image/jpeg',
    'jpeg' => 'image/jpeg',
    'png' => 'image/png',
    'gif' => 'image/gif'
];

// Add .htaccess file in uploads directory
$htaccess = <<<EOT
<IfModule mod_headers.c>
    Header set Access-Control-Allow-Origin "*"
</IfModule>
Options +FollowSymLinks
<IfModule mod_mime.c>
    AddType image/jpeg .jpg .jpeg
    AddType image/png .png
    AddType image/gif .gif
</IfModule>
EOT;

file_put_contents($targetDir . '.htaccess', $htaccess);

$response = ["success" => false];

if (isset($_FILES["image"]) && $_FILES["image"]["error"] == UPLOAD_ERR_OK) {
    $fileName = uniqid() . "_" . basename($_FILES["image"]["name"]);
    $targetFile = $targetDir . $fileName;
    $uploadOk = 1;
    $imageFileType = strtolower(pathinfo($targetFile, PATHINFO_EXTENSION));
    
    // Set proper content type header for the image
    if (isset($imageTypes[$imageFileType])) {
        header("Content-Type: " . $imageTypes[$imageFileType]);
    }

    $maxFileSize = 500000;
    if ($_FILES["image"]["size"] > $maxFileSize) {
        $response["message"] = "File too large. Max size: " . ($maxFileSize / 1000) . "KB.";
        $uploadOk = 0;
    }

    $allowedTypes = ["jpg", "png", "jpeg", "gif"];
    if (!in_array($imageFileType, $allowedTypes)) {
        $response["message"] = "Only JPG, JPEG, PNG & GIF files are allowed.";
        $uploadOk = 0;
    }

    if ($uploadOk == 1) {
        if (move_uploaded_file($_FILES["image"]["tmp_name"], $targetFile)) {
            // Ensure file permissions are correct
            chmod($targetFile, 0644);
            
            $check = getimagesize($targetFile);
            if ($check !== false) {
                // Use absolute URL with correct protocol
                $protocol = isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? 'https://' : 'http://';
                $imageUrl = $protocol . $_SERVER['HTTP_HOST'] . "/tienda/" . $targetFile;
                
                $response["success"] = true;
                $response["imageUrl"] = $imageUrl;
            } else {
                $response["message"] = "Uploaded file is not a valid image.";
                unlink($targetFile);
            }
        } else {
            $error = error_get_last();
            $response["message"] = "Error uploading file: " . ($error ? $error['message'] : 'Unknown error');
        }
    }
} else {
    $response["message"] = "No image uploaded or error during upload.";
}

header('Content-Type: application/json');
echo json_encode($response);
?>