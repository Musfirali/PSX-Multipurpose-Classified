import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/offline_payment/offline_payment_method_provider.dart';
import '../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../core/vendor/repository/offline_payment_method_repository.dart';
import '../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/item_paid_history_parameter_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../core/vendor/viewobject/item_paid_history.dart';
import '../../../../core/vendor/viewobject/product.dart';
import '../../../custom_ui/offline_payment/component/offline_payment_list.dart';
import '../../../custom_ui/offline_payment/component/pay_offline_button.dart';
import '../../common/base/ps_widget_with_appbar.dart';
import '../../common/dialog/error_dialog.dart';
import '../../common/dialog/success_dialog.dart';
import '../../common/ps_ui_widget.dart';

class OfflinePaymentView extends StatefulWidget {
  const OfflinePaymentView(
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
  _OfflinePaymentViewState createState() {
    return _OfflinePaymentViewState();
  }
}

class _OfflinePaymentViewState extends State<OfflinePaymentView>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late OfflinePaymentProvider _notiProvider;
  late AppLocalization langProvider;

  AnimationController? animationController;

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _notiProvider.loadNextDataList();
      }
    });
  }

  late OfflinePaymentMethodRepository repo1;
  PsValueHolder? psValueHolder;
  bool isConnectedToInternet = false;
  bool isSuccessfullyLoaded = true;

  void checkConnection() {
    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
      if (isConnectedToInternet && valueHolder.isShowAdmob!) {
        setState(() {});
      }
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

      final PsResource<ItemPaidHistory> padiHistoryDataStatus =
          await itemPaidHistoryProvider.postData(
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(psValueHolder)),
              requestBodyHolder: itemPaidHistoryParameterHolder);
      PsProgressDialog.dismissDialog();

      if (padiHistoryDataStatus.data != null) {
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

  late PsValueHolder valueHolder;

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);
    if (!isConnectedToInternet && valueHolder.isShowAdmob!) {
      print('loading ads....');
      checkConnection();
    }
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, false);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    timeDilation = 1.0;
    repo1 = Provider.of<OfflinePaymentMethodRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return WillPopScope(
      onWillPop: _requestPop,
      child: PsWidgetWithAppBar<OfflinePaymentProvider>(
          appBarTitle: 'item_promote__pay_offline'.tr,
          initProvider: () {
            return OfflinePaymentProvider(repo: repo1);
          },
          onProviderReady: (OfflinePaymentProvider provider) {
            provider.loadDataList(
                requestPathHolder: RequestPathHolder(
                    loginUserId: valueHolder.loginUserId,
                    languageCode: langProvider.currentLocale.languageCode));
            _notiProvider = provider;

            return provider;
          },
          builder: (BuildContext context, OfflinePaymentProvider provider,
              Widget? child) {
            if (provider.hasData) {
              return Stack(children: <Widget>[
                RefreshIndicator(
                  child: CustomScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        CustomOfflinePaymentList(
                            animationController: animationController!),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: PsDimens.space80),
                        ),    
                      ]),
                  onRefresh: () async {
                    return _notiProvider.loadDataList(reset: true);
                  },
                ),
                PSProgressIndicator(provider.currentStatus),
                CustomPayOfflineButton(onPressed: onPressed),
              ]);
            } else {
              return const SizedBox();
            }
          }),
    );
  }

  void onPressed() {
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
      '',
    );
  }
}
