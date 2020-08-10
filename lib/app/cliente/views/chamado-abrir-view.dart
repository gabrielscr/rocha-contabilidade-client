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
      title: TextWidget(text: 'Abrir novo chamado'),
    );
  }

  renderBody(ChamadoController controller) {
    return Container(
      child: ListView(
        children: [
          renderTextFormField(
              'Título',
              (v) => controller.novoChamado.update((value) => value.titulo = v),
              controller.novoChamado.value.titulo),
          renderTextFormField(
              'Mensagem',
              (v) =>
                  controller.novoChamado.update((value) => value.mensagem = v),
              controller.novoChamado.value.mensagem),
          Container(
            child: RaisedButton(
                child: TextWidget(text: 'Abrir chamado'),
                onPressed: () {
                  if (GetUtils.isNullOrBlank(
                          controller.novoChamado.value.mensagem) ||
                      GetUtils.isNullOrBlank(
                          controller.novoChamado.value.titulo))
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
      decoration: InputDecoration(
          labelStyle: GoogleFonts.muli(),
          labelText: label,
          errorText:
              GetUtils.isNullOrBlank(value) ? "Preencha este campo" : null),
    );
  }
}
