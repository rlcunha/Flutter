import 'dart:math';

import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Utils/http_exception.dart';
import '../Utils/constants.dart';
import 'package:intl/intl.dart';

class Movimento with ChangeNotifier {
  final String id;
  final DateTime dtMovimento;
  final String idUnidade;
  final String idPessoa;
  final List<ItemMovimento> itensMovimento;

  Movimento({
    this.id,
    this.dtMovimento,
    this.idUnidade,
    this.idPessoa,
    this.itensMovimento,
  });
}

class ItemMovimento with ChangeNotifier {
  final String id;
  final String idMov;
  final int tpMovimento;
  final int vlMovimento;
  final String idDespesas;
  final String tpDespesas;
  final int formaPagto;
  final String idCartao;
  final String tpCartao;

  ItemMovimento({
    this.id,
    this.idMov,
    this.tpMovimento,
    this.vlMovimento,
    this.idDespesas,
    this.tpDespesas,
    this.formaPagto,
    this.idCartao,
    this.tpCartao,
  });
}

enum FormaPagamento {
  Cartao,
  Dinheiro,
  Pix,
}

enum TipoMovimento {
  Abrir,
  Despesas,
  Cartao,
  Dinheiro,
  Ifood,
  Sangria,
  Troco,
  Fechar
}

class Movimentos with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_API_URL}/movimentos';
  List<Movimento> _movtos = [];
  List<Movimento> _mov = [];

  List<Movimento> get movtos => [..._mov];

  List<ItemMovimento> _items = [];

  List<ItemMovimento> get items {
    return _items;
  }

  int get itemsCount {
    return _items.length;
  }

  void carregarItens() {
    try {
      _movtos.forEach(
        (mov) {
          _items = mov.itensMovimento;
        },
      );
    } catch (e) {
      throw ('erro - ao carrgar item');
    }
  }

  // double totalTipoMovimento(TipoMovimento tp) {
  //   double total = 0.0;
  //   _items.forEach((key, item) {
  //     if (item.tpMovimento == tp.index) {
  //       total += item.vlMovimento;
  //     }
  //   });
  //   return total;
  // }

  void addItem(ItemMovimento movimentoItem) {
    String ind;
    try {
      if (movimentoItem.id == null) {
        ind = geraCodigoId();
        _items.add(
          new ItemMovimento(
            id: ind,
            tpMovimento: movimentoItem.tpMovimento,
            vlMovimento: movimentoItem.vlMovimento,
            idDespesas: movimentoItem.idDespesas,
            tpDespesas: movimentoItem.tpDespesas,
            formaPagto: movimentoItem.formaPagto,
            idCartao: movimentoItem.idCartao,
            tpCartao: movimentoItem.tpCartao,
          ),
        );
      }
    } catch (e) {}

    notifyListeners();
  }

  void removeItem(String movimentoItem) {
    _items.remove(movimentoItem);
    notifyListeners();
  }

  void limparItems() {
    _items = [];
    notifyListeners();
  }

  String geraCodigoId() {
    var _random = Random.secure();
    var random = List<int>.generate(4, (i) => _random.nextInt(256));
    //print(random);
    var verificador = base64Url.encode(random);
    // print('=================');
    // print(verificador);
    verificador = verificador
        .replaceAll('+', '-')
        .replaceAll('/', '_')
        .replaceAll('=', '');
    // print(verificador);
    var base64ToSha256 = utf8.encode(verificador);
    var desafio = base64Url.encode(base64ToSha256);
    // print(desafio);
    return desafio;
  }

  int get totalMovimento {
    return _movtos.length;
  }

  void obterMovimentoPorData(DateTime dt) {
    try {
      if (_mov.length == 0) {
        carregarMovimento().then((value) => _mov.forEach(
              (movt) {
                dt == dt ? _mov.add(movt) : null;
              },
            ));
      }
    } catch (e) {
      throw ('erro - ao carrgar item');
    }
  }

  Future<void> carregarMovimento() async {
    final response = await http.get("$_baseUrl.json");
    Map<String, dynamic> data = json.decode(response.body);

    _mov.clear();
    if (data != null) {
      data.forEach(
        (movimentoId, movimentoData) {
          _mov.add(
            Movimento(
              id: movimentoId,
              idPessoa: movimentoData['idPessoa'],
              idUnidade: movimentoData['idUnidade'],
              dtMovimento: DateTime.parse(movimentoData['dtMovimento']),
              itensMovimento:
                  (movimentoData['ItensMovimento'] as List<dynamic>).map(
                (item) {
                  return ItemMovimento(
                    id: item['id'],
                    tpMovimento: item['tpMovimento'],
                    vlMovimento: item['vlMovimento'],
                    idDespesas: item['idDespesas'],
                    tpDespesas: item['tpDespesas'],
                    formaPagto: item['formaPagto'],
                    idCartao: item['idCartao'],
                    tpCartao: item['tpCartao'],
                  );
                },
              ).toList(),
            ),
          );
        },
      );
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> gravarMovimento(
      Movimento mov, String idPessoa, String idUnidade) async {
    try {
      if (_items.length == 0 && _movtos.length == 0) {
        return;
      }

      if (mov != null) {
        final index = _movtos.indexWhere((pes) => pes.id == mov.id);
        if (index >= 0) {
          await http.patch(
            "$_baseUrl/${mov.id}.json",
            body: json.encode({
              'ItensMovimento': _items
                  .map((movItem) => {
                        'id': movItem.id,
                        'tpMovimento': movItem.tpMovimento,
                        'vlMovimento': movItem.vlMovimento,
                        'idDespesas': movItem.idDespesas,
                        'tpDespesas': movItem.tpDespesas,
                        'formaPagto': movItem.formaPagto,
                        'idCartao': movItem.idCartao,
                        'tpCartao': movItem.tpCartao,
                      })
                  .toList(),
            }),
          );
        }
      } else {
        final date = DateTime.now();

        final response = await http.post(
          "$_baseUrl.json",
          body: json.encode({
            'idPessoa': idPessoa,
            'idUnidade': idUnidade,
            'dtMovimento': date.toIso8601String(),
            'ItensMovimento': _items
                .map((movItem) => {
                      'id': movItem.id,
                      'tpMovimento': movItem.tpMovimento,
                      'vlMovimento': movItem.vlMovimento,
                      'idDespesas': movItem.idDespesas,
                      'tpDespesas': movItem.tpDespesas,
                      'formaPagto': movItem.formaPagto,
                      'idCartao': movItem.idCartao,
                      'tpCartao': movItem.tpCartao,
                    })
                .toList()
          }),
        );

        _movtos.add(
          Movimento(
            id: json.decode(response.body)['name'],
            idPessoa: idPessoa,
            idUnidade: idUnidade,
            dtMovimento: date,
            itensMovimento: _items.toList(),
          ),
        );
      }
      notifyListeners();
    } catch (e) {}
  }

  Future<void> alterarMovimento(Movimento mov) async {
    if (mov == null || mov.id == null) {
      return;
    }

    final index = _movtos.indexWhere((pes) => pes.id == mov.id);
    if (index >= 0) {
      await http.patch(
        "$_baseUrl/${mov.id}.json",
        body: json.encode({
          // 'idPessoa': mov.idPessoa,
          // 'idUnidade': mov.idUnidade,
          // 'dtMovimento': mov.dtMovimento.toIso8601String(),
          'ItensMovimento': _movtos[index].itensMovimento,
        }),
      );
      //_movtos[index] = mov;
      notifyListeners();
      print('Gravou');
    }
  }

  Future<void> excluirMovimento(String id) async {
    final index = _movtos.indexWhere((pes) => pes.id == id);
    if (index >= 0) {
      final mov = _movtos[index];
      _movtos.remove(mov);
      notifyListeners();

      final response = await http.delete("$_baseUrl/${mov.id}.json");

      if (response.statusCode >= 400) {
        _movtos.insert(index, mov);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto.');
      }
    }
  }
}
