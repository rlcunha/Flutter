import 'package:flutter/material.dart';
import 'package:listacompra/models/entidade/enumerador.dart';
import 'package:listacompra/Screens/categoria/listacategoria.dart';
import 'package:listacompra/Screens/inicial/inicio.dart';
//import 'package:listacompra/views/menu/retornatelainicial.dart';

class BarraInferior extends StatefulWidget {
  BarraInferior({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<BarraInferior> {
  TipoBarraInicial _selectedIndex = TipoBarraInicial.inicio;

  final List<Widget> _children = [
    PastaInicio(),
    PastaCategoria(),
  ];

//  static const TextStyle optionStyle =
//      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = TipoBarraInicial.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex.index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_none),
            label: 'Categoria',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_1),
            label: 'Produto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Compra',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorito',
          )
        ],
        currentIndex: _selectedIndex.index,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
