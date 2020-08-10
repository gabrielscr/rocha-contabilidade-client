import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rocha_contabilidade/app/cliente/controllers/chamado-controller.dart';
import 'package:rocha_contabilidade/app/cliente/domain/chamado.dart';
import 'package:rocha_contabilidade/app/utils/common.dart';
import 'package:rocha_contabilidade/app/utils/routes.dart';
import 'package:rocha_contabilidade/app/widgets/text-widget.dart';

class ChamadoDetalheView extends StatelessWidget {
  String get id => Get.parameters["id"];

  final ChamadoController chamadoController = Get.put(ChamadoController());

  @override
  Widget build(BuildContext context) {
    return GetX<ChamadoController>(initState: (_) {
      chamadoController.obter(int.parse(id));
    }, builder: (controller) {
      return Scaffold(
          appBar: renderAppBar(),
          body: controller.carregando.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : renderBody(controller.chamado.value));
    });
  }

  renderAppBar() {
    return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.close,
            color: isModoDark ? Colors.white : Colors.black,
          ),
          onPressed: () => goTo('home-admin')),
      title: TextWidget(
        text: 'Detalhe do chamado',
      ),
      elevation: 0,
    );
  }

  renderBody(Chamado chamado) {
    return Container(
        child: Row(
      children: [
        Expanded(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 20),
                TextWidget(
                  text: 'Interações',
                  fontSize: 18,
                ),
                SizedBox(height: 10),
                renderInteracoes(chamado),
                Card(
                  elevation: 0,
                  child: ListTile(
                    title: TextFormField(
                      onChanged: (msg) => chamadoController.interacao
                          .update((value) => value.mensagem = msg),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.muli(),
                          hintText: 'Digite uma mensagem...'),
                    ),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          if (GetUtils.isNullOrBlank(
                              chamadoController.interacao.value.mensagem))
                            exibirSnackErro(
                                'Preencha sua mensagem antes de enviar');
                          else
                            chamadoController.registrarInteracao();
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
        renderContainer(chamado)
      ],
    ));
  }

  renderInteracoes(Chamado chamado) {
    return Expanded(
        child: ListView.builder(
            itemCount: chamado.interacoes.length,
            itemBuilder: (context, index) {
              var interacao = chamado.interacoes[index];

              return Card(
                elevation: 0,
                color: obterCorCard(interacao.usuarioId),
                child: ListTile(
                  title: TextWidget(text: interacao.usuarioNome),
                  subtitle: TextWidget(text: interacao.mensagem),
                  trailing: TextWidget(text: interacao.dataHora),
                ),
              );
            }));
  }

  renderContainer(Chamado chamado) {
    return Container(
      width: 500,
      child: Column(
        children: [
          SizedBox(height: 20),
          TextWidget(
            text: 'Informações do atendimento #${chamado.id}',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          Divider(),
          TextWidget(text: "${chamado.titulo}"),
          TextWidget(
              text: "Última interação por ${chamado.ultimaInteracaoPor}"),
          TextWidget(text: "Data de abertura ${chamado.dataHora}"),
        ],
      ),
    );
  }

  obterCorCard(String usuarioId) {
    if (isModoDark && !isFromMe(usuarioId)) return Colors.grey[800];

    if (isFromMe(usuarioId) && isModoDark) return Colors.grey[600];

    if (isFromMe(usuarioId) && !isModoDark)
      return Colors.grey[300];
    else
      return Colors.grey[200];
  }
}
