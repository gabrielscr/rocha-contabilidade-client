class NovoChamado {
  String mensagem;
  String titulo;
  String anexoBase64;
  String anexoNome;

  NovoChamado({this.mensagem, this.titulo, this.anexoBase64, this.anexoNome});

  NovoChamado.fromJson(Map<String, dynamic> json) {
    mensagem = json['mensagem'];
    titulo = json['titulo'];
    anexoBase64 = json['anexoBase64'];
    anexoNome = json['anexoNome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mensagem'] = this.mensagem;
    data['titulo'] = this.titulo;
    data['anexoBase64'] = this.anexoBase64;
    data['anexoNome'] = this.anexoNome;
    return data;
  }
}
