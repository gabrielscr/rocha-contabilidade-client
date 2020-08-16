import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: CircularProgressIndicator(
        strokeWidth: 1,
      )),
    );
  }
}
