import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rocha_contabilidade/app/admin/views/home-admin-view.dart';
import 'package:rocha_contabilidade/app/cliente/views/chamado-abrir-view.dart';
import 'package:rocha_contabilidade/app/cliente/views/chamado-detalhe-view.dart';
import 'package:rocha_contabilidade/app/shared/views/login-view.dart';

import 'app/shared/controllers/theme-controller.dart';
import 'app/shared/views/splash-view.dart';

void main() {
  Get.lazyPut<ThemeController>(() => ThemeController());
  ThemeController.to.getThemeMode();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rocha Contabilidade',
      initialRoute: '/',
      theme: ThemeData.light().copyWith(primaryColor: Colors.grey[200]),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.black),
      themeMode: ThemeController.to.themeMode,
      getPages: [
        GetPage(name: '/', page: () => SplashView()),
        GetPage(name: 'login', page: () => LoginView()),
        GetPage(name: 'home-admin', page: () => HomeAdminView()),
        GetPage(name: 'chamado-detalhe/:id', page: () => ChamadoDetalheView()),
        GetPage(name: 'chamado-abrir', page: () => ChamadoAbrirView()),
      ],
    );
  }
}
