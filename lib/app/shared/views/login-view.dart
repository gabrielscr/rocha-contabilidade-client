import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rocha_contabilidade/app/shared/controllers/auth-controller.dart';
import 'package:rocha_contabilidade/app/utils/common.dart';
import 'package:rocha_contabilidade/app/utils/validators.dart';
import 'package:rocha_contabilidade/app/widgets/text-widget.dart';
import 'package:rocha_contabilidade/app/widgets/textformfield-widget.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return ResponsiveBuilder(
            builder: (context, sizingInfo) {
              return Scaffold(
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: TextWidget(
                          text: 'GLOBAL CONTABILIDADE',
                          fontSize: sizingInfo.isDesktop ? 40 : 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                            boxShadow: [BoxShadow(color: Color.fromRGBO(143, 148, 251, .2), blurRadius: 20.0, offset: Offset(0, 10))]),
                        width: sizingInfo.isDesktop ? 500 : 300,
                        height: 280,
                        child: Column(
                          children: [
                            TextFormFieldWidget(
                                label: 'E-mail',
                                onChanged: (v) => controller.usuario.update((value) => value.email = v),
                                isObscure: false,
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                inputType: TextInputType.emailAddress,
                                errorText: Validators().validarEmail),
                            TextFormFieldWidget(
                                label: 'Senha',
                                onChanged: (v) => controller.usuario.update((value) => value.senha = v),
                                isObscure: true,
                                icon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.black,
                                ),
                                inputType: TextInputType.text,
                                errorText: Validators().validarSenha),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: Get.width - 30,
                              height: 40,
                              child: RaisedButton(
                                  color: Colors.grey[300],
                                  elevation: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                        child: Obx(
                                      () => controller.carregando.value
                                          ? Center(
                                              child: CircularProgressIndicator(),
                                            )
                                          : TextWidget(
                                              text: "LOGAR",
                                              color: Colors.black,
                                            ),
                                    )),
                                  ),
                                  onPressed: () {
                                    if (controller.isValidLogin)
                                      controller.login();
                                    else
                                      exibirSnackErro('Preencha todos os campos para continuar');
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
