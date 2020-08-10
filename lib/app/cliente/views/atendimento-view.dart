import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rocha_contabilidade/app/utils/common.dart';
import 'package:rocha_contabilidade/app/widgets/text-widget.dart';

class AtendimentoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return Scaffold(
          appBar: renderAppBar(sizingInfo),
          body: Container(
              child: ListView(
            children: [
              Row(
                children: [
                  renderChamados(sizingInfo),
                  sizingInfo.isMobile
                      ? renderNothing()
                      : renderAberturaChamado()
                ],
              )
            ],
          )),
        );
      },
    );
  }

  renderAppBar(SizingInformation sizingInfo) {
    return AppBar(
      backgroundColor: Colors.grey[200],
      elevation: 0,
      title: TextWidget(text: 'Abertura de chamados'),
      actions: [
        sizingInfo.isMobile
            ? FlatButton(
                onPressed: () {}, child: TextWidget(text: 'Abrir novo'))
            : renderNothing()
      ],
    );
  }

  renderChamados(SizingInformation sizingInfo) {
    return Container(
      width: sizingInfo.isMobile ? Get.width : Get.width / 2,
      height: Get.height,
      child: Column(
        children: [
          Container(
            child: Center(
              child: TextWidget(
                  text:
                      'Você pode consultar seus chamados em aberto e caso necessite, abrir novos.'),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    var count = 1;

                    var hoje = DateTime.now();
                    return Card(
                      child: ListTile(
                        title: TextWidget(text: 'Chamado #${count + index}'),
                        subtitle: TextWidget(
                            text:
                                'Aberto ${exibirDataFormatada(exibirDias(hoje))} às ${exibirHoras(hoje)}'),
                        trailing: Chip(
                            backgroundColor: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2)),
                            label: TextWidget(text: 'Em análise')),
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
            Image.asset('assets/images/atendimento.png'),
            Center(
                child: TextWidget(
                    text: 'Precisa de ajuda? Abra um chamado abaixo')),
            Center(child: TextWidget(text: 'Estamos aqui para ajudar você.')),
            RaisedButton(
              elevation: 0,
              onPressed: () => {},
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
