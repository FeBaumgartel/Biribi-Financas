import 'package:biribi_financas/models/conta.dart';
import 'package:biribi_financas/models/grupo.dart';
import 'package:biribi_financas/models/usuario.dart';

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

  // Future<void> carregaRelacionamentos(
  //   List<RelacionamentosMovimentacao> relacionamentos,
  // ) async {
  //   for (RelacionamentosMovimentacao relacionamento in relacionamentos) {
  //     switch (relacionamento) {
  //       case RelacionamentosMovimentacao.segmento:
  //         await this.getSegmento();
  //         break;
  //       case RelacionamentosMovimentacao.subsegmento:
  //         await this.getSubSegmento();
  //         break;
  //       case RelacionamentosMovimentacao.enderecos:
  //         await this.getEndereco();
  //         break;
  //       case RelacionamentosMovimentacao.contatos:
  //         await this.getContato();
  //         break;
  //       default:
  //         break;
  //     }
  //   }
  // }

  // Future<void> getSegmento() async {
  //   var segmentos = new SegmentosService();
  //   this.segmento = await segmentos.getSegmento(this.idSegmento);
  // }

  // Future<void> getSubSegmento() async {
  //   var subSegmentos = new SubSegmentosService();
  //   this.subSegmento = await subSegmentos.getSubSegmento(this.idSubSegmento);
  // }

  // Future<void> getEndereco() async {
  //   var clientesEnderecos = new MovimentacaosEnderecosService();
  //   this.enderecos = await clientesEnderecos
  //       .getMovimentacaoEnderecoByIdMovimentacao(this.idLocal, relacionamentos: [
  //     RelacionamentosMovimentacaoEndereco.cidade,
  //     RelacionamentosMovimentacaoEndereco.estado,
  //     RelacionamentosMovimentacaoEndereco.pais
  //   ]);
  // }

  // Future<void> getContato() async {
  //   var clientesContatos = new MovimentacaosContatosService();
  //   this.contatos = await clientesContatos
  //       .getMovimentacaoContatoByIdMovimentacao(this.idLocal, relacionamentos: [
  //     RelacionamentosMovimentacaoContato.cargo,
  //     RelacionamentosMovimentacaoContato.interesses
  //   ]);
  // }
}
