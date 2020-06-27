import 'package:flutter/material.dart';
import 'package:biribi_financas/services/movimentacao.dart';
import 'package:biribi_financas/models/movimentacao.dart';

class Movimentacao extends StatelessWidget{
  @Override
  Widget build(BuildContext context){
    return new MovimentacaoPage();
  }
}

class MovimentacaoPage extends StatefulWidget {
   MovimentacaoPage({Key key}) : super(key: key);
  
  @Override 
 _MovimentacaoPageState createState => _MovimentacaoPageState(extends State<MovimentacaoPage>);
    
  }
  
  class _MovimentacaoPageState extends State<MovimentacaoPage>{
  }
 List<MovimentacaoPage> valor = new List<Movimentacao>();
  TextEditingController controller = new TextEditingController();

  void addMovimentacao(double valor) { 
    setState(() {
      valor.add(Movimentacao(valor));
    });   
  }
   @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Novo")
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            title: Text("Valor")
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              onSubmitted: addMovimentacao(valor),

            )
          ),
        ],
        children: <Widget>[
          new Row(
            title: Text("Moeda")
            chlid: TextField(
              //
            )
          )
        ]
        children: <Widget>[
          Container(
            new Row(
              children: <Widget>[
                Column(
                  title: Text("Data")
                  child: TextFild(dataCriacao)

                )
              ],)
        children: <Widget>[
          new Row(
            title: Text("Descricao")
            chlid: TextField(
              //
            )
          )
        ]
        children: <Widget>[
          new Row(
            title: Text("Tipo de Movimentacao")
            chlid: TextField(
              //
            )
          )
        ]
        children: <Widget>[
          new Row(
            title: Text("Conta ")
            chlid: TextField(
              //
            )
          )
        ]
        // Widget _bottomButtons() {
        //}
          )
      ),
    );
  }
}