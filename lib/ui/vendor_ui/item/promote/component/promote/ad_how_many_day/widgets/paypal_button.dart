import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/ui/vendor_ui/item/promote/component/promote/ad_how_many_day/widgets/demo_warning_dialog.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../../../core/vendor/provider/token/token_provider.dart';
import '../../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/item_paid_history_parameter_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../../../core/vendor/viewobject/item_paid_history.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../common/dialog/error_dialog.dart';
import '../../../../../../common/dialog/success_dialog.dart';

class PayPalButton extends StatelessWidget {
  const PayPalButton(
      {required this.product,
      required this.amount,
      required this.howManyDay,
      required this.selectedDate,
      required this.selectedTime,
      required this.tokenProvider,
      required this.provider,
      required this.appProvider,
      required this.userProvider,
      required this.langProvider});

  final Product product;
  final String howManyDay;
  final String amount;
  final String selectedDate;
  final DateTime selectedTime;
  final TokenProvider? tokenProvider;
  final ItemPromotionProvider? provider;
  final AppInfoProvider? appProvider;
  final UserProvider? userProvider;
  final AppLocalization? langProvider;

  @override
  Widget build(BuildContext context) {
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
          final TokenProvider tokenProvider =
              Provider.of<TokenProvider>(context, listen: false);
          final PsValueHolder psValueHolder =
              Provider.of<PsValueHolder>(context, listen: false);

          if (double.parse(amount) <= 0) {
            return;
          }
          print('Payapl amount :::::::::::::::' + amount);

          final PsResource<ApiStatus> tokenResource =
              await tokenProvider.loadToken(psValueHolder.loginUserId!,
                  langProvider!.currentLocale.languageCode);

          if (psValueHolder.isDemoForPayment!) {
            await callDemoWarningDialog(context);
          }
          final String? message = tokenResource.data!.message;
          // final BraintreePayment braintreePayment = BraintreePayment();
          // final dynamic data = await braintreePayment.showDropIn(
          //     nonce: message, amount: amount, enableGooglePay: true);

          final BraintreeDropInRequest request = BraintreeDropInRequest(
            clientToken: message,
            collectDeviceData: true,
            googlePaymentRequest: BraintreeGooglePaymentRequest(
              totalPrice: amount,
              currencyCode: appProvider!.appInfo.data!.currencyShortForm!,
              billingAddressRequired: false,
            ),
            paypalRequest: BraintreePayPalRequest(
              amount: amount,
              displayName: userProvider!.user.data!.name,
            ),
          );

          final BraintreeDropInResult? result =
              await BraintreeDropIn.start(request);
          if (result != null) {
            print('Nonce: ${result.paymentMethodNonce.nonce}');
          } else {
            print('Selection was canceled.');
          }
          Utils.psPrint(message);

          final int reultStartTimeStamp =
              Utils.getTimeStampDividedByOneThousand(time!);

          // ignore: unnecessary_null_comparison
          if (provider != null) {
            final ItemPaidHistoryParameterHolder
                itemPaidHistoryParameterHolder = ItemPaidHistoryParameterHolder(
                    itemId: product.id,
                    amount: amount,
                    howManyDay: chooseDay,
                    paymentMethod: PsConst.PAYMENT_PAYPAL_METHOD,
                    paymentMethodNounce: result!.paymentMethodNonce.nonce,
                    startDate: startDate,
                    startTimeStamp: reultStartTimeStamp.toString(),
                    razorId: '',
                    purchasedId: '',
                    isPaystack: PsConst.ZERO);

            await PsProgressDialog.showDialog(context);
            final PsValueHolder psValueHolder =
                Provider.of<PsValueHolder>(context, listen: false);
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
                        Navigator.of(context).pop(true);
                        Navigator.of(context).pop(true);
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
          } else {
            Utils.psPrint(
                'Item paid history provider is null , please check!!!');
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
                        child: Image.asset('assets/images/payment/paypal.png')),
                    const SizedBox(
                      height: 2,
                    )
                  ],
                ),
                const SizedBox(width: PsDimens.space16),
                Text(
                  'item_promote__paypal'.tr,
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
