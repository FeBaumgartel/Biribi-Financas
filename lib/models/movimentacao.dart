import 'package:biribi_financas/models/conta.dart';
import 'package:biribi_financas/models/grupo.dart';
import 'package:biribi_financas/models/usuario.dart';
import 'package:biribi_financas/services/usuarios.dart';

enum RelacionamentosMovimentacao { conta, usuario, grupo }

class Movimentacao {
  int id;
  String dataCriacao;
  String dataVencimento;
  double valor;
  bool tipo;
  int idConta;
  Conta conta;
  int idUsuario;
  Usuario usuario;
  int idGrupo;
  Grupo grupo;

  Movimentacao({
    this.id,
    this.dataCriacao,
    this.dataVencimento,
    this.valor,
    this.tipo,
    this.idConta,
    this.idUsuario,
    this.idGrupo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'data_criacao': dataCriacao,
      'data_vencimento': dataVencimento,
      'valor': valor,
      'tipo': tipo,
      'id_conta': idConta,
      'id_usuario': idUsuario,
      'id_grupo': idGrupo,
    };
  }

  Movimentacao.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    dataCriacao = map['data_criacao'];
    dataVencimento = map['data_vencimento'];
    valor = double.tryParse(map['valor'].toString()) ?? 0.00;
    tipo = map['tipo'];
    idConta = map['id_conta'];
    idUsuario = map['id_usuario'];
    idGrupo = map['id_grupo'];
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
    this.conta = await contas.getConta(this.idConta);
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
