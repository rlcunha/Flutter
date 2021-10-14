import 'package:flutter/material.dart';

class LancamentoDespesas extends StatefulWidget {
  @override
  _LancamentoDespesasState createState() => _LancamentoDespesasState();
}

class _LancamentoDespesasState extends State<LancamentoDespesas> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
          appBar: AppBar(
            title: Text('Despesas',
                style: TextStyle(
                    //fontStyle: FontStyle.italic,
                    fontSize: 22,
                    color: Colors.white)),
            backgroundColor: Colors.red[900],
            
          //   // actions: <Widget>[
          //   //   IconButton(
          //   //     icon: const Icon(Icons.backpack_outlined),
          //   //     onPressed: () {
          //   //       Navigator.pop(context);
          //   //     },
          //   //   )
          //   //],
          ),
          body: Column(
            children: [
              Text('pessoa.nome'),
              Center(
                  child: TextButton(
                      child: Text('VOLTAR'),
                      onPressed: () {
                        Navigator.pop(context);
                      }))
            ],
          )),
    );
  }
}
