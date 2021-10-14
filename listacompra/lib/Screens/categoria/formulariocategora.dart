import 'package:listacompra/controls/editor.dart';
import 'package:listacompra/models/entidade/dadoscategoria.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Categoria de Produtos';

const _rotuloCampoCategoria = 'Descrição Categoria';
const _dicaCampoCategoria = '';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoCategoria =
      TextEditingController();
  int _codigoCategoria = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                controlador: _controladorCampoCategoria,
                dica: _dicaCampoCategoria,
                rotulo: _rotuloCampoCategoria,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 2),
                onPressed: () => _criaTransferencia(context),
                child: Text(_textoBotaoConfirmar),
              )
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final String descricaoCategoria = _controladorCampoCategoria.text;
    if (descricaoCategoria != null) {
      final transferenciaCriada =
          Categoria(_codigoCategoria++, descricaoCategoria);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
