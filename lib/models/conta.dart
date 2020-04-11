

import 'package:biribi_financas/models/grupo.dart';
import 'package:biribi_financas/models/movimentacao.dart';
import 'package:biribi_financas/models/usuario.dart';

enum RelacionamentosConta { movimentacoes,usuario, grupo }

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

  // Future<void> carregaRelacionamentos(
  //   List<RelacionamentosConta> relacionamentos,
  // ) async {
  //   for (RelacionamentosConta relacionamento in relacionamentos) {
  //     switch (relacionamento) {
  //       case RelacionamentosConta.segmento:
  //         await this.getSegmento();
  //         break;
  //       case RelacionamentosConta.subsegmento:
  //         await this.getSubSegmento();
  //         break;
  //       case RelacionamentosConta.enderecos:
  //         await this.getEndereco();
  //         break;
  //       case RelacionamentosConta.contatos:
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
  //   var clientesEnderecos = new ContasEnderecosService();
  //   this.enderecos = await clientesEnderecos
  //       .getContaEnderecoByIdConta(this.idLocal, relacionamentos: [
  //     RelacionamentosContaEndereco.cidade,
  //     RelacionamentosContaEndereco.estado,
  //     RelacionamentosContaEndereco.pais
  //   ]);
  // }

  // Future<void> getContato() async {
  //   var clientesContatos = new ContasContatosService();
  //   this.contatos = await clientesContatos
  //       .getContaContatoByIdConta(this.idLocal, relacionamentos: [
  //     RelacionamentosContaContato.cargo,
  //     RelacionamentosContaContato.interesses
  //   ]);
  // }
}
