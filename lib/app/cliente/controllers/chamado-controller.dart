import 'package:get/get.dart';
import 'package:rocha_contabilidade/app/cliente/domain/chamado.dart';
import 'package:rocha_contabilidade/app/cliente/domain/interacao.dart';
import 'package:rocha_contabilidade/app/cliente/domain/novo-chamado.dart';
import 'package:rocha_contabilidade/app/cliente/repository/chamado-repository.dart';

class ChamadoController extends GetxController {
  ChamadoRepository repository = ChamadoRepository();

  Rx<Chamado> chamado = Chamado().obs;

  RxList<Chamado> chamados = List<Chamado>().obs;

  RxBool carregando = false.obs;

  Rx<Interacao> interacao = Interacao().obs;

  Rx<NovoChamado> novoChamado = NovoChamado().obs;

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

  registrarInteracao() async {
    interacao.value.chamadoId = chamado.value.id;
    await repository.registrarInteracao(interacao.value.toJson());
    obter(chamado.value.id);
    limparInteracao();
  }

  limparInteracao() {
    interacao.value.mensagem = null;
    interacao.value.anexos = [];
  }

  inserir() async {
    changeCarregando(true);

    await repository.inserir(novoChamado.value.toJson());
    
    changeCarregando(false);
  }
}
