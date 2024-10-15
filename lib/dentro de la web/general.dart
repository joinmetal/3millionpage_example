import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3 Million Dollar Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ThreeMillionDollarPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/pixelcanvas': (context) => PixelCanvas(),
      },
    );
  }
}

class ThreeMillionDollarPage extends StatelessWidget {
  const ThreeMillionDollarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F0036),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Title and Buttons
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Moldea el Futuro con el Poder Icónico de los Pixeles que Definieron Internet.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text('Inicio'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {} /* Add functionality if needed */,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text('Ingresa/Registrate'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Main Pixel Art Banner
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF36005D), Color(0xFFFA4873)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 50,
                    left: 100,
                    child: PixelCloud(),
                  ),
                  Positioned(
                    top: 150,
                    right: 100,
                    child: PixelCloud(),
                  ),
                  Positioned(
                    bottom: 100,
                    right: 150,
                    child: PixelSpaceship(),
                  ),
                  Positioned(
                    bottom: 200,
                    left: 50,
                    child: PixelShootingStar(),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 250,
                    child: PixelShootingStar(),
                  ),
                ],
              ),
              height: 500,
            ),
            // Section with "Novedades"
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Novedades',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFeatureCard(
                          'assets/images/novedades.png', 
                          'Nueva Función de Personalización',
                          'Ahora puedes darle un toque único a tus imágenes convirtiéndolas en arte pixelado.',
                        ),
                        SizedBox(width: 10),
                        _buildFeatureCard(
                          'assets/images/novedades.png',
                          'Actualización de Píxeles Disponibles',
                          'Hemos ampliado nuestra gama de paquetes de píxeles.',
                        ),
                        SizedBox(width: 10),
                        _buildFeatureCard(
                          'assets/images/novedades.png',
                          'Colaboraciones Exclusivas',
                          'Explora nuestras colaboraciones con artistas reconocidos.',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10), // Space between sections
                  // New Section similar to the provided image
                  Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nosotros',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'En un pequeño rincón de la web, un joven soñador miraba hacia el futuro con nostalgia por los días pasados de Internet, cuando los pixeles eran la esencia de la creatividad digital. Cansado de la uniformidad y los diseños genéricos de hoy en día, decidió emprender un viaje para recuperar la magia de aquellos primeros días de la web. Con una pasión ardiente y un profundo respeto por la historia digital, creó un sitio web único: un espacio donde los pixeles, esos humildes bloques de colores que una vez dieron forma al ciberespacio, podían ser redescubiertos y utilizados para nuevas creaciones. Su objetivo era claro: ofrecer a otros diseñadores y creadores la oportunidad de evocar la nostalgia de la era dorada de Internet y transformar sus proyectos con el poder de los pixeles clásicos. Así nació un lugar donde cada pixel no solo representa un componente de diseño, sino una conexión con la esencia del pasado digital. Al ofrecer paquetes de pixeles cuidadosamente seleccionados, el joven transformó su sueño en una realidad que permite a todos revivir y reimaginar el espíritu de la web antigua, mientras crea algo completamente nuevo.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: 350,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/2.png'), 
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Más Información',
                            style: TextStyle(color: Colors.white),
                                                       
                            
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.black,
              child: Center(
                child: Text(
                  '© 2024 Jose Villavicencio. Todos los derechos reservados.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
        ))],
                ),
      ),
    );
  }

  Widget _buildFeatureCard(String imagePath, String title, String description) {
    return Column(
      children: [
        Image.asset(
          imagePath, 
          width: 100,
          height: 100,
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class PixelCloud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade700,
            offset: Offset(3, 3),
            blurRadius: 8,
          ),
        ],
      ),
    );
  }
}

class PixelSpaceship extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade900,
            offset: Offset(3, 3),
            blurRadius: 8,
          ),
        ],
      ),
    );
  }
}

class PixelShootingStar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.purple],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}

// Nueva página de Inicio
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3MillionDollarPage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      home: PixelCanvas(),
      routes: {
        '/signup': (context) => SignUpPage(),
        '/buypixels': (context) => BuyPixelsPage(),
      },
    );
  }
}

class PixelCanvas extends StatefulWidget {
  @override
  _PixelCanvasState createState() => _PixelCanvasState();
}

class _PixelCanvasState extends State<PixelCanvas> {
  List<img.Image> _pixelImages = []; // List to store images
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('¡Compra Pixeles para añadir tu historia al internet!'),
        actions: [
          TextButton(
            onPressed: _pickImage,
            child: Text('Subir Imagen', style: TextStyle(color: Color.fromARGB(255, 233, 139, 7))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/buypixels');
            },
            child: Text('Compra Pixeles', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: Text('Ingresa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 1200, // Tamaño del lienzo
          height: 500,
          color: Colors.white,
          child: Stack(
            children: _pixelImages.asMap().entries.map((entry) {
              int index = entry.key;
              img.Image pixelImage = entry.value;
              double spacing = 10.0; // Espacio entre imágenes
              double leftPosition = (index % 10) * (100 + spacing); // Ajusta la posición horizontal
              double topPosition = (index ~/ 10) * (100 + spacing); // Ajusta la posición vertical
              return Positioned(
                left: leftPosition,
                top: topPosition,
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image.memory(
                    Uint8List.fromList(img.encodePng(pixelImage)),
                    fit: BoxFit.contain,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      final img.Image? decodedImage = img.decodeImage(Uint8List.fromList(bytes));

      if (decodedImage != null) {
        final img.Image resizedImage = img.copyResize(decodedImage, width: 100, height: 100); // Resize image
        final img.Image pixelatedImage = img.copyResize(resizedImage, width: 50, height: 50); // Pixelate image
        final img.Image finalImage = img.copyResize(pixelatedImage, width: 100, height: 100); // Resize back to original size

        setState(() {
          _pixelImages.add(finalImage);
        });
      }
    }
  }
}


class SignUpPage extends StatelessWidget {

  // Define validateEmail fuera del TextFormField
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'No es un correo Valido'
        : null; // Retorna null si el correo es válido
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ingresa con tu correo y contraseña',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                
              ),
              SizedBox(height: 16),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                        width: 2
                        ),
                ),
                hintText: 'ejemplo@gmail.com',
                prefixIcon: Icon(Icons.alternate_email_rounded),
              ),
              validator: validateEmail, // Usa la función definida fuera
              ),
              SizedBox(height: 16),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                        width: 2
                        ),
                ),
                hintText: '*********************',
                prefixIcon: Icon(Icons.lock_outlined),
              ),
              validator: (value) {
                return (value != null && value.length >= 6)
                ? null
                : 'La contraseña debe ser mayor o igual a los 6 caracteres';
                               
              },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context,'/home');
                },
                icon: Icon(Icons.arrow_forward_rounded),
                label: Text('Ingresar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                  disabledBackgroundColor: (Colors.grey),
                  disabledForegroundColor: (Colors.grey),
                  
                ),
              ),
              SizedBox(height: 16,),
              Text('O'),
              SizedBox(height: 16,),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.account_circle),
                label: Text('Registrate'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'By continuing, you agree to our Terms and Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuyPixelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Pixels'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Your Plan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildPriceCard(
                    context,
                    'Pixel Basic',
                    'Bs 1.99',
                    '6000 pixeles',
                    '3 imagenes',
                    '1 anuncio',
                  ),
                  _buildPriceCard(
                    context,
                    'Pixel Estandar',
                    'BS. 10.99',
                    '12000 pixeles',
                    '5 imagenes',
                    '3 anuncios',
                  ),
                  _buildPriceCard(
                    context,
                    'Pixel Premium',
                    'Bs 20.99',
                    '24000 pixeles',
                    'Hasta 12 imagenes',
                    '5 anuncios',
                  ),
                  _buildPriceCard(
                    context,
                    'Pixel Enterprise',
                    'Personalizado',
                    'Personalizado',
                    'Personalizado',
                    'Personalizado',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceCard(BuildContext context, String planName, String price, String facturas, String usuarios, String sucursales) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              planName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              price,
              style: TextStyle(
                fontSize: 24,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(facturas),
            Text(usuarios),
            Text(sucursales),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Text('Comprar ahora'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}