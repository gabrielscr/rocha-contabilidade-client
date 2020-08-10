import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatefulWidget {
  final label;
  final Function onChanged;
  final bool isObscure;
  final Icon icon;
  final TextInputType inputType;
  final String Function() errorText;

  const TextFormFieldWidget(
      {Key key,
      @required this.label,
      @required this.onChanged,
      @required this.isObscure,
      @required this.icon,
      @required this.inputType,
      @required this.errorText})
      : super(key: key);

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[100]))),
          child: TextFormField(
            onChanged: widget.onChanged,
            obscureText: widget.isObscure,
            keyboardType: widget.inputType,
            style: GoogleFonts.muli(color: Colors.black),
            decoration: InputDecoration(
                errorText: widget.errorText == null ? null : widget.errorText(),
                errorStyle: GoogleFonts.muli(),
                prefixIcon: widget.icon,
                border: InputBorder.none,
                hintText: widget.label,
                hintStyle: TextStyle(color: Colors.grey[400])),
          ),
        ));
  }
}
