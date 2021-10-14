import 'package:flutter/material.dart';

class MenuCompras extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Compras'),
          backgroundColor: Theme.of(context).accentColor,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.fact_check_sharp),
                text: 'Mercado',
              ),
              Tab(
                icon: Icon(Icons.drive_eta_outlined),
                text: 'Franquia',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text('It\'s cloudy here'),
            ),
            Center(
              child: Text('It\'s rainy here'),
            ),
          ],
        ),
      ),
    );
  }
}
