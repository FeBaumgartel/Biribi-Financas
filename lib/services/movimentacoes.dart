import 'package:biribi_financas/models/conta.dart';
import 'package:biribi_financas/models/movimentacao.dart';
import 'package:biribi_financas/services/contas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:biribi_financas/services/database.dart' as data;


class MovimentacoesService {
  final data.Database _database = data.Database.create();
  final String _tabela = 'movimentacao';
  ContasService contasService = new ContasService();

  Future<Movimentacao> insert(Movimentacao movimentacao) async {
    movimentacao.id = await _database.db.insert(_tabela, movimentacao.toMap());

    Conta conta = await contasService.getConta(movimentacao.id_conta);
    if(movimentacao.tipo==0){
      conta.saldo -= movimentacao.valor;
    }else{
      conta.saldo += movimentacao.valor;
    }
    contasService.insertOrUpdate(conta);

    return movimentacao;
  }

  Future<List<Movimentacao>> getMovimentacoes({
    List<RelacionamentosMovimentacao> relacionamentos,
  }) async {
    List<Map> maps = await _database.db.query(
      _tabela,
      orderBy: 'id DESC',
    );

    if (maps.length == 0) {
      return new List<Movimentacao>();
    }

    List<Movimentacao> movimentacoes = new List<Movimentacao>();

    for (dynamic p in maps) {
      Movimentacao movimentacao = Movimentacao.fromMap(p);
      await movimentacao.carregaRelacionamentos(relacionamentos);
      movimentacoes.add(movimentacao);
    }

    return movimentacoes;
  }

  Future<List<Movimentacao>> getMovimentacoesByConta(int id_conta,{
    List<RelacionamentosMovimentacao> relacionamentos,
  }) async {
    List<Map> maps = await _database.db.query(
      _tabela,
        where: 'id_conta = ?',
      whereArgs: [id_conta],
      orderBy: 'id DESC',
    );

    if (maps.length == 0) {
      return new List<Movimentacao>();
    }

    List<Movimentacao> movimentacoes = new List<Movimentacao>();

    for (dynamic p in maps) {
      Movimentacao movimentacao = Movimentacao.fromMap(p);
      await movimentacao.carregaRelacionamentos(relacionamentos);
      movimentacoes.add(movimentacao);
    }

    return movimentacoes;
  }

  Future<Movimentacao> getMovimentacao(int id,
      {List<RelacionamentosMovimentacao> relacionamentos}) async {
    List<Map> maps = new List<Map>();
    if (id != null)
      maps = await _database.db.query(
        _tabela,
        where: 'id = ?',
        whereArgs: [id],
      );

    if (maps.length > 0) {
      var movimentacao = Movimentacao.fromMap(maps.first);
      if (relacionamentos != null) {
        await movimentacao.carregaRelacionamentos(relacionamentos);
      }
      return movimentacao;
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

  Future<int> update(Movimentacao movimentacao) async {
    return await _database.db.update(
      _tabela,
      movimentacao.toMap(),
      where: 'id = ?',
      whereArgs: [movimentacao.id],
    );
  }

  Future<Movimentacao> insertOrUpdate(Movimentacao movimentacao) async {
    movimentacao.id = await _database.db.insert(_tabela, movimentacao.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return movimentacao;
  }
}
