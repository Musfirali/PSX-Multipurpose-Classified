import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../config/route/route_paths.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../../core/vendor/provider/token/token_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/promote_payment_intent_holder.dart';
import '../../../../../../custom_ui/item/promote/component/promote/ad_how_many_day/widgets/custom_promote_item.dart';
import '../../../../../../custom_ui/item/promote/component/promote/ad_how_many_day/widgets/promote_item.dart';
import '../../../../../common/dialog/warning_dialog_view.dart';

class AdsHowManyDayWidget extends StatefulWidget {
  const AdsHowManyDayWidget(
      {Key? key, required this.product, required this.tokenProvider})
      : super(key: key);

  final Product product;
  final TokenProvider? tokenProvider;
  @override
  State<StatefulWidget> createState() {
    return AdsHowManyDayWidgetState();
  }
}

class AdsHowManyDayWidgetState extends State<AdsHowManyDayWidget> {
  TextEditingController getEnterDateCountController = TextEditingController();
  bool getDefaultChoiceDate = true;
  bool getFirstChoiceDate = false;
  bool getSecondChoiceDate = false;
  bool getThirdChoiceDate = false;
  bool getFourthChoiceDate = false;
  bool getFifthChoiceDate = false;

  late double amountByFirstChoice;
  late double amountBySecondChoice;
  late double amountByThirdChoice;
  late double amountByFourthChoice;
  late double amountByDay;

  late PsValueHolder psValueHolder;
  late ItemPromotionProvider provider;
  late AppInfoProvider appInfoprovider;
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    provider = Provider.of<ItemPromotionProvider>(context, listen: false);
    appInfoprovider = Provider.of<AppInfoProvider>(context, listen: false);
    return Consumer<AppInfoProvider>(builder:
        (BuildContext context, AppInfoProvider appInfoprovider, Widget? child) {
      return Consumer<UserProvider>(builder:
          (BuildContext context, UserProvider userProvider, Widget? child) {
        if (appInfoprovider.appInfo.data == null) {
          return const SizedBox();
        } else {
          final String oneDay = appInfoprovider.pricePerOneDay;

          amountByFirstChoice = double.parse(oneDay) *
              double.parse(psValueHolder.promoteFirstChoiceDay!);
          amountBySecondChoice = double.parse(oneDay) *
              double.parse(psValueHolder.promoteSecondChoiceDay!);
          amountByThirdChoice = double.parse(oneDay) *
              double.parse(psValueHolder.promoteThirdChoiceDay!);
          amountByFourthChoice = double.parse(oneDay) *
              double.parse(psValueHolder.promoteFourthChoiceDay!);

          if (getDefaultChoiceDate) {
            provider.amount = amountByFirstChoice.toString();
            provider.howManyDay = psValueHolder.promoteFirstChoiceDay!;
          }

          return Container(
            margin: const EdgeInsets.only(left: PsDimens.space16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Choose Promotion'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 16,
                ),
                //First Choice or Default
                CustomPromoteItem(
                  onTap: onFirstItemTap,
                  product: widget.product,
                  day: psValueHolder.promoteFirstChoiceDay!,
                  amount: amountByFirstChoice.toString(),
                  //isCurrentSelected: getFirstChoiceDate || getDefaultChoiceDate,
                ),
                //Second Choice
                CustomPromoteItem(
                  onTap: onSecondItemTap,
                  product: widget.product,
                  day: psValueHolder.promoteSecondChoiceDay!,
                  amount: amountBySecondChoice.toString(),
                  //isCurrentSelected: getFirstChoiceDate || getDefaultChoiceDate,
                ),

                // //Third Choice
                CustomPromoteItem(
                  onTap: onThirdItemTap,
                  product: widget.product,
                  day: psValueHolder.promoteThirdChoiceDay!,
                  amount: amountByThirdChoice.toString(),
                ),
                // //Fourth Choice
                CustomPromoteItem(
                  onTap: onFourthItemTap,
                  day: psValueHolder.promoteFourthChoiceDay!,
                  amount: amountByFourthChoice.toString(),
                  product: widget.product,
                ),
                Row(
                  children: <Widget>[
                    const Flexible(
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'or'.tr,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Flexible(
                      child: Divider(
                        height: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                //Custom Choice
                CustomCustomPromoteItem(
                  getEnterDateCountController: getEnterDateCountController,
                  //isCurrentSelected: getFifthChoiceDate,
                  onTap: onCustomItemTap,
                ),
              ],
            ),
          );
        }
      });
    });
  }

  dynamic callPomoteDateTimeWarningDialog(BuildContext context) async {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return WarningDialog(
            message: 'item_promote__choose_start_date'.tr,
            onPressed: () {},
          );
        });
  }

  void onFirstItemTap() {
    if (provider.selectedDate == '' || provider.selectedDate == null) {
      callPomoteDateTimeWarningDialog(context);
    } else {
      Navigator.pushNamed(context, RoutePaths.paymentView,
          arguments: PromotePaymentIntentHolder(
            product: widget.product,
            date: provider.selectedDate!,
            time: provider.selectedDateTime!,
            day: psValueHolder.promoteFirstChoiceDay!,
            amount: amountByFirstChoice.toString(),
            appInfoProvider: appInfoprovider,
            itemPaidHistoryProvider: provider,
            userProvider: userProvider
          ));
    }
  }

  void onSecondItemTap() {
    if (provider.selectedDate == '' || provider.selectedDate == null) {
      callPomoteDateTimeWarningDialog(context);
    } else {
      Navigator.pushNamed(context, RoutePaths.paymentView,
          arguments: PromotePaymentIntentHolder(
            product: widget.product,
            date: provider.selectedDate!,
            time: provider.selectedDateTime!,
            day: psValueHolder.promoteSecondChoiceDay!,
            amount: amountBySecondChoice.toString(),
             appInfoProvider: appInfoprovider,
             itemPaidHistoryProvider: provider,
              userProvider: userProvider
          ));
    }
  }

  void onThirdItemTap() {
    if (provider.selectedDate == '' || provider.selectedDate == null) {
      callPomoteDateTimeWarningDialog(context);
    } else {
      Navigator.pushNamed(context, RoutePaths.paymentView,
          arguments: PromotePaymentIntentHolder(
            product: widget.product,
            date: provider.selectedDate!,
            time: provider.selectedDateTime!,
            day: psValueHolder.promoteThirdChoiceDay!,
            amount: amountByThirdChoice.toString(),
             appInfoProvider: appInfoprovider,
             itemPaidHistoryProvider: provider,
              userProvider: userProvider
          ));
    }
  }

  void onFourthItemTap() {
    if (provider.selectedDate == '' || provider.selectedDate == null) {
      callPomoteDateTimeWarningDialog(context);
    } else {
      Navigator.pushNamed(context, RoutePaths.paymentView,
          arguments: PromotePaymentIntentHolder(
            product: widget.product,
            date: provider.selectedDate!,
            time: provider.selectedDateTime!,
            day: psValueHolder.promoteFourthChoiceDay!,
            amount: amountByFourthChoice.toString(),
             appInfoProvider: appInfoprovider,
             itemPaidHistoryProvider: provider,
              userProvider: userProvider
          ));
    }
  }

  void onCustomItemTap() {
    if (provider.selectedDate == '' || provider.selectedDate == null) {
      callPomoteDateTimeWarningDialog(context);
    } else {
      Navigator.pushNamed(context, RoutePaths.paymentView,
          arguments: PromotePaymentIntentHolder(
              product: widget.product,
              date: provider.selectedDate!,
              time: provider.selectedDateTime!,
              day: getEnterDateCountController.text,
              amount: (double.parse(getEnterDateCountController.text) *
                      double.parse(appInfoprovider.pricePerOneDay))
                  .toString(),
                   appInfoProvider: appInfoprovider,itemPaidHistoryProvider: provider, userProvider: userProvider));
    }
  }
}
