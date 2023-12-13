import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';

class PsDateTimePickerWithIconWidget extends StatelessWidget {
  const PsDateTimePickerWithIconWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      this.textEditingController,
      this.hintText,
      this.isStar = false,
      this.iconData})
      : super(key: key);

  final String title;
  final TextEditingController? textEditingController;
  final Function onTap;
  final bool isStar;
  final String? hintText;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    final Widget _productTextWidget =
        Text(title, style: Theme.of(context).textTheme.titleMedium);
    final Widget _productTextWithStarWidget = Row(
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        Text(' *',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).primaryColor))
      ],
    );

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
              left: PsDimens.space16,
              top: PsDimens.space12,
              right: PsDimens.space16),
          child: Row(
            children: <Widget>[
              if (isStar) _productTextWithStarWidget,
              if (!isStar) _productTextWidget,
            ],
          ),
        ),
        InkWell(
          onTap: onTap as void Function()?,
          child: Container(
            // color: PsColors.primary50,
            width: double.infinity,
            height: PsDimens.space44,
            margin: const EdgeInsets.only(
                top: PsDimens.space12,
                left: PsDimens.space16,
                right: PsDimens.space16,
                bottom: PsDimens.space12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PsDimens.space4),
              border: Border.all(color: Utils.isLightMode(context) ? PsColors.text400 : PsColors.text300),
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: PsDimens.space12),
                      child: Text(
                        textEditingController!.text == ''
                            ? hintText ?? 'home_search__not_set'.tr
                            : textEditingController!.text.tr,
                        style: textEditingController!.text == ''
                            ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Utils.isLightMode(context) ? PsColors.text50 : PsColors.text300)
                            : Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                    //),
                  ),
                  if (iconData != null)
                    Padding(
                      padding: const EdgeInsets.only(right: PsDimens.space20),
                      child: Icon(
                        iconData,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        //),
      ],
    );
  }
}
