import 'package:rocha_contabilidade/app/cliente/domain/chamado.dart';
import 'package:rocha_contabilidade/app/shared/repository/api-repository.dart';
import 'package:rocha_contabilidade/app/utils/common.dart';
import 'package:rocha_contabilidade/app/utils/routes.dart';

class ChamadoRepository {
  ApiRepository apiRepository = ApiRepository();

  Future<Chamado> obter(Map<String, dynamic> params) async {
    var response = await apiRepository.get('Chamado/Obter', params);

    if (response.statusCode == 200) {
      return Chamado.fromJson(response.data);
    } else {
      exibirSnackErro('Ocorreu um problema ao obter o chamado');
      return null;
    }
  }

  Future<List<Chamado>> listar(Map<String, dynamic> params) async {
    var response = await apiRepository.get('Chamado/Listar', params);

    if (response.statusCode == 200) {
      List<Chamado> chamados = [];

      for (var item in (response.data) as List) {
        Chamado chamado = Chamado.fromJson(item);

        chamados.add(chamado);
      }

      return chamados;
    } else {
      exibirSnackErro('Ocorreu um problema ao listar os chamados');
      return null;
    }
  }

  registrarInteracao(Map<String, dynamic> data) async {
    var response = await apiRepository.post('Chamado/InserirInteracao', data);

    if (response.statusCode != 200) {
      exibirSnackErro('Ocorreu um erro ao enviar a mensagem, tente novamente.');
    }
  }

  inserir(Map<String, dynamic> data) async {
    var response = await apiRepository.post('Chamado/Inserir', data);

    if (response.statusCode == 200) {
      exibirSnackSucesso('Novo chamado criado');
      Future.delayed(Duration(seconds: 2),
          () => goTo('/chamado-detalhe/${response.data}'));
    } else {
      exibirSnackErro('Ocorreu um erro ao inserir o chamado, tente novamente.');
    }
  }
}
