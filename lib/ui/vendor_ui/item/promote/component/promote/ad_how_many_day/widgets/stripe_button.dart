import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/ui/vendor_ui/item/promote/component/promote/ad_how_many_day/widgets/demo_warning_dialog.dart';
import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../config/route/route_paths.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/holder/paid_history_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';

class StripeButton extends StatelessWidget {
  const StripeButton(
      {required this.product,
      required this.amount,
      required this.howManyDay,
      required this.selectedDate,
      required this.selectedTime,
      required this.provider,
      required this.appProvider});

  final Product product;
  final String howManyDay;
  final String amount;
  final String selectedDate;
  final DateTime selectedTime;
  final ItemPromotionProvider provider;
  final AppInfoProvider? appProvider;

  @override
  Widget build(BuildContext context) {
        final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    String? chooseDay;
    chooseDay = howManyDay;

    String? startDate;
    startDate = selectedDate;

    DateTime? time;
    time = selectedTime;

    return Container(
      margin: const EdgeInsets.only(
          top: PsDimens.space8,
          left: PsDimens.space16,
          right: PsDimens.space16),
      width: double.infinity,
      child: InkWell(
        onTap: () async {
          if (double.parse(amount) <= 0) {
            return;
          }

          if (valueHolder.isDemoForPayment!) {
            await callDemoWarningDialog(context);
          }

          final int resultStartTimeStamp =
              Utils.getTimeStampDividedByOneThousand(time!);

          final dynamic returnData = await Navigator.pushNamed(
              context, RoutePaths.creditCard,
              arguments: PaidHistoryHolder(
                  product: product,
                  amount: amount,
                  howManyDay: chooseDay,
                  paymentMethod: PsConst.PAYMENT_STRIPE_METHOD,
                  stripePublishableKey:
                      appProvider!.appInfo.data!.stripePublishableKey,
                  startDate: startDate,
                  startTimeStamp: resultStartTimeStamp.toString(),
                  itemPaidHistoryProvider: provider,
                  payStackKey: ''));

          if (returnData == null || returnData) {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
          }
          //}
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        width: 62,
                        height: 62,
                        child: Image.asset('assets/images/payment/stripe.png')),
                    const SizedBox(
                      height: 2,
                    )
                  ],
                ),
                const SizedBox(width: PsDimens.space16),
                Text(
                  'item_promote__stripe'.tr,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Utils.isLightMode(context)
                          ? PsColors.achromatic800 : PsColors.achromatic50),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: Utils.isLightMode(context)
                  ? PsColors.achromatic800 : PsColors.achromatic50,
            )
          ],
        ),
      ),
    );
  }
}
