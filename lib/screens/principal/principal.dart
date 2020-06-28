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
import 'package:fl_chart/fl_chart.dart';

class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PrincipalPage();
  }
}

class PrincipalPage extends StatefulWidget {
  PrincipalPage({Key key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  final ScrollController scrollController = ScrollController();
  Usuario user;
  final UsuariosService usuariosService = new UsuariosService();
  dynamic arguments;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    user = arguments["usuario"];
    List<double> retorno = usuariosService.getValores(user);

    return Scaffold(
        key: _scaffoldKey,
        body: Column(children: <Widget>[
          Center(
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0)),
                  margin: EdgeInsets.fromLTRB(16.0, 20, 16.0, 5),
                  child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: Column(children: <Widget>[
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(15, 15, 15, 0),
                                        child: Text(
                                          "Total",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ))),
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(15, 5, 15, 8),
                                        child: Text(
                                          retorno[0].toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ))),
                              ]))
                            ]),
                        Row(children: [
                          Expanded(
                              child: Column(children: <Widget>[
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Text(
                                      "Receitas",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ))),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 5, 15, 8),
                                    child: Text(
                                      retorno[1].toString(),
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ))),
                          ])),
                          Expanded(
                              child: Column(children: <Widget>[
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Text(
                                      "Despesas",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ))),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 5, 15, 8),
                                    child: Text(
                                      retorno[2].toString(),
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ))),
                          ]))
                        ])
                      ])))),
          Center(
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0)),
                  margin: EdgeInsets.fromLTRB(16.0, 20, 16.0, 5),
                  child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: Column(children: <Widget>[
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(15, 15, 15, 10),
                                        child: Text(
                                          "Contas",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ))),
                              ]))
                            ]),
                        Row(children: [
                          Expanded(
                              child: Column(children: <Widget>[
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Text(
                                      "Receitas",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ))),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 5, 15, 8),
                                    child: Text(
                                      retorno[1].toString(),
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ))),
                          ])),
                          Expanded(
                              child: Column(children: <Widget>[
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Text(
                                      "Despesas",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ))),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 5, 15, 8),
                                    child: Text(
                                      retorno[2].toString(),
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ))),
                          ]))
                        ])
                      ]))))
        ]));

    // floatingActionButton: FloatingActionButton(
    //   child: Icon(FontAwesomeIcons.plus),
    //   onPressed: () {
    //     Navigator.of(context).pushNamed('/clientes/cadastrar',
    //         arguments: <String, dynamic>{
    //           "cliente": null,
    //           "endereco": null
    //         }).then((value) => this.setState(() {
    //           _future = _build(filtragem: true);
    //         }));
    //   },
    // ),
  }
}
