import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../core/vendor/repository/item_paid_history_repository.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/item_paid_history_parameter_holder.dart';
import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../core/vendor/viewobject/item_paid_history.dart';
import '../../../../../core/vendor/viewobject/ps_app_info.dart';
import '../../../../custom_ui/item/promote/component/in_app_purchase/iap_promote_item.dart';
import '../../../common/base/ps_widget_with_multi_provider.dart';
import '../../../common/dialog/error_dialog.dart';
import '../../../common/dialog/success_dialog.dart';
import '../../../common/dialog/warning_dialog_view.dart';

class InAppPurchaseView extends StatefulWidget {
  const InAppPurchaseView(this.itemId, this.appInfo);
  final String? itemId;
  final PSAppInfo? appInfo;
  @override
  _InAppPurchaseViewState createState() => _InAppPurchaseViewState();
}

class _InAppPurchaseViewState extends State<InAppPurchaseView> {
  /// Is the API available on the device
  bool available = true;

  /// The In App Purchase plugin
  final InAppPurchase _iap = InAppPurchase.instance;

  /// Products for sale
  List<ProductDetails> _products = <ProductDetails>[];

  /// Updates to purchases
  late StreamSubscription<List<PurchaseDetails>>? _subscription;

  final String _kConsumableId = 'consumable';

  ItemPaidHistoryRepository? repo1;
  PsValueHolder? psValueHolder;
  ItemPromotionProvider? itemPromotionProvider;
  TextEditingController startDateController = TextEditingController();
  String? amount;
  String status = '';

  String testId = 'android.test.purchased';
  String? prdIdforIOS;
  String? prdIdforAndroid;
  Map<String, String>? dayMap = <String, String>{};
  final bool _kAutoConsume = true;
  String? startDate;

  /// Initialize data
  Future<void> _initialize() async {
    // Check availability of In App Purchases
    available = await _iap.isAvailable();

    if (available) {
      await _getProducts();

      // Listen to new purchases
      _subscription = _iap.purchaseStream.listen(
          (List<PurchaseDetails> purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      }, onDone: () {
        print('Done Purhcase');
        _subscription?.cancel();
      }, onError: (dynamic error) {
        print(error);
        print('Error Purchase');
        PsProgressDialog.dismissDialog();
        // handle error here.
      });
      // await _removeUnfinishTransaction();
    }
  }

  Set<String> idListByPlatfrom() {
    String keyListString = '';

    if (Platform.isAndroid &&
        widget.appInfo!.inAppPurchasedPrdIdAndroid != null) {
      keyListString = widget.appInfo!.inAppPurchasedPrdIdAndroid!;
    } else if (Platform.isIOS &&
        widget.appInfo!.inAppPurchasedPrdIdIOS != null) {
      keyListString = widget.appInfo!.inAppPurchasedPrdIdIOS!;
    }
    // ignore: prefer_final_locals
    List<String> keyList = keyListString.split('##');
    keyList.removeLast();
    return keyList.toSet();
  }

  /// Get all products available for sale
  Future<void> _getProducts() async {
    ProductDetailsResponse response;
    response = await _iap.queryProductDetails(idListByPlatfrom());
    setState(() {
      _products = response.productDetails;
    });
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    PsProgressDialog.dismissDialog();
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (Platform.isAndroid) {
        if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
          final InAppPurchaseAndroidPlatformAddition androidAddition =
              _iap.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
          await androidAddition.consumePurchase(purchaseDetails);
        }
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await _iap.completePurchase(purchaseDetails);
      }

      if (purchaseDetails.status == PurchaseStatus.purchased) {
        //
        // Call PS Server
        //
        print('NEW PURCHASE');
        print(purchaseDetails.status);

        if (itemPromotionProvider!.selectedDate != null) {
          startDate = itemPromotionProvider!.selectedDate;
        }
        final DateTime dateTime = DateTime.now();
        final int resultStartTimeStamp =
            Utils.getTimeStampDividedByOneThousand(dateTime);

        if (await Utils.checkInternetConnectivity()) {
          final ItemPaidHistoryParameterHolder itemPaidHistoryParameterHolder =
              ItemPaidHistoryParameterHolder(
                  itemId: widget.itemId,
                  amount: amount,
                  howManyDay: dayMap![purchaseDetails.productID],
                  paymentMethod: PsConst.PAYMENT_IN_APP_PURCHASE_METHOD,
                  paymentMethodNounce: '',
                  startDate: startDate,
                  startTimeStamp: resultStartTimeStamp.toString(),
                  razorId: '',
                  purchasedId: purchaseDetails.purchaseID,
                  isPaystack: PsConst.ZERO);

          final PsResource<ItemPaidHistory> padiHistoryDataStatus =
              await itemPromotionProvider!.postData(
                  requestPathHolder: RequestPathHolder(
                      loginUserId: psValueHolder!.loginUserId),
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
          PsProgressDialog.dismissDialog();
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(
                  message: 'error_dialog__no_internet'.tr,
                );
              });
        } //
        Navigator.pop(context, true);
        Navigator.pop(context, true);
      }
    }
  }

  /// Purchase a product
  Future<void> _buyProduct(ProductDetails prod) async {
    final ProductDetails productDetails = prod;

    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);

    if (Platform.isIOS) {
      //
    }

    try {
      // if (productDetails.id == _kConsumableId) {
      final bool status =
          await _iap.buyConsumable(purchaseParam: purchaseParam);
      print(status);
      // }
    } catch (e) {
      print('error');
      PsProgressDialog.dismissDialog();
      if (Platform.isIOS) {
        // }
      }
    }
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    repo1 = Provider.of<ItemPaidHistoryRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
          ),
          iconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Theme.of(context).primaryColor),
          title: Text(
            'item_promote__in_app_purchase'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  //  color: Utils.isLightMode(context)? PsColors.primary500 : PsColors.primaryDarkWhite
                ),
          )),
      body: PsWidgetWithMultiProvider(
        child: MultiProvider(
          providers: <SingleChildWidget>[
            ChangeNotifierProvider<ItemPromotionProvider?>(
              lazy: false,
              create: (BuildContext context) {
                itemPromotionProvider =
                    ItemPromotionProvider(itemPaidHistoryRepository: repo1);

                return itemPromotionProvider;
              },
            ),
          ],
          child: Container(
            color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 14, top: 14.0),
                  child: Row(
                    children: <Widget>[
                      Text('Select Ads Start Date'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                      Text(' *',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Theme.of(context).primaryColor))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: PsDimens.space8),
                  child: Container(
                      width: double.infinity,
                      height: PsDimens.space44,
                      margin: const EdgeInsets.all(PsDimens.space12),
                      decoration: BoxDecoration(
                        color: Utils.isLightMode(context) ? PsColors.achromatic50
              : PsColors.achromatic900,
                        borderRadius: BorderRadius.circular(PsDimens.space4),
                        border: Border.all(color: Utils.isLightMode(context) ? PsColors.achromatic800 : PsColors.achromatic50),
                      ),
                      child: TextField(
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          controller: startDateController,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                                onTap: () async {
                                  await DatePicker.showDateTimePicker(context,
                                      minTime: DateTime.now(),
                                      onConfirm: (DateTime date) {
                                    itemPromotionProvider!.selectedDateTime =
                                        date;
                                  }, locale: LocaleType.en);
                                  if (itemPromotionProvider!.selectedDateTime !=
                                      null) {
                                    itemPromotionProvider!.selectedDate =
                                        DateFormat.yMMMMd('en_US').format(
                                                itemPromotionProvider!
                                                    .selectedDateTime!) +
                                            ' ' +
                                            DateFormat.Hms('en_US').format(
                                                itemPromotionProvider!
                                                    .selectedDateTime!);
                                  }
                                  setState(() {
                                    startDateController.text =
                                        itemPromotionProvider!.selectedDate!;
                                  });
                                },
                                child: const Icon(
                                  Icons.calendar_month_outlined,
                                  size: PsDimens.space28,
                                )),
                            contentPadding: const EdgeInsets.only(
                              top: PsDimens.space8,
                              left: PsDimens.space12,
                              bottom: PsDimens.space8,
                            ),
                            border: InputBorder.none,
                            hintText: '2020-10-2 3:00 PM',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Utils.isLightMode(context) ? PsColors.text300 : PsColors.text600, fontWeight: FontWeight.normal),
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, bottom: 18),
                  child: Text(
                    'Choose Promotion'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                for (ProductDetails prod in _products) ...<Widget>[
                  CustomIAPPromoteItem(
                      prod: prod,
                      onPressed: () {
                        onPressed(prod);
                      }),
                ]
              ],
            )),
          ),
        ),
      ),
    );
  }

  void onPressed(ProductDetails prod) {
    if (itemPromotionProvider!.selectedDate == null) {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return WarningDialog(
              message: 'item_promote__choose_start_date'.tr,
              onPressed: () {},
            );
          });
    } else {
      amount = prod.price;
      _buyProduct(prod);
    }
  }
}
