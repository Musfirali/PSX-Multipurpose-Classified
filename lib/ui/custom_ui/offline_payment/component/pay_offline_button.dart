import 'package:flutter/material.dart';

import '../../../vendor_ui/offline_payment/component/pay_offline_button.dart';

class CustomPayOfflineButton extends StatelessWidget {
  const CustomPayOfflineButton({required this.onPressed});
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return PayOfflineButton(onPressed: onPressed);
  }
}
