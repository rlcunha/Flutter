import '../components/drawer_componentes.dart';
import '../views/menu_compras.dart';
import '../views/menu_entregas.dart';
import '../views/menu_relatorios.dart';
import '../views/menu_gestao.dart';
import '../views/menu_inicio.dart';

import 'package:flutter/material.dart';

class MenuPrincipal extends StatefulWidget {
  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  int _currentIndex;

  final List<Map<String, Object>> _lstItemMenu = [
    {'titulo': 'Bem vindo ao Inverno Ditalia', 'tela': MenuInicio()},
    {'titulo': 'Lancamentos diarios', 'tela': MenuGestao()},
    {'titulo': 'Relatorios e estatisticas', 'tela': MenuRelatorios()},
    {'titulo': 'Listas de compras', 'tela': MenuCompras()},
    {'titulo': 'Controle seu delivery', 'tela': MenuEntregas()}
  ];

  _telaSelecionada(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(_lstItemMenu[_currentIndex]['titulo']),
        //   backgroundColor: Theme.of(context).accentColor,
        // ),
        // drawer: DrawerComponent(),
        body: _lstItemMenu[_currentIndex]['tela'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _telaSelecionada,
          backgroundColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.red[200],
          showUnselectedLabels: true,
          selectedFontSize: 12,
          iconSize: 25,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              tooltip: '',
              backgroundColor: Theme.of(context).accentColor,
              label: 'Início',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              tooltip: '',
              backgroundColor: Theme.of(context).accentColor,
              label: 'Gestão',
              icon: Icon(Icons.work),
            ),
            BottomNavigationBarItem(
              tooltip: '',
              backgroundColor: Theme.of(context).accentColor,
              label: 'Relatorios',
              icon: Icon(Icons.print),
            ),
            BottomNavigationBarItem(
              tooltip: '',
              backgroundColor: Theme.of(context).accentColor,
              label: 'Compras',
              icon: Icon(Icons.shopping_cart),
            ),
            BottomNavigationBarItem(
              tooltip: '',
              label: 'Entregas',
              icon: Icon(Icons.two_wheeler_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
