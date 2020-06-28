import 'package:biribi_financas/services/grupos.dart';

import 'grupo.dart';

enum RelacionamentosUsuario { grupo }

class Usuario {
  int id;
  String nome;
  String login;
  String senha;
  Grupo grupo;
  int id_grupo;

  Usuario({
    this.id,
    this.nome,
    this.login,
    this.senha,
    this.id_grupo,
  });
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'login': login,
      'senha': senha,
      'id_grupo': id_grupo,
    };
  }


  Usuario.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    login = map['login'];
    senha = map['senha'];
    id_grupo = map['id_grupo'];
  }

  Future<void> carregaRelacionamentos(
    List<RelacionamentosUsuario> relacionamentos,
  ) async {
    for (RelacionamentosUsuario relacionamento in relacionamentos) {
      switch (relacionamento) {
        case RelacionamentosUsuario.grupo:
          await this.getGrupo();
          break;
        default:
          break;
      }
    }
  }

  Future<void> getGrupo() async {
    var grupos = new GruposService();
    this.grupo = await grupos.getGrupo(this.id_grupo, relacionamentos: [
      RelacionamentosGrupo.contas
    ]);
  }
}
