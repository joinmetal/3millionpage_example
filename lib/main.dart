import 'package:flutter/material.dart';
import 'package:three_million_page/dentro de la web/general.dart';

void main() {
  runApp(const MyApp());
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
      initialRoute: '/', // Se cambió a '/' para que ThreeMillionDollarPage sea la página inicial
      routes: {
        '/': (context) => const ThreeMillionDollarPage(), // Se añadió la ruta para '/'
        '/home': (context) => HomePage(),
        '/pixelcanvas': (context) => PixelCanvas(),
        '/signup': (context) => SignUpPage(), 
        '/buypixels': (context) => BuyPixelsPage(), 
      },
    );
  }
}