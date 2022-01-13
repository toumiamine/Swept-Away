import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/utils/constants.dart';

class RoundedInputFieldSerial extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  const RoundedInputFieldSerial({Key key, this.hintText, this.onChanged})
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
            Icons.one_x_mobiledata_outlined,
            color: Colors.black,
          ),
          counterText: "",
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
