import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../core/vendor/viewobject/common/ps_value_holder.dart';

class BluemarkIcon extends StatelessWidget {
  const BluemarkIcon({this.icon});
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return Container(
      child: Icon(
        icon ?? Icons.check_circle,
        color: PsColors.info500,
        size: psValueHolder.bluemarkSize,
      ),
    );
  }
}
