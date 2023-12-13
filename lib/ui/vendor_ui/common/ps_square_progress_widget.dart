

import 'package:flutter/material.dart';

import '../../../config/ps_colors.dart';
import '../../../core/vendor/utils/utils.dart';

class PsSquareProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( 
      width : 25, 
      height : 25,       
      child: LinearProgressIndicator(
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.black12),
        backgroundColor: Utils.isLightMode(context) ? PsColors.achromatic100 : PsColors.achromatic600
      ),
    );
  }
}