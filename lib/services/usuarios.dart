import 'package:biribi_financas/models/conta.dart';
import 'package:biribi_financas/models/movimentacao.dart';
import 'package:biribi_financas/models/usuario.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:biribi_financas/services/database.dart' as data;


class UsuariosService {
  final data.Database _database = data.Database.create();
  final String _tabela = 'usuario';

  Future<Usuario> insert(Usuario usuario) async {
    usuario.id = await _database.db.insert(_tabela, usuario.toMap());
    return usuario;
  }

  Future<List<Usuario>> getUsuarios({
    List<RelacionamentosUsuario> relacionamentos,
  }) async {
    List<Map> maps = await _database.db.query(
      _tabela,
      orderBy: 'id DESC',
    );

    if (maps.length == 0) {
      return new List<Usuario>();
    }

    List<Usuario> usuarios = new List<Usuario>();

    for (dynamic p in maps) {
      Usuario usuario = Usuario.fromMap(p);
      await usuario.carregaRelacionamentos(relacionamentos);
      usuarios.add(usuario);
    }

    return usuarios;
  }

  Future<List<Usuario>> getUsuariosByGrupo(int id_grupo,{
    List<RelacionamentosUsuario> relacionamentos,
  }) async {
    List<Map> maps = await _database.db.query(
      _tabela,
      where: 'id_grupo = ?',
      whereArgs: [id_grupo],
      orderBy: 'id DESC',
    );

    if (maps.length == 0) {
      return new List<Usuario>();
    }

    List<Usuario> usuarios = new List<Usuario>();

    for (dynamic p in maps) {
      Usuario usuario = Usuario.fromMap(p);
      await usuario.carregaRelacionamentos(relacionamentos);
      usuarios.add(usuario);
    }

    return usuarios;
  }

  Future<Usuario> getUsuario(int id,
      {List<RelacionamentosUsuario> relacionamentos}) async {
    List<Map> maps = new List<Map>();
    if (id != null)
      maps = await _database.db.query(
        _tabela,
        where: 'id = ?',
        whereArgs: [id],
      );

    if (maps.length > 0) {
      var usuario = Usuario.fromMap(maps.first);
      if (relacionamentos != null) {
        await usuario.carregaRelacionamentos(relacionamentos);
      }
      return usuario;
    }

    return null;
  }

  Future<int> delete(int id) async {
    return await _database.db.delete(
      _tabela,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Usuario usuario) async {
    return await _database.db.update(
      _tabela,
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<Usuario> insertOrUpdate(Usuario usuario) async {
    usuario.id = await _database.db.insert(_tabela, usuario.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return usuario;
  }

  Future<Usuario> validarLogin(String login, String senha) async {
    List<Map> maps = await _database.db.query(
      _tabela,
      where: 'login = ? and senha = ?',
      whereArgs: [login, senha],
      orderBy: 'id DESC',
    );

    Usuario usuario = new Usuario();
    if (maps.length == 0) {
      return null;
    }


      usuario = Usuario.fromMap(maps.first);
      

    return usuario;
  }

  List<double> getValores(Usuario usuario){
    usuario.carregaRelacionamentos([RelacionamentosUsuario.grupo]);
    List<double> retorno = new List<double>(3);
    retorno[0]=0.0;
    retorno[1]=0.0;
    retorno[2]=0.0;
    DateTime data = DateTime.now();
    for(Conta conta in usuario.grupo.contas){
      retorno[0] += conta.saldo;
      for(Movimentacao movimentacao in conta.movimentacoes){
        DateTime datamovimentacao=DateTime.parse(movimentacao.dataCriacao);
        if(data.month == datamovimentacao.month){
          if(movimentacao.tipo==1){
            retorno[1]+=movimentacao.valor;
          }else{
            retorno[2]+=movimentacao.valor;
          }
        }
      }
    }
    return retorno;
  }
}
