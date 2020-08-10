import 'package:flutter/material.dart';
import 'package:rocha_contabilidade/app/widgets/text-widget.dart';

class ChamadoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: TextWidget(text: 'CHAMADO'),
      ),
    );
  }
}
