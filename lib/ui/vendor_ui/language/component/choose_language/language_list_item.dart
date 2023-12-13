import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/viewobject/common/language.dart';
import '../../../common/check_icon_widget.dart';
import '../../../common/shimmer_item.dart';

class LanguageListItem extends StatelessWidget {
  const LanguageListItem({
    Key? key,
    required this.language,
    required this.animationController,
    required this.animation,
    required this.onTap,
    required this.isLoading,
  }) : super(key: key);

  final Language language;
  final AnimationController? animationController;
  final Animation<double> animation;
  final Function onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final AppLocalization langProvider = Provider.of<AppLocalization>(context);
    final bool isChecked =
        langProvider.currentLocale.countryCode == language.countryCode &&
            langProvider.currentLocale.languageCode == language.languageCode;
    animationController!.forward();
    return AnimatedBuilder(
        animation: animationController!,
        child: Column(
          children: <Widget>[
            Container(
              height: PsDimens.space48,
              alignment: Alignment.centerLeft,
              child: isLoading
                  ? const ShimmerItem()
                  : InkWell(
                      highlightColor: PsColors.primary50,
                      onTap: onTap as void Function()?,
                      child: Ink(
                          child: LanguageItemWidget(
                              isChecked: isChecked,
                              itemLocation: language.name))),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: PsDimens.space16,
                  right: PsDimens.space16,
                  bottom: PsDimens.space8),
              child: const Divider(
                height: PsDimens.space2,
              ),
            ),
          ],
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: animation,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 100 * (1.0 - animation.value), 0.0),
                  child: child));
        });
  }
}

class LanguageItemWidget extends StatelessWidget {
  const LanguageItemWidget({
    Key? key,
    required this.itemLocation,
    required this.isChecked,
  }) : super(key: key);

  final String? itemLocation;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      child: Row(
        children: <Widget>[
          if (isChecked)
            const CheckedIconWidget()
          else
            Icon(
              Icons.circle_outlined,
              color: PsColors.text400,
              size: 22,
            ),
          const SizedBox(
            width: PsDimens.space16,
          ),
          Text(itemLocation!,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
