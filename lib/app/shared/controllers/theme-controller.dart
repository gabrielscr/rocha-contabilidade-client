import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.put(ThemeController());

  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;
  RxBool modoDark = false.obs;

  Future<void> changeTheme(ThemeMode themeMode) async {
    Get.changeThemeMode(themeMode);
    _themeMode = themeMode;
    update();
    // await storage.write('theme', themeMode.toString().split('.')[1]);
  }

  getThemeMode() async {
    ThemeMode themeMode;
    // String themeText = storage.read('theme') ?? 'system';
    try {
      themeMode =
          ThemeMode.values.firstWhere((e) => describeEnum(e) == 'theme');
    } catch (e) {
      themeMode = ThemeMode.system;
    }

    if (themeMode == ThemeMode.dark)
      modoDark.value = true;
    else
      modoDark.value = false;

    changeTheme(themeMode);
  }
}
