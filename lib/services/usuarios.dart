import 'package:biribi_financas/models/usuario.dart';
import 'package:sqflite/sqflite.dart';

class UsuariosService {
  final data.Database _database = data.Database.create();
  final String _tabela = 'usuarios';

  Future<Usuario> insert(Usuario usuario) async {
    usuario.id = await _database.db.insert(_tabela, usuario.toMap());
    return usuario;
  }

  Future<List<Usuario>> getUsuarios({
    int pagina = 1,
    int porPagina = 10,
    List<RelacionamentosUsuario> relacionamentos,
  }) async {
    List<Map> maps = await _database.db.query(
      _tabela,
      orderBy: 'id DESC',
      limit: porPagina,
      offset: (porPagina * (pagina - 1)),
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

  Future<List<Usuario>> getUsuariosFiltro(
      {int pagina = 1,
      int porPagina = 10,
      List<RelacionamentosUsuario> relacionamentos,
      List<Map> filtros,
      String pesquisa}) async {
    String tipo = '';
    String status = '';
    if (filtros != null)
      for (Map filtro in filtros) {
        if (filtro['titulo'] == "Tipo") {
          switch (filtro['nome']) {
            case "Pessoa Jurídica":
              {
                tipo += "1,";
                break;
              }
            case "Pessoa Física":
              {
                tipo += "2,";
                break;
              }
            case "Usuario de Exportação":
              {
                tipo += "3,";
                break;
              }
          }
        }
        if (filtro['titulo'] == "Status") {
          status += (filtro['nome'] == "Ativo" ? "1," : "2,");
        }
      }

    if (tipo != '' && tipo.substring(tipo.length - 1) == ",") {
      tipo = tipo.substring(0, tipo.length - 1);
    }

    if (status != '' && status.substring(status.length - 1) == ",") {
      status = status.substring(0, status.length - 1);
    }

    if (pesquisa == null) {
      pesquisa = "";
    }

    List<Map> maps = await _database.db.query(
      _tabela,
      orderBy: 'id DESC',
      limit: porPagina,
      offset: (porPagina * (pagina - 1)),
      where:
          "('$tipo' = '' OR tipo IN ($tipo)) AND ('$status' = '' OR status IN ($status)) AND (nome_fantasia LIKE '%$pesquisa%' OR razao_social LIKE '%$pesquisa%' OR cnpj_cpf LIKE '%$pesquisa%')",
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

  Future<List<Usuario>> getUsuariosAll() async {
    List<Map> maps = await _database.db.query(
      _tabela,
    );

    if (maps.length == 0) {
      return new List<Usuario>();
    }

    List<Usuario> usuarios = new List<Usuario>();

    for (dynamic p in maps) {
      Usuario usuario = Usuario.fromMap(p);
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
        where: 'id_local = ?',
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
      where: 'id_local = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Usuario usuario) async {
    return await _database.db.update(
      _tabela,
      usuario.toMap(),
      where: 'id_local = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<bool> checkSincronizacao(Usuario usuario) async {
    List<Map> maps = await _database.db
        .query(_tabela, where: 'id = ?', whereArgs: [usuario.id]);

    if (maps.length > 0) {
      return true;
    }

    return false;
  }

  Future<Usuario> insertOrUpdate(Usuario usuario) async {
    usuario.id = await _database.db.insert(_tabela, usuario.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return usuario;
  }
}
