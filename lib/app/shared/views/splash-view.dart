import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rocha_contabilidade/app/admin/views/home-admin-view.dart';
import 'package:rocha_contabilidade/app/cliente/views/home-view.dart';
import 'package:rocha_contabilidade/app/shared/controllers/auth-controller.dart';

import 'login-view.dart';

class SplashView extends StatelessWidget {
  final bool isLoggedIn = true;
  final bool isCliente = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        if (isLoggedIn) {
          if (isCliente)
            return HomeView();
          else
            return HomeAdminView();
        } else
          return LoginView();
      },
    );
  }
}
