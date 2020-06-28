import 'package:biribi_financas/models/grupo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:biribi_financas/services/database.dart' as data;


class GruposService {
  final data.Database _database = data.Database.create();
  final String _tabela = 'grupo';

  Future<Grupo> insert(Grupo grupo) async {
    grupo.id = await _database.db.insert(_tabela, grupo.toMap());
    return grupo;
  }

  Future<List<Grupo>> getGrupos({
    List<RelacionamentosGrupo> relacionamentos,
  }) async {
    List<Map> maps = await _database.db.query(
      _tabela,
      orderBy: 'id DESC',
    );

    if (maps.length == 0) {
      return new List<Grupo>();
    }

    List<Grupo> grupos = new List<Grupo>();

    for (dynamic p in maps) {
      Grupo grupo = Grupo.fromMap(p);
      await grupo.carregaRelacionamentos(relacionamentos);
      grupos.add(grupo);
    }

    return grupos;
  }

  Future<Grupo> getGrupo(int id,
      {List<RelacionamentosGrupo> relacionamentos}) async {
    List<Map> maps = new List<Map>();
    if (id != null)
      maps = await _database.db.query(
        _tabela,
        where: 'id = ?',
        whereArgs: [id],
      );

    if (maps.length > 0) {
      var grupo = Grupo.fromMap(maps.first);
      if (relacionamentos != null) {
        await grupo.carregaRelacionamentos(relacionamentos);
      }
      return grupo;
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

  Future<int> update(Grupo grupo) async {
    return await _database.db.update(
      _tabela,
      grupo.toMap(),
      where: 'id = ?',
      whereArgs: [grupo.id],
    );
  }

  Future<Grupo> insertOrUpdate(Grupo grupo) async {
    grupo.id = await _database.db.insert(_tabela, grupo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return grupo;
  }
}
