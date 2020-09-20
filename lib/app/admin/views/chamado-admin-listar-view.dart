import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rocha_contabilidade/app/cliente/controllers/chamado-controller.dart';
import 'package:rocha_contabilidade/app/cliente/domain/chamado.dart';
import 'package:rocha_contabilidade/app/utils/common.dart';
import 'package:rocha_contabilidade/app/utils/routes.dart';
import 'package:rocha_contabilidade/app/widgets/loader-widget.dart';
import 'package:rocha_contabilidade/app/widgets/text-widget.dart';

class ChamadoAdminListarView extends StatelessWidget {
  final ChamadoController chamadoController = Get.put(ChamadoController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return GetX<ChamadoController>(
          init: ChamadoController(),
          initState: (_) {
            chamadoController.listarTudo();
          },
          builder: (controller) {
            return Scaffold(
              appBar: renderAppBar(sizingInfo),
              body: Container(
                  child: ListView(
                children: [
                  Row(
                    children: [renderChamados(sizingInfo, controller.chamados.value)],
                  )
                ],
              )),
            );
          },
        );
      },
    );
  }

  renderAppBar(SizingInformation sizingInfo) {
    return AppBar(
      leading: renderNothing(),
      elevation: 0,
      title: TextWidget(text: 'Atendimentos em aberto'),
    );
  }

  renderChamados(SizingInformation sizingInfo, List<Chamado> chamados) {
    return Container(
      width: sizingInfo.isMobile ? Get.width : Get.width / 2,
      height: Get.height,
      child: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: chamadoController.carregando.value
                  ? LoaderWidget()
                  : chamados.length == 0
                      ? Center(child: TextWidget(text: 'Nenhum chamado aberto até o momento.'))
                      : ListView.builder(
                          itemCount: chamados.length,
                          itemBuilder: (context, index) {
                            var chamado = chamados[index];

                            return Card(
                              child: ListTile(
                                onTap: () => goTo('/chamado-admin-detalhe/${chamado.id}'),
                                title: TextWidget(text: 'Chamado #${chamado.id}', fontWeight: FontWeight.bold),
                                subtitle: TextWidget(text: chamado.titulo),
                                trailing: Chip(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)), label: TextWidget(text: 'Em análise')),
                              ),
                              elevation: 0,
                            );
                          }),
            ),
          )
        ],
      ),
    );
  }

  renderAberturaChamado() {
    return Expanded(
      child: Container(
        height: Get.height,
        child: ListView(
          children: [
            Image.asset(
              'assets/images/atendimento.png',
              scale: 1.5,
            ),
            Center(child: TextWidget(text: 'Precisa de ajuda? Abra um chamado abaixo')),
            Center(child: TextWidget(text: 'Estamos aqui para ajudar você.')),
            RaisedButton(
              elevation: 0,
              onPressed: () => goTo('chamado-abrir'),
              child: TextWidget(
                text: 'ABRIR CHAMADO',
              ),
            )
          ],
        ),
      ),
    );
  }
}
