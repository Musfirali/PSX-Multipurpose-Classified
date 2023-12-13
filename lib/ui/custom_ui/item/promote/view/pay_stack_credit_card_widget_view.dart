import 'package:flutter/material.dart';

import '../../../../../core/plugin/paystack/pay_stack_credit_card_widget_view.dart';

class CustomPayStackCreditCardWidget extends StatefulWidget {
  const CustomPayStackCreditCardWidget({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
  });

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;

  @override
  _PayStackCreditCardWidgetState createState() =>
      _PayStackCreditCardWidgetState();
}

class _PayStackCreditCardWidgetState
    extends State<CustomPayStackCreditCardWidget> {
  @override
  Widget build(BuildContext context) {
    return PayStackCreditCardWidget(
        cardNumber: widget.cardNumber,
        expiryDate: widget.expiryDate,
        cardHolderName: widget.cardHolderName,
        cvvCode: widget.cvvCode);
  }
}
