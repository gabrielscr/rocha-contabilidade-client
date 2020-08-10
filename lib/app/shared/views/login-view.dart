import 'package:flutter/material.dart';
import 'package:rocha_contabilidade/app/widgets/text-widget.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            children: [TextWidget(text: 'Login')],
          ),
        ),
      ),
    );
  }
}
