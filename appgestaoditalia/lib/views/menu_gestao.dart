import 'package:appgestaoditalia/Utils/app_routes.dart';
import 'package:appgestaoditalia/models/movimentos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuGestao extends StatelessWidget {
  final List<Map<String, Object>> _listaTelas = [
    {
      'titulo': 'Abrir',
      'tela': AppRoutes.LANCAMENTO_ABRIR_CAIXA,
      'icon': Icons.lock_open,
    },
    {
      'titulo': 'Despesas',
      'tela': AppRoutes.LANCAMENTO_DESPESAS,
      'icon': Icons.account_balance_wallet_outlined,
    },
    {
      'titulo': 'Cartão',
      'tela': AppRoutes.LANCAMENTO_CARTAO,
      'icon': Icons.credit_card_outlined,
    },
    {
      'titulo': 'Dinheiro',
      'tela': 'tela()',
      'icon': Icons.monetization_on_outlined,
    },
    {
      'titulo': 'Ifood OnLine',
      'tela': 'tela()',
      'icon': Icons.food_bank_outlined,
    },
    {
      'titulo': 'Sangria',
      'tela': 'tela()',
      'icon': Icons.group_work,
    },
    {
      'titulo': 'Troco',
      'tela': 'tela()',
      'icon': Icons.money,
    },
    {
      'titulo': 'Fechar',
      'tela': 'tela()',
      'icon': Icons.lock_clock,
    },
  ];

  @override
  Widget build(BuildContext context) {
    Movimentos mov = Provider.of<Movimentos>(context, listen: false);
    mov.obterMovimentoPorData(DateTime.now());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lancamentos Diarios'),
          backgroundColor: Theme.of(context).accentColor,
        ),
        body: GridView(
          padding: const EdgeInsets.all(28),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 2 / 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: _listaTelas.map((form) {
            return InkWell(
              focusColor: Theme.of(context).primaryTextTheme.headline3.color,
              onTap: () {
                Navigator.of(context)
                    .pushNamed(form['tela']
                        //   arguments: mov,
                        )
                    .then((value) => mov.gravarMovimento(mov.movtos.length==0?null:mov.movtos[0],'0009','0099'));
              },
              // splashColor: Theme.of(context).primaryColor,
              // borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          form['icon'],
                          size: 50,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              .color,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(form['titulo'],
                            style: TextStyle(
                                //fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1
                                    .color)),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                    colors: [
                      Colors.red[900],
                      Colors.red[700],
                      Colors.redAccent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
