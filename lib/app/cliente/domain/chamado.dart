class Chamado {
  int id;
  String titulo;
  String dataHora;
  String usuarioId;
  String ultimaInteracaoPor;
  List<Interacoes> interacoes;

  Chamado(
      {this.id,
      this.titulo,
      this.dataHora,
      this.usuarioId,
      this.ultimaInteracaoPor,
      this.interacoes});

  Chamado.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    dataHora = json['dataHora'];
    usuarioId = json['usuarioId'];
    ultimaInteracaoPor = json['ultimaInteracaoPor'];
    if (json['interacoes'] != null) {
      interacoes = new List<Interacoes>();
      json['interacoes'].forEach((v) {
        interacoes.add(new Interacoes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['dataHora'] = this.dataHora;
    data['usuarioId'] = this.usuarioId;
    data['ultimaInteracaoPor'] = this.ultimaInteracaoPor;
    if (this.interacoes != null) {
      data['interacoes'] = this.interacoes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Interacoes {
  int id;
  String usuarioId;
  String dataHora;
  String mensagem;
  List<String> anexos;
  String usuarioNome;

  Interacoes(
      {this.id,
      this.usuarioId,
      this.dataHora,
      this.mensagem,
      this.anexos,
      this.usuarioNome});

  Interacoes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usuarioId = json['usuarioId'];
    dataHora = json['dataHora'];
    mensagem = json['mensagem'];
    anexos = json['anexos'].cast<String>();
    usuarioNome = json['usuarioNome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['usuarioId'] = this.usuarioId;
    data['dataHora'] = this.dataHora;
    data['mensagem'] = this.mensagem;
    data['anexos'] = this.anexos;
    data['usuarioNome'] = this.usuarioNome;
    return data;
  }
}
