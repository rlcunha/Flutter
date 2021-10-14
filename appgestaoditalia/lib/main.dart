

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/Pessoa.dart';
import './models/movimentos.dart';

import './views/lancamento_abrir_caixa.dart';
import './views/menu_gestao.dart';
import './views/menu_inicio.dart';
import './views/menu_relatorios.dart';
import './views/menu_entregas.dart';
import './views/lancamento_despesas.dart';
import './views/tela_principal.dart';

import './views/lancamento_cartao.dart';

import './Utils/app_routes.dart';

void main() => runApp(AppGestaoDitalia());

class AppGestaoDitalia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Pessoa(
            id: '001',
            nome: 'Ricardo',
            senha: 1,
            isAtivo: true,
            tipoPessoa: TipoPessoa.Proprietario,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => new Movimentos(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => new Orders(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red[900],
          accentColor: Colors.red[900],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.white,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: MenuPrincipal(),
        routes: {
          // AppRoutes.HOME: (ctx) => MenuPrincipal(),
          AppRoutes.INICIO: (ctx) => MenuInicio(),
          AppRoutes.GESTAO: (ctx) => MenuGestao(),
          AppRoutes.LANCAMENTO_ABRIR_CAIXA: (ctx) => AbrirCaixa(),
          AppRoutes.LANCAMENTO_DESPESAS: (ctx) => LancamentoDespesas(),
          AppRoutes.LANCAMENTO_CARTAO: (ctx) => LancamentoCartao(),
          AppRoutes.RELATORIO: (ctx) => MenuRelatorios(),
          AppRoutes.COMPRAS: (ctx) => MenuEntregas(),
        },
      ),
    );
  }
}
