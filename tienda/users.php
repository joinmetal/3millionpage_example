<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header("Access-Control-Allow-Credentials: true");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(204);
    exit();
}
// Configuración de conexión
$host = "bxogd5zaquhce70kq12g-mysql.services.clever-cloud.com";
$user = "uyacupu1cvsqtwy5";
$pass = "Q6K5oeXnPLGwwm8UdzTe";
$db = "bxogd5zaquhce70kq12g";
$port = 3306;

// Conexión a la base de datos
$conn = new mysqli($host, $user, $pass, $db, $port);

// Verificar la conexión
if ($conn->connect_error) {
    die(json_encode([
        "success" => false,
        "message" => "Conexión fallida: " . $conn->connect_error
    ]));
}

// Configurar cabeceras para CORS y JSON
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Manejar la solicitud OPTIONS para CORS
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(204);
    exit();
}


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"));

    if (!$data) {
        echo json_encode(["success" => false, "message" => "Invalid request data"]);
        exit();
    }

    $action = $data->action ?? '';

    try {
        switch ($action) {
            case 'register':
                    $username = $conn->real_escape_string($data->username);
                    $email = $conn->real_escape_string($data->email);
                    $password = password_hash($data->password, PASSWORD_DEFAULT);

                    $sql = "INSERT INTO users (username, email, password, tokens) VALUES (?, ?, ?, 0)";
                    $stmt = $conn->prepare($sql);
                    if (!$stmt) {
                        throw new Exception("Error en la consulta: " . $conn->error);
                    }
                    $stmt->bind_param("sss", $username, $email, $password);
                    $stmt->execute();

                    if ($stmt->affected_rows > 0) {
                        $respuesta = ["success" => true, "message" => "Usuario registrado"];
                    } else {
                        throw new Exception("Error al registrar usuario: " . $stmt->error);
                    }
                    $stmt->close();
                    break;

                case 'login':
                    $email = $conn->real_escape_string($data->email);
                    $password = $data->password;

                    $sql = "SELECT id, username, password, tokens FROM users WHERE email = ?";
                    $stmt = $conn->prepare($sql);
                    if (!$stmt) {
                        throw new Exception("Error en la consulta: " . $conn->error);
                    }
                    $stmt->bind_param("s", $email);
                    $stmt->execute();
                    $result = $stmt->get_result();

                    if ($result->num_rows > 0) {
                        $user = $result->fetch_assoc();
                        if (password_verify($password, $user['password'])) {
                            $respuesta = [
                                "success" => true,
                                "message" => "Inicio de sesión exitoso",
                                "user" => [
                                    "id" => $user['id'],
                                    "username" => $user['username'],
                                    "email" => $email,
                                    "tokens" => $user['tokens']
                                ]
                            ];
                        } else {
                            $respuesta = ["success" => false, "message" => "Contraseña incorrecta"];
                        }
                    } else {
                        $respuesta = ["success" => false, "message" => "Usuario no encontrado"];
                    }
                    $stmt->close();
                    break;


                case 'get_tokens':
                    $username = $conn->real_escape_string($data->username);
                    $sql = "SELECT tokens FROM users WHERE username = ?";
                    $stmt = $conn->prepare($sql);
                    $stmt->bind_param("s", $username);
                    $stmt->execute();
                    $result = $stmt->get_result();

                    if ($result->num_rows > 0) {
                        $row = $result->fetch_assoc();
                        $respuesta = ['success' => true, 'tokens' => $row['tokens']];
                    } else {
                        $respuesta = ['success' => false, 'message' => 'Usuario no encontrado'];
                    }
                    $stmt->close();
                    break;

                case 'update_tokens':
                    $username = $conn->real_escape_string($data->username);
                    $newTokens = $data->tokens;

                    $sql = "UPDATE users SET tokens = ? WHERE username = ?";
                    $stmt = $conn->prepare($sql);

                    if (!$stmt) {
                       throw new Exception("Error de actualización: " . $conn->error);
                    }

                    $stmt->bind_param("is", $newTokens, $username);

                    if ($stmt->execute()) {
                       $respuesta = ['success' => true, 'message' => 'Tokens actualizados'];
                    } else {
                        throw new Exception("Error al actualizar tokens: " . $stmt->error);
                    }
                    $stmt->close();
                    break;

                case 'add_tokens':
                    $username = $conn->real_escape_string($data->username);
                    $tokensToAdd = $data->tokens;

                    $sql = "UPDATE users SET tokens = tokens + ? WHERE username = ?";
                    $stmt = $conn->prepare($sql);


                    if (!$stmt) {
                         throw new Exception("Error de actualización: " . $conn->error);
                    }


                    $stmt->bind_param("is", $tokensToAdd, $username);

                    if ($stmt->execute()) {
                        $respuesta = ['success' => true, 'message' => 'Tokens actualizados'];
                    } else {
                        throw new Exception("Error al actualizar tokens: " . $stmt->error);
                    }
                    $stmt->close();
                    break;



                    case 'save_image':
                        $username = $conn->real_escape_string($data->username);
                        $imageUrl = $conn->real_escape_string($data->image_url);
                        $imageName = $conn->real_escape_string($data->image_name);
                        $imageSize = $data->image_size;
                        $pixelSize = $data->pixel_size;
                        $xPosition = $data->x_position;
                        $yPosition = $data->y_position;

                        $sql = "SELECT id FROM users WHERE username = ?";
                        $stmt = $conn->prepare($sql);
                        $stmt->bind_param("s", $username);
                        $stmt->execute();
                        $result = $stmt->get_result();

                        if ($result->num_rows > 0) {
                            $user = $result->fetch_assoc();
                            $userId = $user['id'];

                            $sql = "INSERT INTO images (user_id, image_url, image_name, upload_date, image_size, pixel_size, x_position, y_position) VALUES (?, ?, ?, NOW(), ?, ?, ?, ?)";
                            $stmt = $conn->prepare($sql);
                            $stmt->bind_param("issiiii", $userId, $imageUrl, $imageName, $imageSize, $pixelSize, $xPosition, $yPosition);
                            if ($stmt->execute()) {
                                $respuesta = ['success' => true, 'message' => 'Image saved'];
                            } else {
                                $respuesta = ['success' => false, 'message' => 'Error saving image: ' . $stmt->error];
                            }
                            $stmt->close();
                        } else {
                            $respuesta = ['success' => false, 'message' => 'User not found'];
                        }
                        break;


                        case 'save_pixel':
                            $username = $conn->real_escape_string($data->username);
                            $xPosition = $data->x_position;
                            $yPosition = $data->y_position;
                            $color = $conn->real_escape_string($data->color);
            
                            $sql = "SELECT id FROM users WHERE username = ?";
                            $stmt = $conn->prepare($sql);
                            $stmt->bind_param("s", $username);
                            $stmt->execute();
                            $result = $stmt->get_result();
            
                            if ($result->num_rows > 0) {
                                $user = $result->fetch_assoc();
                                $userId = $user['id'];
            
                                $sql = "INSERT INTO pixels (user_id, x_position, y_position, color, placed_at) VALUES (?, ?, ?, ?, NOW())";
                                $stmt = $conn->prepare($sql);
                                $stmt->bind_param("iiis", $userId, $xPosition, $yPosition, $color);
                                if ($stmt->execute()) {
                                    $respuesta = ['success' => true, 'message' => 'Pixel saved'];
                                } else {
                                    $respuesta = ['success' => false, 'message' => 'Error saving pixel: ' . $stmt->error];
                                }
                                $stmt->close();
                            } else {
                                $respuesta = ['success' => false, 'message' => 'User not found'];
                            }
                            break;

                            
                            case 'load_pixels':
                                $sql = "SELECT user_id, x_position, y_position, color, placed_at FROM pixels";
                                $result = $conn->query($sql);
                
                                if ($result) {
                                    $pixels = [];
                                    while ($row = $result->fetch_assoc()) {
                                        $pixels[] = $row;
                                    }
                                    $respuesta = ['success' => true, 'pixels' => $pixels];
                                } else {
                                    $respuesta = ['success' => false, 'message' => 'Error loading pixels: ' . $conn->error];
                                }
                                break;
                

                    case 'load_images':
                        $sql = "SELECT image_url, pixel_size, x_position, y_position FROM images";
                        $result = $conn->query($sql);

                        if ($result) {
                            $images = [];
                            while ($row = $result->fetch_assoc()) {
                                $images[] = $row;
                            }
                            $respuesta = ['success' => true, 'images' => $images];
                        } else {
                            $respuesta = ['success' => false, 'message' => 'Error loading images: ' . $conn->error];
                        }
                        break;

                  case 'update_image_position':
                        $imageUrl = $conn->real_escape_string($data->image_url);
                        $xPosition = $data->x_position;
                        $yPosition = $data->y_position;


                        $sql = "UPDATE images SET x_position = ?, y_position = ? WHERE image_url = ?";
                        $stmt = $conn->prepare($sql);
                        $stmt->bind_param("iis", $xPosition, $yPosition, $imageUrl);


                        if ($stmt->execute()) {
                            $respuesta = ['success' => true, 'message' => 'Image position updated'];
                        } else {
                            $respuesta = ['success' => false, 'message' => 'Error updating image position: ' . $stmt->error];
                        }
                        $stmt->close();
                        break;


                    default:
                        $respuesta = ["success" => false, "message" => "Invalid action"];
                }
                echo json_encode($respuesta);

            } catch (Exception $e) {
                error_log("Error in action " . $action . ": " . $e->getMessage());
                echo json_encode(["success" => false, "message" => $e->getMessage()]);
            }
        }


        $conn->close();
        ?>