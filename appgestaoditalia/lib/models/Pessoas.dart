import 'dart:convert';

import 'package:appgestaoditalia/models/Pessoa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Utils/http_exception.dart';
import '../Utils/constants.dart';
import './Pessoa.dart';

class Pessoas with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_API_URL}/Pessoas';
  List<Pessoa> _items = [];

  List<Pessoa> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  List<Pessoa> get favoriteItems {
    return _items.where((pes) => pes.isAtivo).toList();
  }

  Future<void> carregarId(String id) async {
    final response = await http.get("$_baseUrl.json");
    Map<String, dynamic> data = json.decode(response.body);

    _items.clear();
    if (data != null) {
      data.forEach((pessoaId, pessoaData) {
        _items.add(Pessoa(
          id: pessoaId,
          nome: pessoaData['nome'],
          senha: pessoaData['senha'],
          isAtivo: pessoaData['isAtivo'],
          tipoPessoa: pessoaData['tipoPessoa'],
          emails: pessoaData['emails'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> carregarTodos() async {
    final response = await http.get("$_baseUrl.json");
    Map<String, dynamic> data = json.decode(response.body);

    _items.clear();
    if (data != null) {
      data.forEach((pessoaId, pessoaData) {
        _items.add(Pessoa(
          id: pessoaId,
          nome: pessoaData['nome'],
          senha: pessoaData['senha'],
          isAtivo: pessoaData['isAtivo'],
          tipoPessoa: pessoaData['tipoPessoa'],
          emails: pessoaData['emails'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> incluir(Pessoa newPessoa) async {
    final response = await http.post(
      "$_baseUrl.json",
      body: json.encode({
        'nome': newPessoa.nome,
        'senha': newPessoa.senha,
        'isAtivo': newPessoa.isAtivo,
        'tipoPessoa': newPessoa.tipoPessoa,
        'emails': newPessoa.emails,
      }),
    );

    _items.add(Pessoa(
      id: json.decode(response.body)['name'],
      nome: newPessoa.nome,
      senha: newPessoa.senha,
      isAtivo: newPessoa.isAtivo,
      tipoPessoa: newPessoa.tipoPessoa,
      emails: newPessoa.emails,
    ));
    notifyListeners();
  }

  Future<void> alterar(Pessoa pessoa) async {
    if (pessoa == null || pessoa.id == null) {
      return;
    }

    final index = _items.indexWhere((pes) => pes.id == pessoa.id);
    if (index >= 0) {
      await http.patch(
        "$_baseUrl/${pessoa.id}.json",
        body: json.encode({
          'nome': pessoa.nome,
          'senha': pessoa.senha,
          'tipoPessoa': pessoa.tipoPessoa,
          'emails': pessoa.emails,
        }),
      );
      _items[index] = pessoa;
      notifyListeners();
    }
  }

  Future<void> excluir(String id) async {
    final index = _items.indexWhere((pes) => pes.id == id);
    if (index >= 0) {
      final pessoa = _items[index];
      _items.remove(pessoa);
      notifyListeners();

      final response = await http.delete("$_baseUrl/${pessoa.id}.json");

      if (response.statusCode >= 400) {
        _items.insert(index, pessoa);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto.');
      }
    }
  }
}
