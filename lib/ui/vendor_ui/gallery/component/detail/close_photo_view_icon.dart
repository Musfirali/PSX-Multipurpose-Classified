import 'dart:io';

import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';

class ClosePhotoViewIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: PsDimens.space16,
        top: Platform.isIOS ? PsDimens.space60 : PsDimens.space40,
        child: GestureDetector(
          child: Container(
              width: 50,
              height: 50,
              child: Icon(Icons.clear, color: PsColors.achromatic50)),
          onTap: () {
            Navigator.pop(context);
          },
        ));
  }
}
