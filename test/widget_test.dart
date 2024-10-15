import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:three_million_page/main.dart'; // Asegúrate de que esta ruta sea correcta.

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Inicializa la app principal, cambia el nombre de la clase por el correcto.
    await tester.pumpWidget(const MyApp());

    // Verifica que inicialmente el contador esté en 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Simula un tap en el botón con el ícono de "add".
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifica que el contador haya incrementado a 1.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
