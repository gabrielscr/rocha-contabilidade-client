class Interacao {
  int chamadoId;
  String mensagem;
  String anexoBase64;
  String anexoNome;

  Interacao({this.chamadoId, this.mensagem, this.anexoBase64, this.anexoNome});

  Interacao.fromJson(Map<String, dynamic> json) {
    chamadoId = json['chamadoId'];
    mensagem = json['mensagem'];
    anexoBase64 = json['anexoBase64'];
    anexoNome = json['anexoNome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chamadoId'] = this.chamadoId;
    data['mensagem'] = this.mensagem;
    data['anexoBase64'] = this.anexoBase64;
    data['anexoNome'] = this.anexoNome;
    return data;
  }
}
