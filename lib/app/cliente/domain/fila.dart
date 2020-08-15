class Fila {
  String usuarioId;
  String nome;

  Fila({this.usuarioId, this.nome});

  Fila.fromJson(Map<String, dynamic> json) {
    usuarioId = json['usuarioId'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usuarioId'] = this.usuarioId;
    data['nome'] = this.nome;
    return data;
  }
}
