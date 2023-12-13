import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/item_paid_history_parameter_holder.dart';
import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../core/vendor/viewobject/item_paid_history.dart';
import '../../../../../core/vendor/viewobject/product.dart';
import '../../../common/base/ps_widget_with_appbar_with_no_provider.dart';
import '../../../common/dialog/error_dialog.dart';
import '../../../common/dialog/success_dialog.dart';
import '../../../common/dialog/warning_dialog_view.dart';
import '../../../common/ps_button_widget.dart';

class CreditCardView extends StatefulWidget {
  const CreditCardView(
      {Key? key,
      required this.product,
      required this.amount,
      required this.howManyDay,
      required this.paymentMethod,
      required this.stripePublishableKey,
      required this.startDate,
      required this.startTimeStamp,
      required this.itemPaidHistoryProvider})
      : super(key: key);

  final Product product;
  final String? amount;
  final String? howManyDay;
  final String paymentMethod;
  final String? stripePublishableKey;
  final String? startDate;
  final String startTimeStamp;
  final ItemPromotionProvider itemPaidHistoryProvider;

  @override
  State<StatefulWidget> createState() {
    return CreditCardViewState();
  }
}

class CreditCardViewState extends State<CreditCardView> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  CardFieldInputDetails? cardData;

  @override
  void initState() {
    Stripe.publishableKey = widget.stripePublishableKey!;
    // StripePayment.setOptions(StripeOptions(
    //     publishableKey: widget.stripePublishableKey,
    //     merchantId: 'Test',
    //     androidPayMode: 'test'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PsWidgetWithAppBarWithNoProvider(
      appBarTitle: 'item_promote__credit_card_title'.tr,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(PsDimens.space16),
            child: CardField(
              autofocus: false,
              onCardChanged: (CardFieldInputDetails? card) async {
                setState(() {
                  cardData = card;
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: PsDimens.space12, right: PsDimens.space12),
            child: PSButtonWidget(
              hasShadow: true,
              width: double.infinity,
              titleText: 'credit_card__pay'.tr,
              onPressed: () async {
                if (cardData != null && cardData!.complete) {
                  await PsProgressDialog.showDialog(context);

                  const PaymentMethodParams paymentMethodParams =
                      PaymentMethodParams.card(
                          paymentMethodData: PaymentMethodData(
                              billingDetails: BillingDetails()));

                  final PaymentMethod paymentMethod = await Stripe.instance
                      .createPaymentMethod(params:paymentMethodParams);
                  Utils.psPrint(paymentMethod.id);
                  await stripeNow(paymentMethod.id);
                } else {
                  callWarningDialog(context, 'contact_us__fail'.tr);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  dynamic callPaidAdSubmitApi(
    BuildContext context,
    Product product,
    String? amount,
    String? howManyDay,
    String paymentMethod,
    String? stripePublishableKey,
    String? startDate,
    String startTimeStamp,
    ItemPromotionProvider itemPaidHistoryProvider,
    // ProgressDialog progressDialog,
    String token,
  ) async {
    if (await Utils.checkInternetConnectivity()) {
      final ItemPaidHistoryParameterHolder itemPaidHistoryParameterHolder =
          ItemPaidHistoryParameterHolder(
              itemId: product.id,
              amount: amount,
              howManyDay: howManyDay,
              paymentMethod: paymentMethod,
              paymentMethodNounce: Platform.isIOS ? token : token,
              startDate: startDate,
              startTimeStamp: startTimeStamp,
              razorId: '',
              purchasedId: '',
              isPaystack: PsConst.ZERO);
      final PsValueHolder psValueHolder =
          Provider.of<PsValueHolder>(context, listen: false);
      final PsResource<ItemPaidHistory> padiHistoryDataStatus =
          await itemPaidHistoryProvider.postData(
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder)),
              requestBodyHolder: itemPaidHistoryParameterHolder);

      if (padiHistoryDataStatus.data != null) {
        // progressDialog.dismiss();
        PsProgressDialog.dismissDialog();
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext contet) {
              return SuccessDialog(
                message: 'item_promote__success'.tr,
                onPressed: () {
                  Navigator.pop(context, true);
                },
              );
            });
      } else {
        PsProgressDialog.dismissDialog();
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: padiHistoryDataStatus.message,
              );
            });
      }
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: 'error_dialog__no_internet'.tr,
            );
          });
    }
  }

  void setError(dynamic error) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            message: error.toString().tr,
          );
        });
  }

  dynamic callWarningDialog(BuildContext context, String text) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return WarningDialog(
            message: text.tr,
            onPressed: () {},
          );
        });
  }

  dynamic stripeNow(String token) async {
    callPaidAdSubmitApi(
      context,
      widget.product,
      widget.amount,
      widget.howManyDay,
      widget.paymentMethod,
      widget.stripePublishableKey,
      widget.startDate,
      widget.startTimeStamp,
      widget.itemPaidHistoryProvider,
      // progressDialog,
      token,
    );
  }
}
