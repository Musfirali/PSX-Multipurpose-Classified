import 'package:flutter/material.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';


class DividerORWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget _dividerWidget = Expanded(
      child: Divider(
        height: PsDimens.space2,
        color: Utils.isLightMode(context)
            ? PsColors.achromatic400 : PsColors.achromatic50,
      ),
    );

    const Widget _spacingWidget = SizedBox(
      width: PsDimens.space8,
    );

    final Widget _textWidget = Text(
      'or',
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Utils.isLightMode(context)
                ? PsColors.text400
                : PsColors.text300,
          ),
    );
    return Padding(
      padding: const EdgeInsets.only(
          top: PsDimens.space12,
          left: PsDimens.space16,
          right: PsDimens.space16,
        ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _dividerWidget,
          _spacingWidget,
          _textWidget,
          _spacingWidget,
          _dividerWidget,
        ],
      ),
    );
  }
}
