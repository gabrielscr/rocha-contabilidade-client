class ArquivoModel {
  List<Arquivo> arquivos = [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.arquivos != null) {
      data['arquivos'] = this.arquivos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Arquivo {
  String nomeArquivo;
  String base64;

  Arquivo({this.nomeArquivo, this.base64});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomeArquivo'] = this.nomeArquivo;
    data['base64'] = this.base64;
    return data;
  }
}
