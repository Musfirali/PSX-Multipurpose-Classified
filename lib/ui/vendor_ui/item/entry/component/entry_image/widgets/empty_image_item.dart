import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class EmptyImageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(PsDimens.space4),
      color: PsColors.achromatic500,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Icon(
          Icons.add_a_photo_outlined,
        ),
      ),
    );
    // return Image.asset(
    //   'assets/images/default_image.png',
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.height,
    //   fit: BoxFit.cover,
    // );
  }
}
