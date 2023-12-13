import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../constant/ps_constants.dart';
import '../../db/common/ps_data_source_manager.dart';
import '../../repository/Common/ps_repository.dart';
import '../../viewobject/common/ps_holder.dart';
import '../../viewobject/holder/request_path_holder.dart';
import '../../viewobject/ps_mobile_config_setting.dart';

class PsProvider<T> extends ChangeNotifier {
  PsProvider(
    this._psRepository,
    int limit, {
    required this.subscriptionType,
  }) {
    if (limit != 0) {
      this.limit = limit;
    }

    Utils.printLog('${runtimeType.toString()} Init $hashCode');
    // PsConfig.printLog('${runtimeType.toString()} Init $hashCode');
    _startSubscription();
  }

  /// For DataList Object
  StreamController<PsResource<List<dynamic>>>? dataListStreamController;
  StreamSubscription<PsResource<List<dynamic>>>? _dataListStreamSubscription;
  PsResource<List<T>> dataList =
      PsResource<List<T>>(PsStatus.NOACTION, '', <T>[]);

  /// For Single Object
  StreamController<PsResource<dynamic>>? dataStreamController;
  StreamSubscription<PsResource<dynamic>>? _dataStreamSubscription;
  PsResource<T> data = PsResource<T>(PsStatus.NOACTION, '', null);

  /// Config
  bool isConnectedToInternet = false;
  bool isLoading = false;
  final PsRepository? _psRepository;
  String subscriptionType;
  // final DataConfiguration defaultDataConfig = PsConfig.defaultDataConfig;
   // final DataConfiguration defaultDataConfig = Utils.getDataConfiguration();
  int? offset = 0;
  int limit = 30;
  int? _cacheDataLength = 0;
  int maxDataLoadingCount = 0;
  int maxDataLoadingCountLimit = 4;
  bool isReachMaxData = false;
  bool isDispose = false;

  RequestPathHolder? cachePathHolder;
  PsHolder<dynamic>? cacheBodyHolder;
  DataConfiguration? cacheDataConfig;

  bool get hasData {
    if (subscriptionType == PsConst.LIST_OBJECT_SUBSCRIPTION) {
      return dataList.data != null && dataList.data!.isNotEmpty;
    } else if (subscriptionType == PsConst.SINGLE_OBJECT_SUBSCRIPTION) {
      return data.data != null;
    } else {
      return false;
    }
  }

  PsStatus get currentStatus {
    if (subscriptionType == PsConst.LIST_OBJECT_SUBSCRIPTION) {
      return dataList.status;
    } else if (subscriptionType == PsConst.SINGLE_OBJECT_SUBSCRIPTION) {
      return data.status;
    } else {
      return PsStatus.NOACTION;
    }
  }

  int get dataLength {
    if (subscriptionType == PsConst.LIST_OBJECT_SUBSCRIPTION &&
        dataList.data != null &&
        dataList.data!.isNotEmpty) {
      return dataList.data!.length;
    } else {
      return 0;
    }
  }

  T getListIndexOf(int index) {
    if (subscriptionType == PsConst.LIST_OBJECT_SUBSCRIPTION &&
        dataList.data != null &&
        dataList.data!.isNotEmpty &&
        dataList.data!.length > index) {
      return dataList.data![index];
    } else {
      return T as T;
    }
  }

  void updateOffset(int? dataLength) {
    if (offset == 0) {
      isReachMaxData = false;
      maxDataLoadingCount = 0;
    }
    if (dataLength == _cacheDataLength) {
      maxDataLoadingCount++;
      if (maxDataLoadingCount == maxDataLoadingCountLimit) {
        isReachMaxData = true;
      }
    } else {
      maxDataLoadingCount = 0;
    }

    offset = dataLength;
    _cacheDataLength = dataLength;
  }

  void _startSubscription() {
    switch (subscriptionType) {
      case PsConst.SINGLE_OBJECT_SUBSCRIPTION:
        _singleObjectSubscription();
        break;
      case PsConst.LIST_OBJECT_SUBSCRIPTION:
        _listObjectSubScription();
        break;
      case PsConst.NO_SUBSCRIPTION:
        break;

      default:
    }
  }

  void _singleObjectSubscription() {
    dataStreamController = StreamController<PsResource<dynamic>>.broadcast();
    _dataStreamSubscription =
        dataStreamController?.stream.listen((PsResource<dynamic> resource) {
      data.message = resource.message;
      data.status = resource.status;
      data.errorCode = resource.errorCode;
      data.data = resource.data;

      if (resource.status != PsStatus.BLOCK_LOADING &&
          resource.status != PsStatus.PROGRESS_LOADING) {
        isLoading = false;
      }

      if (!isDispose) {
        notifyListeners();
      }
    });
  }

    Future<DataConfiguration> get getDefaultDataConfig async {
    return  Utils.getDataConfiguration();
  }

  void _listObjectSubScription() {
    dataListStreamController =
        StreamController<PsResource<List<dynamic>>>.broadcast();
    _dataListStreamSubscription = dataListStreamController?.stream
        .listen((PsResource<List<dynamic>> resource)async {
           final DataConfiguration defaultDataConfig = await getDefaultDataConfig;
      if ((cacheDataConfig == null &&
              defaultDataConfig.dataSourceType ==
                  DataSourceType.SERVER_DIRECT) ||
          (cacheDataConfig != null &&
              cacheDataConfig?.dataSourceType ==
                  DataSourceType.SERVER_DIRECT)) {
        updateOffset(offset! + resource.data!.length);
        dataList.status = resource.status;
        dataList.message = resource.message;
        dataList.errorCode = resource.errorCode;

        dataList.data?.addAll(List<T>.from(resource.data!));
      } else {
        updateOffset(resource.data!.length);
        dataList.status = resource.status;
        dataList.message = resource.message;
        dataList.errorCode = resource.errorCode;
        if (resource.data != null) {
          dataList.data = List<T>.from(resource.data!);
        } else {
          dataList.data = List<T>.from(<T>[]);
        }
      }

      if (resource.status != PsStatus.BLOCK_LOADING &&
          resource.status != PsStatus.PROGRESS_LOADING) {
        isLoading = false;
      }

      if (!isDispose) {
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _stopSubscription();
    if (_psRepository != null) {
      _psRepository?.dispose();
    }
    isDispose = true;
    Utils.printLog('${runtimeType.toString()} Dispose $hashCode',
        important: true);
    super.dispose();
  }

  void _stopSubscription() {
    if (_dataListStreamSubscription != null &&
        subscriptionType == PsConst.LIST_OBJECT_SUBSCRIPTION) {
      _dataListStreamSubscription?.cancel();
    }
    if (_dataStreamSubscription != null &&
        subscriptionType == PsConst.SINGLE_OBJECT_SUBSCRIPTION) {
      _dataStreamSubscription?.cancel();
    }
  }

  Future<void> loadData({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    DataConfiguration? dataConfig,
  }) async {
     final DataConfiguration defaultDataConfig = await getDefaultDataConfig;
    await _psRepository?.loadData(
      streamController: dataStreamController!,
      dataConfig: dataConfig ?? defaultDataConfig,
      requestBodyHolder: requestBodyHolder,
      requestPathHolder: requestPathHolder,
    );
  }

  Future<void> loadDataList({
    bool reset = false,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    DataConfiguration? dataConfig,
  }) async {
    if (!reset) {
      cacheBodyHolder = requestBodyHolder;
      cachePathHolder = requestPathHolder;
      cacheDataConfig = dataConfig;
    }
    if (reset) {
      Utils.printLog('🔄 Data Refresh in ($runtimeType) 🔄');
      updateOffset(0);
       final DataConfiguration defaultDataConfig = await getDefaultDataConfig;
      if ((cacheDataConfig != null &&
              cacheDataConfig?.dataSourceType ==
                  DataSourceType.SERVER_DIRECT) ||
          (cacheDataConfig == null &&
              defaultDataConfig.dataSourceType ==
                  DataSourceType.SERVER_DIRECT)) {
        dataList.data?.clear();
      }

      if (!isLoading && !isReachMaxData) {
        isLoading = true;
      }
    }
 final DataConfiguration defaultDataConfig = await getDefaultDataConfig;
    await _psRepository?.loadDataList(
      streamController: dataListStreamController!,
      limit: limit,
      offset: offset!,
      dataConfig: cacheDataConfig ?? dataConfig ?? defaultDataConfig,
      requestBodyHolder: requestBodyHolder ?? cacheBodyHolder,
      requestPathHolder: requestPathHolder ?? cachePathHolder,
    );
    notifyListeners();
  }

  Future<void> loadNextDataList({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    DataConfiguration? dataConfig,
  }) async {
    cacheDataConfig = dataConfig;
    notifyListeners();
     final DataConfiguration defaultDataConfig = await getDefaultDataConfig;
    await _psRepository?.loadNextDataList(
      streamController: dataListStreamController!,
      limit: limit,
      offset: offset!,
      dataConfig: cacheDataConfig ?? dataConfig ?? defaultDataConfig,
      requestPathHolder: requestPathHolder ?? cachePathHolder,
      requestBodyHolder: requestBodyHolder ?? cacheBodyHolder,
    );
  }

  Future<dynamic> loadDataListFromDatabase() async {
    await _psRepository?.loadDataListFromDatabase(
        streamController: dataListStreamController!);
  }

  Future<dynamic> addToDatabase(dynamic obj) async {
    await _psRepository?.insertToDatabase(
        streamController: dataListStreamController!, obj: obj);
  }

  Future<dynamic> deleteFromDatabase(dynamic obj) async {
    await _psRepository?.deleteFromDatabase(
        streamController: dataListStreamController!, obj: obj);
  }

  Future<dynamic> postData({
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    return await _psRepository?.postData(
      requestBodyHolder: requestBodyHolder,
      requestPathHolder: requestPathHolder,
    );
  }

  Future<void> loadValueHolder() async {
    await _psRepository!.loadValueHolder();
  }

    Future<void> replaceIsPickUpOnMap(bool isPickUpOnMap) async {
    await _psRepository!.replaceIsPickUpOnMap(isPickUpOnMap);
  }

  Future<void> replaceLoginUserId(String loginUserId) async {
    await _psRepository!.replaceLoginUserId(loginUserId);
  }

  Future<void> replaceCurrentLoginMethod(String loginMethod) async {
    await _psRepository!.replaceCurrentLoginMethod(loginMethod);
  }

  Future<void> replaceSetUserNameAttempCount(int count) async {
    await _psRepository!.replaceSetUserNameAttemptCount(count);
  }

  Future<void> replaceIsUserNameAndPwdNeeded(bool hasName, bool hasPwd) async {
    await _psRepository!.replaceIsUserNameAndPwdNeeded(hasName, hasPwd);
  }

  Future<void> replaceLoginUserName(String loginUserName) async {
    await _psRepository!.replaceLoginUserName(loginUserName);
  }

  Future<void> replaceNotiToken(String notiToken) async {
    await _psRepository!.replaceNotiToken(notiToken);
  }

  Future<void> replaceDeviceInfo(
      String phoneUniqueId, String phoneModelName, String headerToken) async {
    await _psRepository!
        .replaceDeviceInfo(phoneUniqueId, phoneModelName, headerToken);
  }

  Future<void> replaceUserInfo(String userEmail, String userPassword) async {
    await _psRepository!.replaceUserInfo(userEmail, userPassword);
  }

  Future<void> removeHeaderToken() async {
    await _psRepository!.removeHeaderToken();
  }

  Future<void> replaceIsSubLocation(String isSubLocation) async {
    await _psRepository!.replaceIsSubLocation(isSubLocation);
  }

  Future<void> replaceMaxImageCount(int maxImageCount) async {
    await _psRepository!.replaceMaxImageCount(maxImageCount);
  }

  Future<void> replaceMobileConfigSetting(
      PSMobileConfigSetting psMobileConfigSetting) async {
    limit = int.parse(psMobileConfigSetting.defaultLoadingLimit ?? '30');
    await _psRepository!.replaceMobileConfigSetting(psMobileConfigSetting);
  }

  Future<void> replaceIsBlockeFeatureDisabled(
      String isBlockedFeatueDisabled) async {
    await _psRepository!
        .replaceisBlockedFeatueDisabled(isBlockedFeatueDisabled);
  }

  Future<void> replaceIsPaidApp(String isPaidApp) async {
    await _psRepository!.replaceIsPaidApp(isPaidApp);
  }

  Future<void> replaceIsSubCatSubscribe(String isSubCatSubscribe) async {
    await _psRepository!.replaceIsSubCatSubscribe(isSubCatSubscribe);
  }

  Future<void> replacePackageIAPKeys(
      String packageAndroidKeyList, String packageIOSKeyList) async {
    await _psRepository!
        .replacePackageIAPKeys(packageAndroidKeyList, packageIOSKeyList);
  }

  Future<void> replaceUploadSetting(String uploadSetting) async {
    await _psRepository!
        .replaceUploadSetting(uploadSetting);
  }

  Future<void> replaceDefaultCurrency(
      String defaultCurrencyId, String defaultCurrency) async {
    await _psRepository!
        .replaceDefaultCurrency(defaultCurrencyId, defaultCurrency);
  }

  Future<void> replaceDefaultPhoneCountryCode(
      String defaulCountryCode, String defaultCountryName) async {
    await _psRepository!
        .replaceDefaultPhoneCountryCode(defaulCountryCode, defaultCountryName);
  }

    Future<void> replaceDefaultLatLng(
      String defaulLat, String defaultLng) async {
    await _psRepository!
        .replaceDefaultLatLng(defaulLat, defaultLng);
  }

  // Future<void> replaceItemUploadConfig(
  //     String address,
  //     String brand,
  //     String latitude,
  //     String longitude,
  //     String businessMode,
  //     String subCatId,
  //     String typeId,
  //     String priceTypeId,
  //     String conditionOfItemId,
  //     String dealOptionId,
  //     String dealOptionRemark,
  //     String highlightInfo,
  //     String video,
  //     String videoIcon,
  //     String discountRateByPercentage) async {
  //   await _psRepository!.replaceItemUploadConfig(
  //       address,
  //       brand,
  //       latitude,
  //       longitude,
  //       businessMode,
  //       subCatId,
  //       typeId,
  //       priceTypeId,
  //       conditionOfItemId,
  //       dealOptionId,
  //       dealOptionRemark,
  //       highlightInfo,
  //       video,
  //       videoIcon,
  //       discountRateByPercentage);
  // }

  Future<void> replaceNotiSetting(bool notiSetting) async {
    await _psRepository!.replaceNotiSetting(notiSetting);
  }

  Future<void> replaceItemLocationTownshipData(
      String locationTownshipId,
      String locationCityId,
      String locationTownshipName,
      String locationTownshipLat,
      String locationTownshipLng) async {
    await _psRepository!.replaceItemLocationTownshipData(
        locationTownshipId,
        locationCityId,
        locationTownshipName,
        locationTownshipLat,
        locationTownshipLng);
  }

  Future<void> replaceCustomCameraSetting(bool cameraSetting) async {
    await _psRepository!.replaceCustomCameraSetting(cameraSetting);
  }

  Future<void> replaceIsToShowIntroSlider(bool doNotShowAgain) async {
    await _psRepository!.replaceIsToShowIntroSlider(doNotShowAgain);
  }

  Future<void> replaceShowOnboardLanguage(bool doNotShowAgain) async {
    await _psRepository!.replaceShowOnboardLanguage(doNotShowAgain);
  }

  Future<void> replaceAgreeTermsAndConditions(bool value) async {
    await _psRepository!.replaceAgreeTermsAndConditions(value);
  }

  Future<void> replaceDate(String startDate, String endDate) async {
    await _psRepository!.replaceDate(startDate, endDate);
  }

  Future<void> replaceVerifyUserData(
      String userIdToVerify,
      String userNameToVerify,
      String userEmailToVerify,
      String userPasswordToVerify) async {
    await _psRepository!.replaceVerifyUserData(userIdToVerify, userNameToVerify,
        userEmailToVerify, userPasswordToVerify);
  }

  Future<void> replaceItemLocationData(String locationId, String locationName,
      String locationLat, String locationLng) async {
    await _psRepository!.replaceItemLocationData(
        locationId, locationName, locationLat, locationLng);
  }

  Future<void> replaceVersionForceUpdateData(bool appInfoForceUpdate) async {
    await _psRepository!.replaceVersionForceUpdateData(appInfoForceUpdate);
  }

  Future<void> replaceAppInfoData(
      String appInfoVersionNo,
      bool appInfoForceUpdate,
      String appInfoForceUpdateTitle,
      String appInfoForceUpdateMsg) async {
    await _psRepository!.replaceAppInfoData(appInfoVersionNo,
        appInfoForceUpdate, appInfoForceUpdateTitle, appInfoForceUpdateMsg);
  }

  Future<void> replaceShopInfoValueHolderData(
    String overAllTaxLabel,
    String overAllTaxValue,
    String shippingTaxLabel,
    String shippingTaxValue,
    String shippingId,
    String shopId,
    String messenger,
    String whatsApp,
    String phone,
  ) async {
    await _psRepository!.replaceShopInfoValueHolderData(
        overAllTaxLabel,
        overAllTaxValue,
        shippingTaxLabel,
        shippingTaxValue,
        shippingId,
        shopId,
        messenger,
        whatsApp,
        phone);
  }

  Future<void> replaceCheckoutEnable(
      String paypalEnabled,
      String stripeEnabled,
      String codEnabled,
      String bankEnabled,
      String standardShippingEnable,
      String zoneShippingEnable,
      String noShippingEnable) async {
    await _psRepository!.replaceCheckoutEnable(
        paypalEnabled,
        stripeEnabled,
        codEnabled,
        bankEnabled,
        standardShippingEnable,
        zoneShippingEnable,
        noShippingEnable);
  }

  Future<void> replacePublishKey(String pubKey) async {
    await _psRepository!.replacePublishKey(pubKey);
  }

  Future<void> replaceDetailOpenCount(int count) async {
    await _psRepository!.replaceDetailOpenCount(count);
  }

  bool get openDetailCountLimitExceeded {
    return _psRepository!.openDetailCountLimitExceeded;
  }

  Future<void> replaceShop(String shopId, String shopName) async {
    await _psRepository!.replaceShop(shopId, shopName);
  }

  Future<void> replaceAppleLoginUser(bool isAppleLoginUser) async {
    await _psRepository!.replaceAppleLoginUser(isAppleLoginUser);
  }


  Future<void> replaceSelectPriceType(String selectPriceType) async {
    await _psRepository!.replaceSelectPriceType(selectPriceType);
  }

    Future<void> replaceSelectChatType(String selectChatType) async {
    await _psRepository!.replaceSelectChatType(selectChatType);
  }
}
