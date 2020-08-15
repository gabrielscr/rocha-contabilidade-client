import 'package:rocha_contabilidade/app/cliente/domain/anexo.dart';
import 'package:rocha_contabilidade/app/shared/repository/api-repository.dart';
import 'package:rocha_contabilidade/app/utils/common.dart';

class UploadRepository {
  ApiRepository apiRepository = ApiRepository();

  Future<Anexo> upload(Map<String, dynamic> data) async {
    var response = await apiRepository.post('Arquivo/Upload', data);

    if (response.statusCode != 200) {
      exibirSnackErro('Ocorreu um erro ao enviar o anexo, tente novamente');
      return null;
    } else
      return Anexo.fromJson(response.data);
  }
}
