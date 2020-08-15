import 'dart:convert';

import 'package:get/get.dart';
import 'package:rocha_contabilidade/app/cliente/controllers/chamado-controller.dart';
import 'package:rocha_contabilidade/app/cliente/domain/fila.dart';
import 'package:rocha_contabilidade/app/cliente/domain/interacao.dart';
import 'package:rocha_contabilidade/app/shared/controllers/auth-controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  var interacoes = List<Interacao>().obs;
  ChamadoController chamadoController = Get.find();

  IO.Socket socket = IO.io('https://chat-rocha-contabilidade.herokuapp.com/');

  iniciarSocket() {
    socket.on('connect', (data) {
      socket.on('event', (data) => print(data));
      socket.on('enviarMsg', (data) => receberMensagem(data));
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
      socket.on('usuariosNaFila', (data) {
        List<Fila> listaFila = [];
        for (var item in data as List) {
          Fila fila = Fila.fromJson(item);
          listaFila.add(fila);
        }

        print(listaFila.indexWhere((e) => e.usuarioId == AuthController.to.usuario.value.usuarioId));
      });
    });

    entrarNaFila();
  }

  enviarMensagem() {
    socket.emit('msg', chamadoController.interacao.value.toJson());
    chamadoController.interacao.value.mensagem = null;
  }

  entrarNaFila() {
    socket.emit('entrarFila', {
      'usuarioId': AuthController.to.usuario.value.usuarioId,
      'nome': AuthController.to.usuario.value.nome,
    });

    socket.emit('usuariosNaFila');
  }

  receberMensagem(data) {
    var decodedJson = json.decode(data);
    interacoes.add(Interacao.fromJson(decodedJson));
    print(interacoes.length);
  }

  desconectar() {
    socket.emit('desconectar', AuthController.to.usuario.value.toJson());
  }
}
