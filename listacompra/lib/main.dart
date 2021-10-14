import 'package:flutter/material.dart';
import 'package:listacompra/Screens/menu/menubarra.dart';

void main() => runApp(Barra());

class Barra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red[900],
        accentColor: Colors.red[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.red[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: BarraInferior(),
    );
  }
}
