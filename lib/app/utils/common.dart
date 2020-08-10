import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rocha_contabilidade/app/shared/controllers/auth-controller.dart';
import 'package:rocha_contabilidade/app/shared/controllers/theme-controller.dart';

exibirSnackErro(String erro) {
  Get.snackbar('Oops!', erro,
      isDismissible: true,
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 5,
      margin: EdgeInsets.all(15),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.black,
      duration: Duration(seconds: 10),
      colorText: Colors.white,
      animationDuration: Duration(seconds: 0));
}

exibirSnackSucesso(String mensagem) {
  Get.snackbar('Sucesso!', mensagem,
      isDismissible: true,
      icon: Icon(
        Icons.check,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 5,
      margin: EdgeInsets.all(15),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.black,
      duration: Duration(seconds: 10),
      colorText: Colors.white,
      animationDuration: Duration(seconds: 0));
}

bool get isModoDark => ThemeController.to.modoDark.value;

Map<String, String> get headers =>
    {'Authorization': 'Bearer ${AuthController.to.usuario.value.token}'};

String formatarMoeda(double numero) {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: "pt-BR");

  return formatCurrency.format(numero);
}

int exibirDias(DateTime data) {
  var dataInicio =
      '${data.day}/${data.month}/${data.year} ${data.hour}:${data.minute}';

  var splitDate = dataInicio.split(" ");
  var date = splitDate[0].split("/");

  var dateTime =
      DateTime(int.parse(date[2]), int.parse(date[1]), int.parse(date[0]));
  var hoje = DateTime.now();

  var diferenca = hoje.difference(dateTime);

  return diferenca.inDays;
}

String exibirHoras(DateTime data) {
  var dataInicio =
      '${data.day}/${data.month}/${data.year} ${data.hour}:${data.minute}';

  var splitDate = dataInicio.split(" ");

  var hora = splitDate[1];

  var horaSplit = hora.split(':');

  return "${horaSplit[0]}:${horaSplit[1]}";
}

exibirDataFormatada(int dias) {
  switch (dias) {
    case 0:
      return "hoje";
      break;
    case 1:
      return "ontem";
    case 2:
      return "anteontem";
    default:
      return "há $dias dias";
  }
}

renderNothing() {
  return Container(
    height: 0,
    width: 0,
  );
}
