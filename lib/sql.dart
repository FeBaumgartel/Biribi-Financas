abstract class Sql {
  static List<String> sqls = <String>[
    "PRAGMA foreign_keys = ON",
    "CREATE TABLE grupo (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR(150) NOT NULL)",
    "CREATE TABLE usuario ( id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR(150) NOT NULL, login VARCHAR(150) NOT NULL, senha VARCHAR(150) NOT NULL, id_grupo INTEGER NULL, FOREIGN KEY (id_grupo) REFERENCES grupo (id))",
    "CREATE TABLE conta ( id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR(150) NOT NULL, saldo DECIMAL(6,2) NOT NULL DEFAULT 0.0, publica BIT NOT NULL DEFAULT 0, id_usuario INTEGER UNSIGNED NOT NULL, id_grupo INTEGER UNSIGNED NULL, FOREIGN KEY (id_usuario) REFERENCES usuario (id), FOREIGN KEY (id_grupo) REFERENCES grupo (id))",
    "CREATE TABLE movimentacao (id INTEGER PRIMARY KEY AUTOINCREMENT, dataCriacao DATETIME NOT NULL, dataVencimento DATETIME NOT NULL, valor DECIMAL(6,2) NOT NULL, tipo BIT NOT NULL, id_conta INT UNSIGNED NOT NULL, id_usuario INT UNSIGNED NOT NULL, id_grupo INT UNSIGNED NULL, FOREIGN KEY (id_conta) REFERENCES conta (id), FOREIGN KEY (id_usuario) REFERENCES usuario (id), FOREIGN KEY (id_grupo) REFERENCES grupo (id))",
    "INSERT INTO grupo (nome) VALUES ('grupo1')",
    "INSERT INTO usuario (nome,login,senha,id_grupo) VALUES ('user1','login','senha',1)",
    "INSERT INTO conta (nome,saldo,publica,id_usuario,id_grupo) VALUES ('conta1',200.00,0,1,1)",
    "INSERT INTO conta (nome,saldo,publica,id_usuario,id_grupo) VALUES ('conta2',1234.00,0,1,1)",
    "INSERT INTO conta (nome,saldo,publica,id_usuario,id_grupo) VALUES ('conta3',4321.00,0,1,1)",
    "INSERT INTO conta (nome,saldo,publica,id_usuario,id_grupo) VALUES ('conta4',42.00,0,1,1)",
    "INSERT INTO movimentacao (dataCriacao,dataVencimento,valor,tipo,id_conta,id_usuario,id_grupo) VALUES ('2020-06-01','2020-01-01',100.00,1,1,1,1)",
    "INSERT INTO movimentacao (dataCriacao,dataVencimento,valor,tipo,id_conta,id_usuario,id_grupo) VALUES ('2020-01-01','2020-01-01',100.00,1,1,1,1)",
    "INSERT INTO movimentacao (dataCriacao,dataVencimento,valor,tipo,id_conta,id_usuario,id_grupo) VALUES ('2020-06-01','2020-01-01',100.00,0,1,1,1)",
    "INSERT INTO movimentacao (dataCriacao,dataVencimento,valor,tipo,id_conta,id_usuario,id_grupo) VALUES ('2020-01-01','2020-01-01',100.00,1,1,1,1)",
  ];
}
