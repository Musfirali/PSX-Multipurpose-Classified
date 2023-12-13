import 'package:flutter/material.dart';

import '../../../vendor_ui/introslider/component/next_button.dart';

class CustomNextButton extends StatelessWidget {
  const CustomNextButton({required this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return NextButton(
      onTap: onTap,
    );
  }
}
