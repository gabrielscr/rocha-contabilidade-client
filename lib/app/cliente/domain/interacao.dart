class Interacao {
  int chamadoId;
  String mensagem;
  List<String> anexos;

  Interacao({this.chamadoId, this.mensagem, this.anexos});

  Interacao.fromJson(Map<String, dynamic> json) {
    chamadoId = json['chamadoId'];
    mensagem = json['mensagem'];
    anexos = json['anexos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chamadoId'] = this.chamadoId;
    data['mensagem'] = this.mensagem;
    data['anexos'] = this.anexos;
    return data;
  }
}
