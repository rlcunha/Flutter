import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Pessoa.dart';

class DrawerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pessoa pessoa = Provider.of<Pessoa>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(

            accountName: Text('${pessoa.nome.toString()}'),
            accountEmail: Text("rlcunha@gmail.com"),
            // currentAccountPicture: CircleAvatar(
            //   radius: 30.0,
            //   backgroundImage: NetworkImage(
            //       'http://www.macoratti.net/imagens/pessoas/mac.jpg'),
            //   backgroundColor: Colors.transparent,
            // ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Text(
                pessoa.nome.substring(0,1).toUpperCase(),
                style: TextStyle(fontSize: 40.0, color: Colors.red[900]),
              ),
            ),
            decoration: BoxDecoration(color: Colors.red[900])
          ),
          ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("meus favoritos..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                debugPrint('toquei no drawer');
              }),
          ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Perfil"),
              subtitle: Text("Perfil do usuário..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
