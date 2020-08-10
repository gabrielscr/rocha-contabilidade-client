import 'package:get/get.dart';
import 'package:rocha_contabilidade/app/shared/domain/auth-result.dart';
import 'package:rocha_contabilidade/app/shared/domain/usuario.dart';
import 'package:rocha_contabilidade/app/shared/repository/auth-repository.dart';
import 'package:rocha_contabilidade/app/utils/common.dart';
import 'package:rocha_contabilidade/app/utils/routes.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  AuthResult authResult = AuthResult();
  AuthRepository authRepository = AuthRepository();
  Rx<Usuario> usuario = Usuario().obs;

  login() async {
    authResult = await authRepository
        .login({'Email': usuario.value.email, 'Senha': usuario.value.senha});

    if (authResult.authenticated) {
      goTo('/home');
    } else {
      exibirSnackErro('Usuário ou senha inválidos');
    }
  }

  logoff() async {
    goToAll('/');
  }
}
