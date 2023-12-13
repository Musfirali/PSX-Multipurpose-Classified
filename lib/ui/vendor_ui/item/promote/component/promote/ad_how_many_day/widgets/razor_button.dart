import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/ui/vendor_ui/item/promote/component/promote/ad_how_many_day/widgets/demo_warning_dialog.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/item_paid_history_parameter_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../../../core/vendor/viewobject/item_paid_history.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../common/dialog/error_dialog.dart';
import '../../../../../../common/dialog/success_dialog.dart';

class RazorButton extends StatelessWidget {
  const RazorButton(
      {required this.product,
      required this.amount,
      required this.howManyDay,
      required this.selectedDate,
      required this.selectedTime,
      required this.provider,
      required this.appProvider,
      required this.userProvider});

  final Product product;
  final String howManyDay;
  final String amount;
  final String selectedDate;
  final DateTime selectedTime;
  final ItemPromotionProvider? provider;
  final AppInfoProvider? appProvider;
  final UserProvider? userProvider;

  @override
  Widget build(BuildContext context) {
    String? chooseDay;
    chooseDay = howManyDay;

    String? startDate;
    startDate = selectedDate;

    DateTime? time;
    time = selectedTime;

    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Container(
      margin: const EdgeInsets.only(
          top: PsDimens.space8,
          left: PsDimens.space16,
          right: PsDimens.space16),
      width: double.infinity,
      child: InkWell(
        onTap: () async {
          // final ItemPromotionProvider provider =
          //     Provider.of<ItemPromotionProvider>(context, listen: false);
          if (double.parse(amount) <= 0) {
            return;
          }

          if (psValueHolder.isDemoForPayment!) {
            await callDemoWarningDialog(context);
          }

          final int reultStartTimeStamp =
              Utils.getTimeStampDividedByOneThousand(time!);
          Future<void> _handlePaymentSuccess(
              PaymentSuccessResponse response) async {
            print('success');

            print(response);

            final ItemPaidHistoryParameterHolder
                itemPaidHistoryParameterHolder = ItemPaidHistoryParameterHolder(
                    itemId: product.id,
                    amount: Utils.getPriceFormat(
                        amount, psValueHolder.priceFormat!),
                    howManyDay: chooseDay,
                    paymentMethod: PsConst.PAYMENT_RAZOR_METHOD,
                    paymentMethodNounce: '',
                    startDate: startDate,
                    startTimeStamp: reultStartTimeStamp.toString(),
                    razorId: response.paymentId,
                    purchasedId: '',
                    isPaystack: PsConst.ZERO);

            await PsProgressDialog.showDialog(context);

            final PsResource<ItemPaidHistory> paidHistoryData = await provider!
                .postData(
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(psValueHolder)),
                    requestBodyHolder: itemPaidHistoryParameterHolder);

            PsProgressDialog.dismissDialog();

            if (paidHistoryData.data != null) {
              showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext contet) {
                    return SuccessDialog(
                      message: 'item_promote__success'.tr,
                      onPressed: () {
                        Navigator.pop(context, true);
                        Navigator.pop(context, true);
                      },
                    );
                  });
            } else {
              showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return ErrorDialog(
                      message: paidHistoryData.message,
                    );
                  });
            }
          }

          void _handlePaymentError(PaymentFailureResponse response) {
            // Do something when payment fails
            print('error');
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(
                    message: 'checkout__payment_fail'.tr,
                  );
                });
          }

          void _handleExternalWallet(ExternalWalletResponse response) {
            // Do something when an external wallet is selected
            print('external wallet');
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(
                    message: 'checkout__payment_not_supported'.tr,
                  );
                });
          }

          // ignore: unnecessary_null_comparison
          if (provider != null) {
            // Start Razor Payment
            final Razorpay _razorpay = Razorpay();
            _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
            _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
            _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

            final Map<String, Object?> options = <String, Object?>{
              'key': appProvider!.appInfo.data!.razorKey,
              'amount': (double.parse(Utils.getPriceTwoDecimal(amount)) * 100)
                  .round(),
              'name': userProvider!.user.data!.name,
              'currency': psValueHolder.isRazorSupportMultiCurrency!
                  ? appProvider!.appInfo.data!.currencyShortForm
                  : psValueHolder.defaultRazorCurrency,
              'description': '',
              'prefill': <String, String?>{
                'contact': userProvider!.user.data!.userPhone,
                'email': userProvider!.user.data!.userEmail
              }
            };

            if (await Utils.checkInternetConnectivity()) {
              _razorpay.open(options);
            } else {
              showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return ErrorDialog(
                      message: 'error_dialog__no_internet'.tr,
                    );
                  });
            }
          } else {
            Utils.psPrint(
                'Item paid history provider is null , please check!!!');
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                // const Icon(
                //   FontAwesome.credit_card,
                //   size: PsDimens.space40,
                // ),
                Column(
                  children: <Widget>[
                    Container(
                        width: 62,
                        height: 62,
                        child: Image.asset('assets/images/payment/razor.png')),
                    const SizedBox(
                      height: 2,
                    )
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'item_promote__razor'.tr,
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
