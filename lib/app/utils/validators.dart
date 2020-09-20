import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:get/get.dart';
import 'package:rocha_contabilidade/app/shared/controllers/auth-controller.dart';

class Validators {
  final AuthController authController = Get.put(AuthController());

  String validarEmail() {
    var email = authController.usuario.value.email;

    if (GetUtils.isNullOrBlank(email)) return "Preencha o seu e-mail";

    if (!GetUtils.isEmail(email)) return "E-mail inválido";

    return null;
  }

  String validarLogin() {
    var login = authController.usuario.value.login;

    if (GetUtils.isNullOrBlank(login)) return "Preencha o login";

    return null;
  }

  String validarSenha() {
    var senha = authController.usuario.value.senha;

    if (GetUtils.isNullOrBlank(senha)) return "Preencha a sua senha";

    return null;
  }

  String validarForcaSenha() {
    var senha = authController.usuario.value.senha;

    if (GetUtils.isNullOrBlank(senha)) return "Preencha sua senha";

    Pattern pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})";

    var regex = RegExp(pattern);

    if (senha.length < 8)
      return "Sua senha precisa ser maior ou igual a 8 caracteres";

    if (senha.length > 0 && !regex.hasMatch(senha))
      return "Sua senha é muito fraca";

    return null;
  }

  String validarNome() {
    var nome = authController.usuario.value.nome;
    if (GetUtils.isNullOrBlank(nome))
      return 'Preencha o seu nome';
    else
      return null;
  }

  String validarCpf() {
    var cpf = authController.usuario.value.cpf;
    if (!CPF.isValid(cpf))
      return 'Preencha o campo com um CPF válido';
    else
      return null;
  }

  String validarCep() {
    var cep = authController.usuario.value.endereco.cep;
    if (GetUtils.isNullOrBlank(cep)) return 'Preencha o seu cep';
    if (cep.length != 8)
      return 'Seu cep é inválido';
    else
      return null;
  }

  String validarNumero() {
    var numero = authController.usuario.value.endereco.numero;
    if (GetUtils.isNullOrBlank(numero))
      return 'Preencha o número da sua casa/apto/trabalho';
    else
      return null;
  }

  String validarComplemento() {
    var complemento = authController.usuario.value.endereco.complemento;
    if (GetUtils.isNullOrBlank(complemento))
      return 'Preencha o seu complemento, caso não tenha, coloque N/A';
    else
      return null;
  }
}
