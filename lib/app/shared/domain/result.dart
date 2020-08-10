class Resultado {
  String erro;
  bool sucesso;
  String mensagem;

  Resultado({this.erro, this.sucesso});

  Resultado.fromJson(Map<String, dynamic> json) {
    erro = json['erro'];
    sucesso = json['sucesso'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['erro'] = this.erro;
    data['sucesso'] = this.sucesso;
    data['mensagem'] = this.mensagem;
    return data;
  }
}
