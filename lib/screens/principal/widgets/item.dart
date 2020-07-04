import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:biribi_financas/services/usuarios.dart';
import 'package:biribi_financas/services/contas.dart';
import 'package:biribi_financas/services/grupos.dart';
import 'package:biribi_financas/services/movimentacoes.dart';
import 'package:biribi_financas/models/usuario.dart';
import 'package:biribi_financas/models/conta.dart';
import 'package:biribi_financas/models/grupo.dart';
import 'package:biribi_financas/models/movimentacao.dart';
import 'package:biribi_financas/theme.dart' as ThemeApp;
import 'package:biribi_financas/models/conta.dart';
import 'package:biribi_financas/services/contas.dart';

// ignore: must_be_immutable
class Item extends StatelessWidget {
  ContasService contasService = new ContasService();
  Conta conta;

  Item(this.conta);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Column(children: <Widget>[
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.fromLTRB(15, 15, 15, 8),
                child: Text(conta.nome,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left)))
      ])),
      Expanded(
          child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 8),
                  child: Text(conta.saldo.toString(),
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left))))
    ]);
  }
}
