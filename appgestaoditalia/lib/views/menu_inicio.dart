import 'package:appgestaoditalia/components/drawer_componentes.dart';
import 'package:appgestaoditalia/core/app_images.dart';
import 'package:flutter/material.dart';

class MenuInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Inicio'),
          backgroundColor: Theme.of(context).accentColor,
        ),
        drawer: DrawerComponent(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  height: 300,
                  child: Image.asset(
                    AppImages.logo,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Text('Mais que café, Momentos!',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          color: Colors.red[900])),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
