import 'grupo.dart';

enum RelacionamentosUsuario { asdf }

class Usuario {
  int id;
  String nome;
  String login;
  String senha;
  Grupo grupo;
  int idGrupo;

  Usuario({
    this.id,
    this.nome,
    this.login,
    this.senha,
    this.idGrupo,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'login': login,
      'senha': senha,
      'id_grupo': idGrupo,
    };
  }

  Usuario.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    login = map['login'];
    senha = map['senha'];
    idGrupo = map['id_grupo'];
  }
}
