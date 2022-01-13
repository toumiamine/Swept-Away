import 'package:flutter/material.dart';
import 'package:flutter_auth/utils/constants.dart';

class DefaultBackButton extends StatelessWidget {
  const DefaultBackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
