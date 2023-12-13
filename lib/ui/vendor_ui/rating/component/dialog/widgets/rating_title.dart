import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class RatingTitle extends StatelessWidget {
  const RatingTitle({Key? key, this.isEdit = true}) : super(key: key);
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: PsDimens.space52,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                isEdit ? 'Edit a review'.tr : 'Leave a review'.tr,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Utils.isLightMode(context)
                      ? PsColors.achromatic900
                      : PsColors.achromatic50,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                child: Icon(
                  Icons.close,
                  color: PsColors.achromatic900,
                ),
                onTap: () {
                  Navigator.pop(context, true);
                },
              ),
            ),
          ],
        ));
  }
}
