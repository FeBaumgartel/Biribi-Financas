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

/*
import 'package:flutter/material.dart';

void main() {
  runApp(Biribim());
}

class Biribim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.indigo[400],
          accentColor: Colors.purpleAccent[700],
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.indigo[400],
              textTheme: ButtonTextTheme.primary
          )
      ),
      home: ListaTransferencia(),
    );
  }
}

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoMovimentacao = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();
  final TextEditingController _controladorCampoData = TextEditingController();
  final TextEditingController _controladorCampoDescricao = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Movimentação'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoMovimentacao,
              rotulo: 'Tipo de Movimentação',
            ),

            Editor(
              controlador: _controladorCampoValor,
              rotulo: 'Valor',
              dica: '0.00',
              icone: Icons.monetization_on,
            ),
            Editor(
              controlador: _controladorCampoData,
              rotulo: 'Data',
              dica: 'DD/MM/YYYY',
            ),
            Editor(
              controlador: _controladorCampoDescricao,
              rotulo: 'Descrição',
              dica: 'Texto',
            ),
            RaisedButton(
              child: Text('Confirmar'),
              onPressed: () => _criaTransferencia(context),
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final String movimentacao = _controladorCampoMovimentacao.text;
    final double valor = double.tryParse(_controladorCampoValor.text);
    final String data = _controladorCampoData.text;
    final String descricao = _controladorCampoDescricao.text;
    if (movimentacao != null && valor != null) {
      final transferenciaCriada = Transferencia(
          valor, movimentacao,data, descricao);
      debugPrint('Criar Movimentação');
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  String rotulo;
  String dica;
  final IconData icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: Icon(icone) != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}

class ListaTransferencia extends StatefulWidget {
  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movimentações'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia> future =
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            Future.delayed(Duration(seconds: 1), () {
              debugPrint('chegou no then do future');
              debugPrint('$transferenciaRecebida');
              if (transferenciaRecebida != null) {
                setState(() {
                  widget._transferencias.add(transferenciaRecebida);
                });
              }
            });
          });
        },
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
        title: Text(transferencia.movimentacao.toString()),
        subtitle: Text(transferencia.Descricao()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final String movimentacao;
  final String data;
  final String descricao;

  Transferencia(this.valor, this.movimentacao, this.data, this.descricao);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, movimentacao: $movimentacao, data: $data}';
  }

  String Descricao() {
    return 'Valor: $valor\n Data: $data\n Descrição: $descricao' ;

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
