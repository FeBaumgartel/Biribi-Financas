import 'package:biribi_financas/models/usuario.dart';
import 'package:biribi_financas/services/contas.dart';
import 'package:biribi_financas/services/movimentacoes.dart';
import 'package:biribi_financas/services/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:biribi_financas/models/movimentacao.dart' as Mov;

class Movimentacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MovimentacaoPage();
  }
}

class MovimentacaoPage extends StatefulWidget {
  MovimentacaoPage({Key key}) : super(key: key);

  @override
  _MovimentacaoPageState createState() => _MovimentacaoPageState();
}

class _MovimentacaoPageState extends State<MovimentacaoPage> {
  Usuario user;
  final UsuariosService usuariosService = new UsuariosService();
  final ContasService contasService = new ContasService();
  final MovimentacoesService movimentacoesService = new MovimentacoesService();
  dynamic arguments;

  TextEditingController _conta = new TextEditingController();
  TextEditingController _valor = new TextEditingController();
  TextEditingController _vencimento = TextEditingController();

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Criando '+ (arguments["tipo"] == 1 ? 'Receita' : 'Despesa')),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 350,
                    child: TextField(
                      controller: _conta,
                      style: TextStyle(fontSize: 24.0),
                      decoration: InputDecoration(
                          labelText: 'Id da Conta'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 350,
                    child: TextField(
                      controller: _valor,
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
            ],
          ),
          Row(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 350,
                    child: TextField(
                      controller: _vencimento,
                      style: TextStyle(fontSize: 24.0),
                      decoration: InputDecoration(
                          icon: Icon(Icons.monetization_on),
                          labelText: 'Data de Vencimento',
                          hintText: 'DD/MM/YYYY'),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
              ),
            ],
          ),
          RaisedButton(
              child: Text('Confirmar'),
              onPressed: () async {
                print("sadfasdfasdfsd");
                Mov.Movimentacao mov = new Mov.Movimentacao();
                mov.id_conta = int.tryParse(_conta.text);
                mov.id_usuario = arguments["usuario"].id;
                mov.dataCriacao = DateTime.now().toString();
                mov.dataVencimento = _vencimento.text;
                mov.tipo = arguments["tipo"];
                mov.valor = double.tryParse(_valor.text);

                movimentacoesService.insert(mov);
                Navigator.pushNamed(context, '/principal',arguments: {'usuario': arguments["usuario"]});
              }),
        ],
      ),
    );
  }
}