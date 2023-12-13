import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/repository/user_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../ps_button_widget_with_round_corner.dart';

class ChoosePaymentTypeDialog extends StatefulWidget {
  const ChoosePaymentTypeDialog(
      {Key? key,
      required this.onInAppPurchaseTap,
      required this.onOtherPaymentTap})
      : super(key: key);

  final Function onInAppPurchaseTap;
  final Function onOtherPaymentTap;

  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<ChoosePaymentTypeDialog> {
  UserRepository? repo1;
  PsValueHolder? psValueHolder;

  @override
  Widget build(BuildContext context) {
    return NewDialog(widget: widget);
  }
}

class NewDialog extends StatelessWidget {
  const NewDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ChoosePaymentTypeDialog widget;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        width: 400.0,
        // height: 300.0,
        padding: const EdgeInsets.all(PsDimens.space16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('pesapal_payment__title'.tr,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Utils.isLightMode(context)
                            ? PsColors.achromatic800
                          : PsColors.achromatic50,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Utils.isLightMode(context)
                          ? PsColors.achromatic800
                          : PsColors.achromatic50,
                    )),
              ],
            ),
            const SizedBox(height: PsDimens.space16),
            PSButtonWidgetRoundCorner(
              hasBorder: true,
              colorData: PsColors.achromatic100,
              titleTextColor: Utils.isLightMode(context)
                  ? Theme.of(context).primaryColor
                  : Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
              hasShadow: false,
              width: double.infinity,
              titleText: 'item_promote__in_app_purchase'.tr,
              onPressed: () async {
                Navigator.pop(context);
                widget.onInAppPurchaseTap();
              },
            ),
            const SizedBox(height: PsDimens.space16),
            PSButtonWidgetRoundCorner(
              hasBorder: true,
              colorData: PsColors.achromatic100,
              titleTextColor: Utils.isLightMode(context)
                  ? Theme.of(context).primaryColor
                  : Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
              hasShadow: false,
              width: double.infinity,
              titleText: 'item_promote__other'.tr,
              onPressed: () async {
                Navigator.pop(context);
                widget.onOtherPaymentTap();
              },
            ),
          ],
        ),
      ),
    );
  }
}
