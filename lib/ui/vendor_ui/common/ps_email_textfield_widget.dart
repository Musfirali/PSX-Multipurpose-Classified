import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';

class PsEmailTextFieldWidget extends StatelessWidget {
  const PsEmailTextFieldWidget({
    this.textEditingController,
    this.hintText,
    this.height = PsDimens.space44,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  });

  final TextEditingController? textEditingController;
  final String? hintText;
  final double height;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    final Widget _productTextFieldWidget = TextField(
      keyboardType: TextInputType.text,
      textInputAction: textInputAction,
      maxLines: null,
      controller: textEditingController,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
            left: PsDimens.space12,
            bottom: PsDimens.space14,
            top: PsDimens.space8),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0, color: PsColors.text400),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0, color: PsColors.text400),
        ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Utils.isLightMode(context)
                ? PsColors.text400
                : PsColors.text500),
      ),
    );
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: height,
          margin: const EdgeInsets.only(
              left: PsDimens.space16, right: PsDimens.space16),
          child: _productTextFieldWidget,
        ),
      ],
    );
  }
}
