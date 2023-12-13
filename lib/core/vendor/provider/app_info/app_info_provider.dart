import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../repository/app_info_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/app_info_parameter_holder.dart';
import '../../viewobject/holder/request_path_holder.dart';
import '../../viewobject/ps_app_info.dart';
import '../common/ps_provider.dart';

class AppInfoProvider extends PsProvider<PSAppInfo> {
  AppInfoProvider({
    required AppInfoRepository? repo,
    this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.NO_SUBSCRIPTION) {
    _repo = repo;
    isDispose = false;
  }

  AppInfoRepository? _repo;
  PsValueHolder? psValueHolder;

  PsResource<PSAppInfo> _psAppInfo =
      PsResource<PSAppInfo>(PsStatus.NOACTION, '', null);

  PsResource<PSAppInfo> get appInfo => _psAppInfo;
  String? realStartDate = '0';
  String realEndDate = '0';
  bool isSubLocation = false;

  String get pricePerOneDay {
    return appInfo.data?.appSetting?.oneDayPerPrice ?? '10';
  }

  bool get isAllPaymentDisable {
    return appInfo.data != null &&
        appInfo.data!.inAppPurchasedEnabled == PsConst.ZERO &&
        appInfo.data!.stripeEnable == PsConst.ZERO &&
        appInfo.data!.paypalEnable == PsConst.ZERO &&
        appInfo.data!.payStackEnabled == PsConst.ZERO &&
        appInfo.data!.razorEnable == PsConst.ZERO &&
        appInfo.data!.offlineEnabled == PsConst.ZERO;
  }

  bool get isIAPEnable {
    return appInfo.data!.inAppPurchasedEnabled == PsConst.ONE;
  }

  bool get isPayStackEnabled {
    return appInfo.data!.payStackEnabled == PsConst.ONE;
  }

  bool get isOfflinePaymentEnabled {
    return appInfo.data!.offlineEnabled == PsConst.OFFLINE_PAYMENT_ENABLE;
  }

  bool get isRazorPaymentEnabled {
    return appInfo.data!.razorEnable == PsConst.RAZOR_ENABLE;
  }

  bool get isPaypalEnabled {
    return appInfo.data!.paypalEnable == PsConst.PAYPAL_ENABLE;
  }

  bool get isStripeEnabled {
    return appInfo.data!.stripeEnable == PsConst.STRIPE_ENABLE;
  }

  Future<void> loadDeleteHistorywithNotifier(
      AppInfoParameterHolder appInfoParameterHolder) async {
    isLoading = true;

    // if (psValueHolder == null || psValueHolder!.startDate == null) {
    //   realStartDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    // } else {
    //   realStartDate = psValueHolder!.endDate;

    //   realEndDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    //   final AppInfoParameterHolder appInfoParameterHolder =
    //       AppInfoParameterHolder(
    //           startDate: realStartDate,
    //           endDate: realEndDate,
    //           userId: Utils.checkUserLoginId(psValueHolder!));

    final PsResource<PSAppInfo> psAppInfo = await _repo!.postData(
        requestBodyHolder: appInfoParameterHolder,
        requestPathHolder: RequestPathHolder(
            loginUserId: Utils.checkUserLoginId(psValueHolder!)));
    _psAppInfo = psAppInfo;

    // }
  }
}

SingleChildWidget initAppInfoProvider(
  BuildContext context,
  Function function, {
  Widget? widget,
}) {
  final AppInfoRepository repo = Provider.of<AppInfoRepository>(context);
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  final AppLocalization langProvider = Provider.of<AppLocalization>(context);
  final AppInfoParameterHolder appInfoParameterHolder = AppInfoParameterHolder(
      languageCode: langProvider.currentLocale.languageCode,
      countryCode: langProvider.currentLocale.countryCode);
  return psInitProvider<AppInfoProvider>(
      initProvider: () =>
          AppInfoProvider(repo: repo, psValueHolder: valueHolder),
      onProviderReady: (AppInfoProvider pro) {
        pro.loadDeleteHistorywithNotifier(appInfoParameterHolder);
        function(pro);
      });
}
