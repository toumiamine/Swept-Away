import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/utils/constants.dart';

class RoundedPasswordFiled extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordFiled({Key key,this.onChanged}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(Icons.lock,color: kPrimaryColor,),
          suffixIcon: Icon(Icons.visibility,color: kPrimaryColor,),
          hintText: "Password",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
