class Usuario {
  String usuarioId;
  String nome;
  String email;
  String fotoUrl;
  String dataNascimento;
  bool preenchido;
  String cpf;
  String celular;
  String ddd;
  String senha;
  String login;
  Endereco endereco;
  String token;

  Usuario(
      {this.usuarioId,
      this.nome,
      this.email,
      this.fotoUrl,
      this.dataNascimento,
      this.preenchido,
      this.cpf,
      this.celular,
      this.ddd,
      this.endereco,
      this.senha,
      this.login,
      this.token});

  Usuario.fromJson(Map<String, dynamic> json) {
    usuarioId = json['usuarioId'];
    nome = json['nome'];
    email = json['email'];
    fotoUrl = json['fotoUrl'];
    dataNascimento = json['dataNascimento'];
    preenchido = json['preenchido'];
    cpf = json['cpf'];
    celular = json['celular'];
    ddd = json['ddd'];
    login = json['login'];
    endereco = json['endereco'] != null
        ? new Endereco.fromJson(json['endereco'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usuarioId'] = this.usuarioId;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['fotoUrl'] = this.fotoUrl;
    data['dataNascimento'] = this.dataNascimento;
    data['preenchido'] = this.preenchido;
    data['cpf'] = this.cpf;
    data['celular'] = this.celular;
    data['ddd'] = this.ddd;
    data['senha'] = this.senha;
    data['login'] = this.login;
    if (this.endereco != null) {
      data['endereco'] = this.endereco.toJson();
    }
    return data;
  }
}

class Endereco {
  String cep;
  String cidade;
  String logradouro;
  String numero;
  String complemento;
  String bairro;
  String uf;

  Endereco(
      {this.cep,
      this.cidade,
      this.logradouro,
      this.numero,
      this.complemento,
      this.bairro,
      this.uf});

  Endereco.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    cidade = json['cidade'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cep'] = this.cep;
    data['cidade'] = this.cidade;
    data['logradouro'] = this.logradouro;
    data['numero'] = this.numero;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['uf'] = this.uf;
    return data;
  }
}
