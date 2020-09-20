import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rocha_contabilidade/app/cliente/controllers/chamado-controller.dart';
import 'package:rocha_contabilidade/app/cliente/domain/chamado.dart';
import 'package:rocha_contabilidade/app/utils/common.dart';
import 'package:rocha_contabilidade/app/utils/routes.dart';
import 'package:rocha_contabilidade/app/widgets/loader-widget.dart';
import 'package:rocha_contabilidade/app/widgets/text-widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ChamadoAdminDetalheView extends StatefulWidget {
  @override
  _ChamadoDetalheViewState createState() => _ChamadoDetalheViewState();
}

class _ChamadoDetalheViewState extends State<ChamadoAdminDetalheView> {
  String get id => Get.parameters["id"];

  final ChamadoController chamadoController = Get.put(ChamadoController());

  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return GetX<ChamadoController>(initState: (_) async {
      scrollController = ScrollController(initialScrollOffset: 0);
      chamadoController.obter(int.parse(id));
    }, builder: (controller) {
      return Scaffold(
          appBar: renderAppBar(),
          body: Visibility(visible: !controller.carregando.value, replacement: LoaderWidget(), child: renderBody(controller.chamado.value)));
    });
  }

  scrollToBottom() {
    print('scroll');
    Timer(Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 100), curve: Curves.decelerate);
      }
    });
  }

  renderAppBar() {
    return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.close,
            color: isModoDark ? Colors.white : Colors.black,
          ),
          onPressed: () {
            goTo('home-admin');
          }),
      title: TextWidget(
        text: 'Detalhe do chamado',
      ),
      elevation: 0,
    );
  }

  renderBody(Chamado chamado) {
    return GetBuilder<ChamadoController>(
      builder: (controller) {
        return ResponsiveBuilder(builder: (context, sizingInfo) {
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
                          child: Obx(() => Visibility(
                              visible: !controller.carregandoInteracao.value,
                              replacement: LoaderWidget(),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    padding: EdgeInsets.only(left: 10, bottom: 5),
                                    child: TextFormField(
                                      onChanged: (msg) => controller.interacao.update((value) => value.mensagem = msg),
                                      decoration: InputDecoration(hintStyle: GoogleFonts.muli(), hintText: 'Digite uma mensagem...'),
                                    ),
                                  )),
                                  IconButton(
                                      icon: Icon(Icons.attach_file, color: isModoDark ? Colors.white : Colors.black),
                                      onPressed: kIsWeb ? _selectFile : _selectFileMobile),
                                  IconButton(
                                      icon: Icon(
                                        Icons.send,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        if (GetUtils.isNullOrBlank(chamadoController.interacao.value.mensagem))
                                          exibirSnackErro('Preencha sua mensagem antes de enviar');
                                        else {
                                          chamadoController.registrarInteracao();
                                          scrollToBottom();
                                        }
                                      }),
                                ],
                              ))))
                    ],
                  ),
                ),
              ),
              GetPlatform.isAndroid || GetPlatform.isIOS || sizingInfo.isMobile || sizingInfo.isTablet ? renderNothing() : renderContainer(chamado)
            ],
          ));
        });
      },
    );
  }

  renderAnexo(String anexo) {
    if (anexo.contains('.pdf'))
      return Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () => launch(anexo),
          child: Image.asset(
            'assets/images/pdf.png',
            width: 300,
            height: 300,
          ),
        ),
      );

    if (anexo.contains('.xlsx') || anexo.contains('.xls'))
      return Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => launch(anexo),
            child: Image.asset(
              'assets/images/excel.png',
              width: 300,
              height: 300,
            ),
          ));

    if (anexo.contains('.docx'))
      return Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => launch(anexo),
            child: Image.asset(
              'assets/images/word.png',
              width: 300,
              height: 300,
            ),
          ));
    if (anexo.contains('.jpg') || anexo.contains('.png') || anexo.contains('.webp') || anexo.contains('.jpeg') || anexo.contains('.gif'))
      return Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => launch(anexo),
            child: Image.network(
              anexo,
              width: 300,
              height: 300,
            ),
          ));
    else
      return Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => launch(anexo),
            child: Image.asset(
              'assets/images/file.png',
              width: 300,
              height: 300,
            ),
          ));
  }

  renderInteracoes(Chamado chamado) {
    scrollToBottom();
    return Expanded(
        child: ListView.builder(
            controller: scrollController,
            itemCount: chamado.interacoes.length,
            itemBuilder: (context, index) {
              var interacao = chamado.interacoes[index];

              return Card(
                elevation: 0,
                color: obterCorCard(interacao.usuarioId),
                child: ListTile(
                  title: TextWidget(text: interacao.usuarioNome),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(text: GetUtils.isNullOrBlank(interacao.mensagem) ? interacao.anexoNome : interacao.mensagem),
                      GetUtils.isNullOrBlank(interacao.anexoCaminho) ? renderNothing() : renderAnexo(interacao.anexoCaminho)
                    ],
                  ),
                  trailing: TextWidget(text: interacao.dataHora),
                ),
              );
            }));
  }

  renderContainer(Chamado chamado) {
    return Container(
      width: 400,
      child: ListView(
        children: [
          SizedBox(height: 20),
          TextWidget(
            text: 'Informações do atendimento #${chamado.id}',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          Divider(),
          TextWidget(text: "${chamado.titulo}"),
          TextWidget(text: "Última interação por ${chamado.ultimaInteracaoPor}"),
          TextWidget(text: "Data de abertura ${chamado.dataHora}"),
        ],
      ),
    );
  }

  _selectFileMobile() async {
    File file = await FilePicker.getFile();

    await chamadoController.registrarInteracao(file: file);
  }

  _selectFile() async {
    var picker = await FilePickerCross.pick();

    if (picker != null) {
      await chamadoController.registrarInteracao(cross: picker);
      scrollToBottom();
    }
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
