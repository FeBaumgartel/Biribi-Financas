import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:biribi_financas/services/usuarios.dart';
import 'package:biribi_financas/services/conta.dart';
import 'package:biribi_financas/services/grupo.dart';
import 'package:biribi_financas/services/movimentacao.dart';
import 'package:biribi_financas/models/usuario.dart';
import 'package:biribi_financas/models/conta.dart';
import 'package:biribi_financas/models/grupo.dart';
import 'package:biribi_financas/models/movimentacao.dart';
import 'package:biribi_financas/theme.dart' as ThemeApp;

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


  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;

    return new FutureBuilder<List<Widget>>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        if (snapshot.hasData) {
          List<Widget> loaded = snapshot.data;
          return Scaffold(
            body: CustomScrollView(
                controller: scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                      pinned: true,
                      expandedHeight: 170,
                      title: Text(arguments.nomeFantasia),
                      flexibleSpace: FadeOnScroll(
                          scrollController: scrollController,
                          fullOpacityOffset: 50,
                          child: Stack(
                            children: <Widget>[
                              if (arguments.razaoSocial != null &&
                                  arguments.razaoSocial.replaceAll(" ", "") !=
                                      "")
                                Container(
                                  padding: EdgeInsets.only(left: 69, right: 16),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      arguments.razaoSocial,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              if (arguments.cnpjCpf != null &&
                                  arguments.cnpjCpf.replaceAll(" ", "") != "")
                                Container(
                                  padding: EdgeInsets.only(top: 65, left: 69, right: 16),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      arguments.cnpjCpf,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              //if(arguments.cnpjCpf != null && arguments.cnpjCpf.replaceAll(" ", "") != "")
                              Container(
                                padding: EdgeInsets.only(top: 130, left: 69, right: 16),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Cliente desde: 03/02/2020',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))),
                  if (loaded != null)
                    SliverFillRemaining(
                      child: ListView(
                        padding: EdgeInsets.only(top: 5),
                        children: loaded,
                      ),
                    ),
                ]),
            // floatingActionButton: _bottomButtons(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // Widget _bottomButtons() {
  //   return _selectedIndex == 0
  //       ? SpeedDial(
  //           animatedIcon: AnimatedIcons.menu_close,
  //           overlayOpacity: 0,
  //           children: [
  //             SpeedDialChild(
  //                 child: Icon(FontAwesomeIcons.pencilAlt, 
  //                 color: Colors.grey[600]),
  //                 onTap: () => Navigator.pushNamed(
  //                         context, '/clientes/cadastrar',
  //                         arguments: <String, dynamic>{
  //                           "cliente": arguments,
  //                           "endereco": arguments.enderecos.isEmpty ? null : arguments.enderecos.first
  //                         }).then((value) => setState((){_future = _build(arguments.idLocal);})),
  //                 backgroundColor: Colors.white),
  //             SpeedDialChild(
  //                 child: Icon(FontAwesomeIcons.trash, 
  //                 color: Colors.grey[600]),
  //                 onTap: () => print("Excluir"),
  //                 backgroundColor: Colors.white),
  //           ],
  //         )
  //       : FloatingActionButton(
  //           child: Icon(FontAwesomeIcons.plus),
  //           onPressed: () {
  //             Navigator.pushNamed(
  //                 context, '/clientes/visualizar/cadastrar-editar-contato',
  //                 arguments: <String, dynamic>{
  //                   "idCliente": arguments.idLocal,
  //                   "cargos": cargosContatos
  //                 }).then((value) => setState((){_future = _build(arguments.idLocal);}));
  //           });
  // }

}
