import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';

class PsTextFieldWidgetWithIcon extends StatelessWidget {
  const PsTextFieldWidgetWithIcon(
      {this.textEditingController,
      this.hintText,
      this.height = PsDimens.space44,
      this.keyboardType = TextInputType.text,
      this.clickEnterFunction,
      this.clickSearchButton});

  final TextEditingController? textEditingController;
  final String? hintText;
  final double height;
  final TextInputType keyboardType;
  final Function? clickEnterFunction;
  final Function? clickSearchButton;

  @override
  Widget build(BuildContext context) {
    final Widget _productTextFieldWidget = TextField(
      keyboardType: TextInputType.text,
      maxLines: 1,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.left,
      textInputAction: TextInputAction.search,
      controller: textEditingController,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 14,
          color: Utils.isLightMode(context)
              ? PsColors.text800
              : PsColors.achromatic50),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
            left: PsDimens.space16, bottom: PsDimens.space4),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 14,
            color: Utils.isLightMode(context)
                ? PsColors.text800
                : PsColors.achromatic800),
        prefixIcon: InkWell(
            child: Icon(
              Icons.search,
              color: Utils.isLightMode(context)
                  ? PsColors.text600
                  : PsColors.accent50,
            ),
            onTap: () {
              clickSearchButton!();
            }),
      ),
      onSubmitted: (String value) {
        clickEnterFunction!();
      },
    );

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: height,
          margin: const EdgeInsets.all(PsDimens.space12),
          decoration: BoxDecoration(
            color: Utils.isLightMode(context) ? PsColors.text50 : PsColors.achromatic900,
            borderRadius: BorderRadius.circular(PsDimens.space12),
          ),
          child: _productTextFieldWidget,
        ),
      ],
    );
  }
}

class PsTextFieldWidgetWithIcon2 extends StatelessWidget {
  const PsTextFieldWidgetWithIcon2(
      {this.textEditingController,
      this.hintText,
      this.height = PsDimens.space44,
      this.keyboardType = TextInputType.text,
      this.clickEnterFunction,
      this.onTap,
      this.clickSearchButton});

  final TextEditingController? textEditingController;
  final String? hintText;
  final double height;
  final TextInputType keyboardType;
  final Function? clickEnterFunction;
  final Function? clickSearchButton;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final Widget _productTextFieldWidget = Container(
        padding: const EdgeInsets.only(left: PsDimens.space16, right: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
              textEditingController!.text == ''
                  ? hintText!
                  : textEditingController!.text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Utils.isLightMode(context) ? PsColors.text700 : PsColors.text100, fontSize: 14)),
        ));

    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PsDimens.space4),
                  border: Border.all(
                      color: Utils.isLightMode(context) ? PsColors.text300 : PsColors.text50),
                ),
                child: _productTextFieldWidget,
              ),
              Positioned(
                right: 1,
                child: Container(
                  width: 50,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PsDimens.space8),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic900
                        : PsColors.accent50,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
