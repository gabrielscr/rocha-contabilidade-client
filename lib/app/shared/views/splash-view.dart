import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rocha_contabilidade/app/shared/controllers/auth-controller.dart';
import 'package:rocha_contabilidade/app/widgets/text-widget.dart';

class SplashView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      initState: (_) {
        authController.verificarLogin();
      },
      builder: (controller) {
        return Scaffold(
          body: Container(
            child: Center(
              child: TextWidget(
                text: 'GLOBAL CONTABILIDADE',
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        );
      },
    );
  }
}
