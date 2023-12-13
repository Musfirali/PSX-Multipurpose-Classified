import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

class PriceDollar extends StatelessWidget {
  const PriceDollar(this.value);
  final String value;
  // ignore: avoid_field_initializers_in_const_classes
  final int maxDollar = 5;

  @override
  Widget build(BuildContext context) {
     final int parsedValue = int.tryParse(value) ?? 0;
    return Row(
     // mainAxisAlignment: MainAxisAlignment.start,

      //mainAxisSize: MainAxisSize.max,
      // ignore: always_specify_types
      children: List.generate(maxDollar, (int index) {
        return Text(
          '\$',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16.0,
            color: index < parsedValue  
              ? Theme.of(context).primaryColor
              : PsColors.text400,
          ),
        );
      }),
    );
  }
}
