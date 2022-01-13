import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/utils/constants.dart';

class RoundedInputFieldNumber extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  const RoundedInputFieldNumber({Key key, this.hintText, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType: TextInputType.number,
        maxLength: 8,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            Icons.phone,
            color: kPrimaryColor,
          ),
          counterText: "",
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
