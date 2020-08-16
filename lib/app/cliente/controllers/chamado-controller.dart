import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:get/get.dart';
import 'package:rocha_contabilidade/app/cliente/domain/anexo.dart';
import 'package:rocha_contabilidade/app/cliente/domain/arquivo.dart';
import 'package:rocha_contabilidade/app/cliente/domain/chamado.dart';
import 'package:rocha_contabilidade/app/cliente/domain/interacao.dart';
import 'package:rocha_contabilidade/app/cliente/domain/novo-chamado.dart';
import 'package:rocha_contabilidade/app/cliente/repository/chamado-repository.dart';

class ChamadoController extends GetxController {
  ChamadoRepository repository = ChamadoRepository();

  Rx<Chamado> chamado = Chamado().obs;

  RxList<Chamado> chamados = List<Chamado>().obs;

  RxBool carregando = false.obs;

  RxBool carregandoInteracao = false.obs;

  Rx<Interacao> interacao = Interacao().obs;

  Rx<NovoChamado> novoChamado = NovoChamado().obs;

  Rx<ArquivoModel> arquivo = ArquivoModel().obs;

  Rx<Anexo> anexo = Anexo().obs;

  obter(int id) async {
    changeCarregando(true);

    chamado.value = await repository.obter({'Id': id});

    changeCarregando(false);
  }

  listar() async {
    changeCarregando(true);

    chamados.value = await repository.listar({});

    changeCarregando(false);
  }

  changeCarregando(bool value) {
    carregando.value = value;
  }

  changeCarregandoInteracao(bool value) {
    carregandoInteracao.value = value;
  }

  registrarInteracao({File file, FilePickerCross cross}) async {
    changeCarregandoInteracao(true);

    interacao.value.chamadoId = chamado.value.id;

    var formData = FormData();

    if (file != null) {
      var bytes = await file.readAsBytes();

      var fileName =
          MultipartFile.fromBytes(bytes, filename: file.path.replaceAll('/data/user/0/com.example.rocha_contabilidade/cache/file_picker/', ''));

      formData.files.addAll([
        MapEntry(
          "anexo",
          fileName,
        )
      ]);
    }

    if (cross != null) {
      var fileName = MultipartFile.fromBytes(cross.toUint8List(), filename: cross.path.replaceAll('C:/fakepath/', ''));
      formData.files.addAll([
        MapEntry(
          "anexo",
          fileName,
        )
      ]);
    }

    if (cross == null && file == null) {
      formData.fields.add(MapEntry('mensagem', interacao.value.mensagem));
    }

    formData.fields.add(MapEntry('chamadoId', chamado.value.id.toString()));

    await repository.registrarInteracao(formData);

    chamado.value = await repository.obter({'Id': chamado.value.id});

    limparInteracao();

    changeCarregandoInteracao(false);
  }

  limparInteracao() {
    interacao.value.anexoNome = null;
    interacao.value.anexoBase64 = null;
    interacao.value.mensagem = null;
  }

  inserir() async {
    changeCarregando(true);

    await repository.inserir(novoChamado.value.toJson());

    changeCarregando(false);
  }
}
