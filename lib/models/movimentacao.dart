import 'package:biribi_financas/models/conta.dart';
import 'package:biribi_financas/models/grupo.dart';
import 'package:biribi_financas/models/usuario.dart';
import 'package:biribi_financas/services/contas.dart';
import 'package:biribi_financas/services/grupos.dart';
import 'package:biribi_financas/services/usuarios.dart';

enum RelacionamentosMovimentacao { conta, usuario, grupo }

class Movimentacao {
  int id;
  String dataCriacao;
  String dataVencimento;
  double valor;
  int tipo;
  int id_conta;
  Conta conta;
  int id_usuario;
  Usuario usuario;
  int id_grupo;
  Grupo grupo;

  Movimentacao({
    this.id,
    this.dataCriacao,
    this.dataVencimento,
    this.valor,
    this.tipo,
    this.id_conta,
    this.id_usuario,
    this.id_grupo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dataCriacao': dataCriacao,
      'dataVencimento': dataVencimento,
      'valor': valor,
      'tipo': tipo,
      'id_conta': id_conta,
      'id_usuario': id_usuario,
      'id_grupo': id_grupo,
    };
  }

  Movimentacao.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    dataCriacao = map['dataCriacao'];
    dataVencimento = map['dataVencimento'];
    valor = double.tryParse(map['valor'].toString()) ?? 0.00;
    tipo = map['tipo'];
    id_conta = map['id_conta'];
    id_usuario = map['id_usuario'];
    id_grupo = map['id_grupo'];
  }

  Future<void> carregaRelacionamentos(
    List<RelacionamentosMovimentacao> relacionamentos,
  ) async {
    for (RelacionamentosMovimentacao relacionamento in relacionamentos) {
      switch (relacionamento) {
        case RelacionamentosMovimentacao.conta:
          await this.getConta();
          break;
        case RelacionamentosMovimentacao.grupo:
          await this.getGrupo();
          break;
        case RelacionamentosMovimentacao.usuario:
          await this.getUsuario();
          break;
        default:
          break;
      }
    }
  }

  Future<void> getConta() async {
    var contas = new ContasService();
    this.conta = await contas.getConta(this.id_conta, relacionamentos: [
      RelacionamentosConta.usuario,
    ]);
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
