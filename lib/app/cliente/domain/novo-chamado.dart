class NovoChamado {
  String mensagem;
  String titulo;
  List<String> anexos;

  NovoChamado({this.mensagem, this.titulo, this.anexos});

  NovoChamado.fromJson(Map<String, dynamic> json) {
    mensagem = json['mensagem'];
    titulo = json['titulo'];
    anexos = json['anexos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mensagem'] = this.mensagem;
    data['titulo'] = this.titulo;
    data['anexos'] = this.anexos;
    return data;
  }
}
