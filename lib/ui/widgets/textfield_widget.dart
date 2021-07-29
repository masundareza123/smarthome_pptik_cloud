import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String title;
  final bool readOnly;
  final TextEditingController controller;
  const TextFieldWidget({key, @required this.title, @required this.controller, @required this.readOnly}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        child: TextField(
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
              labelText: '$title',
              // contentPadding: ,
              focusColor: Colors.redAccent
          ),
        ),
      ),
    );
  }
}

