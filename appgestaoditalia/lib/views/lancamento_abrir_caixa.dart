import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movimentos.dart';

class AbrirCaixa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Movimentos mov = Provider.of<Movimentos>(context, listen: true);
    mov.carregarItens();

    return Scaffold(
      appBar: AppBar(
        title: Text('Abertura do Caixa'),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body:
          // body: Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          ListView.builder(
        itemCount: mov.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              '${mov.items[index].tpDespesas}',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            subtitle: Text(mov.items[index].id),
            trailing: Icon(Icons.ac_unit),
            onTap: () {},
          );
        },
      ),
      //   ],
      // ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          mov.addItem(ItemMovimento(
            idCartao: '0005',
            tpCartao: 'Credito',
            idDespesas: '0501',
            tpDespesas: 'Mercado',
            tpMovimento: TipoMovimento.Despesas.index,
            formaPagto: FormaPagamento.Dinheiro.index,
            vlMovimento: 5500,
          ));
          // movimentoDiario.addItem(ItemMovimento(
          //   idCartao: '0002',
          //   tpCartao: 'Debito',
          //   idDespesas: '0201',
          //   tpDespesas: 'Farmacia',
          //   tpMovimento: TipoMovimento.Despesas.index,
          //   formaPagto: FormaPagamento.Cartao.index,
          //   vlMovimento: 500.00,
          // ));
          // movimentoDiario.addItem(ItemMovimento(
          //   idCartao: '0003',
          //   tpCartao: 'Debito',
          //   idDespesas: '0301',
          //   tpDespesas: 'Farmacia',
          //   tpMovimento: TipoMovimento.Sangria.index,
          //   formaPagto: FormaPagamento.Dinheiro.index,
          //   vlMovimento: 500.00,
          // ));

          // mov.incluir(movimentoDiario, '100000002', '000003');
        },
        label: const Text(''),
        icon: const Icon(Icons.save),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
