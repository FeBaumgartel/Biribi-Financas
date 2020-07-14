import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
import 'package:biribi_financas/screens/principal/widgets/item.dart' as Item;

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
  final ContasService contasService = new ContasService();
  dynamic arguments;
  Future<List<Widget>> _future;
  List<Widget> widgets;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<List<Widget>> _build(Usuario usuario) async {
    this.widgets = new List<Widget>();
    List<Conta> contas = await contasService.getContasByUsuario(usuario.id);
    print("sadfasdfasdfsd");

    contas.forEach((Conta conta) {
      this.widgets.add(Item.Item(conta));
    });

    return this.widgets;
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    user = arguments["usuario"];
    _future = _build(arguments["usuario"]);
    List<double> retorno = usuariosService.getValores(user);
/*import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
  TextEditingController();
  final TextEditingController _controladorCampoNumeroValor =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferencia'),
      ),

      body:
      Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    child: TextField(
                      controller: _controladorCampoNumeroConta,
                      style: TextStyle(fontSize: 24.0),
                      decoration: InputDecoration(
                          icon: Icon(Icons.monetization_on),
                          labelText: 'Valor',
                          hintText: '0.00'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(75.0, 8.0, 8.0, 8.0),
                  child: Container(
                    width: 150,
                    child: TextField(
                      style: TextStyle(fontSize: 24.0),
                      decoration:
                      InputDecoration(labelText: 'Moeda', hintText: '0.00'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controladorCampoNumeroValor,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: 'Valor',
                  hintText: '0.00'),
              keyboardType: TextInputType.number,
            ),
          ),
          RaisedButton(
            child: Text('Confirmar'),
            onPressed: () {
              final int numeroConta =
              int.tryParse(_controladorCampoNumeroConta.text);
              final double valor =
              double.tryParse(_controladorCampoNumeroValor.text);
              if (numeroConta != null && valor != null) {
                final transferenciaCriada = Transferencia(valor, numeroConta);
                debugPrint('$transferenciaCriada');
              }
            },
          ),
        ],
      ),
    );
  }
}

class Editor extends StatelessWidget {
  final TextEditingController _controlador;
  String _rotulo;
  String _dica;

  Editor(this._controlador, this._rotulo, this._dica);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        child: TextField(
          controller: _controlador,
          style: TextStyle(fontSize: 24.0),
          decoration: InputDecoration(
              icon: Icon(Icons.monetization_on),
              labelText: _rotulo,
              hintText: _dica),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}

class ListaTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ItemTransferencia(Transferencia(100.0, 10000)),
          ItemTransferencia(Transferencia(200.0, 20000)),
          ItemTransferencia(Transferencia(300.0, 30000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Movimentação'),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia transferencia;

  ItemTransferencia(this.transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(transferencia.valor.toString()),
        subtitle: Text(transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}



 */
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
                      child: new FutureBuilder<List<Widget>>(
                          future: _future,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Widget>> snapshot) {
                            if (snapshot.hasData) {
                              List<Widget> loaded = new List<Widget>();
                              loaded.add(Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        child: Column(children: <Widget>[
                                      Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 15, 15, 0),
                                              child: Text(
                                                "Contas",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.left,
                                              )))
                                    ]))
                                  ]));
                              for (dynamic widget in snapshot.data) {
                                loaded.add(widget);
                              }
                              return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: loaded);
                            } else {
                              return Container();
                            }
                          }))))
        ]),
        floatingActionButton: _bottomButtons());
  }

  Widget _bottomButtons() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      overlayOpacity: 0,
      children: [
        SpeedDialChild(
            child: Icon(FontAwesomeIcons.pencilAlt, color: Colors.white),
            onTap: () => Navigator.pushNamed(context, '/movimentacao',
                    arguments: <String, dynamic>{
                      "tipo": "receita"
                    }),
            backgroundColor: Colors.green),
        SpeedDialChild(
            child: Icon(FontAwesomeIcons.trash, color: Colors.white),
            onTap: () => Navigator.pushNamed(context, '/movimentacao',
                    arguments: <String, dynamic>{
                      "tipo": "despesa"
                    }),
            backgroundColor: Colors.red),
      ],
    );
  }
}
