

import 'package:biribi_financas/models/conta.dart';
import 'package:biribi_financas/models/usuario.dart';

enum RelacionamentosGrupo { contas, usuarios }

class Grupo {
  int id;
  String nome;
  List<Conta> contas;
  List<Usuario> usuarios;

  Grupo({
    this.id,
    this.nome,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
    };
  }

  Grupo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
  }

  // Future<void> carregaRelacionamentos(
  //   List<RelacionamentosGrupo> relacionamentos,
  // ) async {
  //   for (RelacionamentosGrupo relacionamento in relacionamentos) {
  //     switch (relacionamento) {
  //       case RelacionamentosGrupo.segmento:
  //         await this.getSegmento();
  //         break;
  //       case RelacionamentosGrupo.subsegmento:
  //         await this.getSubSegmento();
  //         break;
  //       case RelacionamentosGrupo.enderecos:
  //         await this.getEndereco();
  //         break;
  //       case RelacionamentosGrupo.contatos:
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
  //   var clientesEnderecos = new GruposEnderecosService();
  //   this.enderecos = await clientesEnderecos
  //       .getGrupoEnderecoByIdGrupo(this.idLocal, relacionamentos: [
  //     RelacionamentosGrupoEndereco.cidade,
  //     RelacionamentosGrupoEndereco.estado,
  //     RelacionamentosGrupoEndereco.pais
  //   ]);
  // }

  // Future<void> getContato() async {
  //   var clientesContatos = new GruposContatosService();
  //   this.contatos = await clientesContatos
  //       .getGrupoContatoByIdGrupo(this.idLocal, relacionamentos: [
  //     RelacionamentosGrupoContato.cargo,
  //     RelacionamentosGrupoContato.interesses
  //   ]);
  // }
}
