import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Pessoa with ChangeNotifier {
  final String id;
  final String nome;
  final int senha;
  final bool isAtivo;
  final TipoPessoa tipoPessoa;
  final List<Email> emails;

  Pessoa(
      {this.id,
      this.nome,
      this.senha,
      this.isAtivo,
      this.tipoPessoa,
      this.emails});
}

class Email with ChangeNotifier {
  final TipoEmail tipoEmail;
  final String email;

  Email({this.tipoEmail, this.email});
}

enum TipoPessoa { Proprietario, Funcionario, Visitante }

enum TipoEmail { Pessoal, Trabalho, Outros }
