import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rocha_contabilidade/app/cliente/controllers/chamado-controller.dart';
import 'package:rocha_contabilidade/app/cliente/controllers/chat-controller.dart';
import 'package:rocha_contabilidade/app/cliente/domain/chamado.dart';
import 'package:rocha_contabilidade/app/utils/common.dart';
import 'package:rocha_contabilidade/app/utils/routes.dart';
import 'package:rocha_contabilidade/app/widgets/text-widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ChamadoDetalheView extends StatefulWidget {
  @override
  _ChamadoDetalheViewState createState() => _ChamadoDetalheViewState();
}

class _ChamadoDetalheViewState extends State<ChamadoDetalheView> {
  String get id => Get.parameters["id"];

  final ChamadoController chamadoController = Get.put(ChamadoController());

  final ChatController chatController = Get.put(ChatController());

  final ScrollController scrollController = ScrollController();

  final TextEditingController msgController = TextEditingController();

  String _fileString;

  int _fileLength = 0;

  String _filePath;

  @override
  Widget build(BuildContext context) {
    return GetX<ChamadoController>(initState: (_) async {
      chamadoController.obter(int.parse(id));
      chatController.iniciarSocket();
    }, builder: (controller) {
      return Scaffold(
          appBar: renderAppBar(),
          body: Visibility(
              visible: !controller.carregando.value,
              replacement: Center(child: CircularProgressIndicator()),
              child: renderBody(controller.chamado.value)));
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
            chatController.desconectar();
            goTo('home-admin');
          }),
      title: TextWidget(
        text: 'Detalhe do chamado',
      ),
      elevation: 0,
    );
  }

  renderBody(Chamado chamado) {
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
                      child: chamadoController.carregandoInteracao.value
                          ? Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            )
                          : Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  onChanged: (msg) => chamadoController.interacao.update((value) => value.mensagem = msg),
                                  decoration: InputDecoration(hintStyle: GoogleFonts.muli(), hintText: 'Digite uma mensagem...'),
                                )),
                                IconButton(icon: Icon(Icons.attach_file, color: Colors.black), onPressed: kIsWeb ? _selectFile : _selectFileMobile),
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
                                      }
                                    }),
                              ],
                            ))
                ],
              ),
            ),
          ),
          renderContainer(chamado)
        ],
      ));
    });
  }

  _selectFile() async {
    var picker = await FilePickerCross.pick();

    if (picker != null) {
      var fileName = picker.path.replaceAll('C:/fakepath/', '');

      chamadoController.interacao.value.anexoBase64 = picker.toBase64();
      chamadoController.interacao.value.anexoNome = fileName;

      await chamadoController.registrarInteracao();
      chatController.enviarMensagem();
    }
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
    if (anexo.contains('.jpg') || anexo.contains('.png') || anexo.contains('.webp') || anexo.contains('.jpeg'))
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
                  title: TextWidget(text: chamado.id.toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(text: interacao.mensagem),
                      GetUtils.isNullOrBlank(interacao.anexoCaminho) ? renderNothing() : renderAnexo(interacao.anexoCaminho)
                    ],
                  ),
                  trailing: TextWidget(text: interacao.dataHora),
                ),
              );
            }));
  }

  renderContainer(Chamado chamado) {
    return Expanded(
      child: Container(
        width: 500,
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
            RaisedButton(
              onPressed: kIsWeb ? _selectFile : _selectFileMobile,
              child: Text('Select File'),
            ),
            Text('File path: $_filePath (Might cause issues on web)\n'),
            Text('File length: $_fileLength\n'),
            Text('File as String: $_fileString\n'),
          ],
        ),
      ),
    );
  }

  _selectFileMobile() async {
    File file = await FilePicker.getFile();

    var bytes = await file.readAsBytes();
    var base64file = base64.encode(bytes);

    chamadoController.interacao.value.anexoBase64 = base64file;
    var fileName = file.path.replaceAll("/data/user/0/com.example.rocha_contabilidade/cache/file_picker/", "");
    chamadoController.interacao.value.anexoNome = fileName;

    await chamadoController.registrarInteracao();
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
