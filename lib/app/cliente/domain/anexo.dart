class Anexo {
  List<String> anexos;

  Anexo({this.anexos});

  Anexo.fromJson(Map<String, dynamic> json) {
    anexos = json['anexos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anexos'] = this.anexos;
    return data;
  }
}
