import 'package:flutter/material.dart';
import 'package:listacompra/models/entidade/dadoscategoria.dart';
import 'package:listacompra/Screens/categoria/formulariocategora.dart';

class PastaCategoria extends StatefulWidget {
  final List<Categoria> _categorias = []..length = 500;

  @override
  State<StatefulWidget> createState() {
    return _PastaCategoriaState();
  }
}

class _PastaCategoriaState extends State<PastaCategoria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de categorias'),
      ),
      body: ListView.builder(
        itemCount: widget._categorias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._categorias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          })).then(
            (transferenciaRecebida) => _atualiza(transferenciaRecebida),
          );
        },
      ),
    );
  }

  void _atualiza(Categoria transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() {
        transferenciaRecebida.codigo = widget._categorias.length;
        widget._categorias.add(transferenciaRecebida);
      });
    }
  }
}

class ItemTransferencia extends StatelessWidget {
  final Categoria _categoria;

  ItemTransferencia(this._categoria);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      // leading: Icon(Icons.monetization_on),
      title: Text(_categoria.codigo.toString()),
      subtitle: Text(_categoria.nome.toString()),
    ));
  }
}
