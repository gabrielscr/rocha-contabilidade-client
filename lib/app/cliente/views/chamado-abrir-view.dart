import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rocha_contabilidade/app/cliente/controllers/chamado-controller.dart';
import 'package:rocha_contabilidade/app/utils/common.dart';
import 'package:rocha_contabilidade/app/widgets/text-widget.dart';

class ChamadoAbrirView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<ChamadoController>(
      builder: (controller) {
        return Scaffold(
          appBar: renderAppBar(),
          body: renderBody(controller),
        );
      },
    );
  }

  renderAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
          icon: Icon(
            Icons.close,
            color: isModoDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back()),
      title: TextWidget(text: 'Abrir novo chamado'),
    );
  }

  renderBody(ChamadoController controller) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: [
          renderTextFormField('Título', (v) => controller.novoChamado.update((value) => value.titulo = v), controller.novoChamado.value.titulo),
          renderTextFormField('Mensagem', (v) => controller.novoChamado.update((value) => value.mensagem = v), controller.novoChamado.value.mensagem),
          Container(
            child: RaisedButton(
                elevation: 0,
                child: TextWidget(text: 'Abrir chamado'),
                onPressed: () {
                  if (GetUtils.isNullOrBlank(controller.novoChamado.value.mensagem) || GetUtils.isNullOrBlank(controller.novoChamado.value.titulo))
                    exibirSnackErro('Preencha todos os campos em destaque');
                  else
                    controller.inserir();
                }),
          )
        ],
      ),
    );
  }

  renderTextFormField(String label, Function onChanged, String value) {
    return TextFormField(
      onChanged: onChanged,
      decoration:
          InputDecoration(labelStyle: GoogleFonts.muli(), labelText: label, errorText: GetUtils.isNullOrBlank(value) ? "Preencha este campo" : null),
    );
  }
}
