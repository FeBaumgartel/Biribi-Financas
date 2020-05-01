import 'package:biribi_financas/models/conta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:biribi_financas/services/database.dart' as data;


class ContasService {
  final data.Database _database = data.Database.create();
  final String _tabela = 'contas';

  Future<Conta> insert(Conta conta) async {
    conta.id = await _database.db.insert(_tabela, conta.toMap());
    return conta;
  }

  Future<List<Conta>> getContas({
    List<RelacionamentosConta> relacionamentos,
  }) async {
    List<Map> maps = await _database.db.query(
      _tabela,
      orderBy: 'id DESC',
    );

    if (maps.length == 0) {
      return new List<Conta>();
    }

    List<Conta> contas = new List<Conta>();

    for (dynamic p in maps) {
      Conta conta = Conta.fromMap(p);
      await conta.carregaRelacionamentos(relacionamentos);
      contas.add(conta);
    }

    return contas;
  }

  Future<List<Conta>> getContasByGrupo(int idGrupo,{
    List<RelacionamentosConta> relacionamentos,
  }) async {
    List<Map> maps = await _database.db.query(
      _tabela,
      where: 'idGrupo = ?',
      whereArgs: [idGrupo],
      orderBy: 'id DESC',
    );

    if (maps.length == 0) {
      return new List<Conta>();
    }

    List<Conta> contas = new List<Conta>();

    for (dynamic p in maps) {
      Conta conta = Conta.fromMap(p);
      await conta.carregaRelacionamentos(relacionamentos);
      contas.add(conta);
    }

    return contas;
  }

  Future<Conta> getConta(int id,
      {List<RelacionamentosConta> relacionamentos}) async {
    List<Map> maps = new List<Map>();
    if (id != null)
      maps = await _database.db.query(
        _tabela,
        where: 'id = ?',
        whereArgs: [id],
      );

    if (maps.length > 0) {
      var conta = Conta.fromMap(maps.first);
      if (relacionamentos != null) {
        await conta.carregaRelacionamentos(relacionamentos);
      }
      return conta;
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

  Future<int> update(Conta conta) async {
    return await _database.db.update(
      _tabela,
      conta.toMap(),
      where: 'id = ?',
      whereArgs: [conta.id],
    );
  }

  Future<Conta> insertOrUpdate(Conta conta) async {
    conta.id = await _database.db.insert(_tabela, conta.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return conta;
  }
}
