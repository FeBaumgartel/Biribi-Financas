import 'package:biribi_financas/models/grupo.dart';
import 'package:biribi_financas/models/movimentacao.dart';
import 'package:biribi_financas/models/usuario.dart';
import 'package:biribi_financas/services/grupos.dart';
import 'package:biribi_financas/services/movimentacoes.dart';
import 'package:biribi_financas/services/usuarios.dart';

enum RelacionamentosConta { movimentacoes, usuario, grupo }

class Conta {
  int id;
  String nome;
  double saldo;
  int publica;
  int id_usuario;
  Usuario usuario;
  int id_grupo;
  Grupo grupo;
  List<Movimentacao> movimentacoes;

  Conta({
    this.id,
    this.nome,
    this.saldo,
    this.publica,
    this.id_usuario,
    this.id_grupo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'saldo': saldo,
      'publica': publica,
      'id_usuario': id_usuario,
      'id_grupo': id_grupo,
    };
  }

  Conta.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    saldo = double.tryParse(map['saldo'].toString()) ?? 0.00;
    publica = map['publica'];
    id_usuario = map['id_usuario'];
    id_grupo = map['id_grupo'];
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
    this.movimentacoes =
        await movimentacoes.getMovimentacoesByConta(this.id,relacionamentos: []);
  }

  Future<void> getGrupo() async {
    var grupos = new GruposService();
    this.grupo = await grupos.getGrupo(this.id_grupo,relacionamentos: []);
  }

  Future<void> getUsuario() async {
    var usuarios = new UsuariosService();
    this.usuario = await usuarios.getUsuario(this.id_usuario,relacionamentos: []);
  }
}
