import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.put(ThemeController());
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;
  RxBool modoDark = false.obs;

  Future<void> changeTheme(ThemeMode themeMode) async {
    final SharedPreferences prefs = await sharedPreferences;
    if (themeMode == ThemeMode.system) themeMode = ThemeMode.light;

    Get.changeThemeMode(themeMode);
    _themeMode = themeMode;
    update();
    await prefs.setString('theme', themeMode.toString().split('.')[1]);
  }

  getThemeMode() async {
    final SharedPreferences prefs = await sharedPreferences;
    ThemeMode themeMode;
    String themeText = prefs.getString('theme') ?? 'system';
    try {
      themeMode =
          ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      themeMode = ThemeMode.light;
    }

    if (themeMode == ThemeMode.dark)
      modoDark.value = true;
    else
      modoDark.value = false;

    changeTheme(themeMode);
  }
}
