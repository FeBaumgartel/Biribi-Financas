

import 'package:biribi_financas/models/grupo.dart';
import 'package:biribi_financas/models/movimentacao.dart';
import 'package:biribi_financas/models/usuario.dart';

enum RelacionamentosConta { movimentacoes, usuario, grupo }

class Conta {
  int id;
  String nome;
  double saldo;
  bool publica;
  int idUsuario;
  Usuario usuario;
  int idGrupo;
  Grupo grupo;
  List<Movimentacao> movimentacoes;

  Conta({
    this.id,
    this.nome,
    this.saldo,
    this.publica,
    this.idUsuario,
    this.idGrupo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'saldo': saldo,
      'publica': publica,
      'id_usuario': idUsuario,
      'id_grupo': idGrupo,
    };
  }

  Conta.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    saldo = double.tryParse(map['saldo'].toString()) ?? 0.00;
    publica = map['publica'];
    idUsuario = map['id_usuario'];
    idGrupo = map['id_grupo'];
  }

  Future<void> carregaRelacionamentos(
    List<RelacionamentosConta> relacionamentos,
  ) async {
    for (RelacionamentosConta relacionamento in relacionamentos) {
      switch (relacionamento) {
        case RelacionamentosConta.movimentacoes:
          await this.getMovimentacoes();
          break;
        case RelacionamentosConta.grupo:
          await this.getGrupo();
          break;
        case RelacionamentosConta.usuario:
          await this.getUsuario();
          break;
        default:
          break;
      }
    }
  }

  Future<void> getMovimentacoes() async {
    var movimentacoes = new MovimentacoesService();
    this.movimentacoes = await movimentacoes.getConta(this.id);
  }

  Future<void> getGrupo() async {
    var grupos = new GruposService();
    this.grupo = await grupos.getGrupo(this.grupo);
  }

  Future<void> getUsuario() async {
    var usuarios = new UsuariosService();
    this.usuario = await usuarios.getUsuario(this.idUsuario, relacionamentos: [
      RelacionamentosUsuario.grupo,
    ]);
  }
}
