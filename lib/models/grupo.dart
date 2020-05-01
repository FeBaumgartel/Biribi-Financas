

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

   Future<void> carregaRelacionamentos(
    List<RelacionamentosGrupo> relacionamentos,
  ) async {
    for (RelacionamentosGrupo relacionamento in relacionamentos) {
      switch (relacionamento) {
        case RelacionamentosGrupo.contas:
          await this.getContas();
          break;
        case RelacionamentosGrupo.usuarios:
          await this.getUsuarios();
          break;
        default:
          break;
      }
    }
  }

  Future<void> getContas() async {
    var contas = new ContasService();
    this.contas = await contas.getConta(this.id);
  }

  Future<void> getUsuarios() async {
    var usuarios = new UsuariosService();
    this.usuarios = await usuarios.getGrupo(this.id);
  }
}
