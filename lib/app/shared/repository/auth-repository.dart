import 'package:dio/dio.dart';
import 'package:rocha_contabilidade/app/shared/domain/auth-result.dart';
import 'package:rocha_contabilidade/app/shared/domain/result.dart';
import 'package:rocha_contabilidade/app/utils/constants.dart';

class AuthRepository {
  Future<AuthResult> login(params) async {
    try {
      var response = await Dio().post(Constants.apiUrl, data: params);

      AuthResult auth = AuthResult.fromJson(response.data);

      return auth;
    } on DioError catch (e) {
      print(e.response.data);
      return null;
    }
  }

  Future<Resultado> cadastrar(params) async {
    var response = await Dio().post(Constants.apiUrl, data: params);

    Resultado resultado = Resultado.fromJson(response.data);

    return resultado;
  }
}
