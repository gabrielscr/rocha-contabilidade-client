import 'package:get/get.dart';
import 'package:rocha_contabilidade/app/cliente/domain/anexo.dart';
import 'package:rocha_contabilidade/app/cliente/domain/arquivo.dart';
import 'package:rocha_contabilidade/app/cliente/domain/chamado.dart';
import 'package:rocha_contabilidade/app/cliente/domain/interacao.dart';
import 'package:rocha_contabilidade/app/cliente/domain/novo-chamado.dart';
import 'package:rocha_contabilidade/app/cliente/repository/chamado-repository.dart';
import 'package:rocha_contabilidade/app/cliente/repository/upload-repository.dart';

class ChamadoController extends GetxController {
  ChamadoRepository repository = ChamadoRepository();

  UploadRepository uploadRepository = UploadRepository();

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

  registrarInteracao() async {
    changeCarregandoInteracao(true);
    interacao.value.chamadoId = chamado.value.id;
    await repository.registrarInteracao(interacao.value.toJson());
    obter(chamado.value.id);
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
