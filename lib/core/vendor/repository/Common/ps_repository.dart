import 'dart:async';
import 'package:sembast/sembast.dart';

import '../../api/common/ps_resource.dart';
import '../../api/common/ps_status.dart';
import '../../db/common/ps_dao.dart';
import '../../db/common/ps_data_source_manager.dart';
import '../../db/common/ps_shared_preferences.dart';
import '../../viewobject/common/ps_holder.dart';
import '../../viewobject/common/ps_map_object.dart';
import '../../viewobject/holder/request_path_holder.dart';
import '../../viewobject/ps_mobile_config_setting.dart';

class PsRepository {
  dynamic dataListDaoSubscription;
  dynamic dataDaoSubscription;

  Future<void> loadDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {}

  Future<void> loadNextDataList({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {}

  Future<void> loadDataListFromDatabase({
    required StreamController<PsResource<List<dynamic>>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {}

  Future<void> insertToDatabase({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required dynamic obj,
  }) async {}

  Future<void> deleteFromDatabase({
    required StreamController<PsResource<List<dynamic>>> streamController,
    required dynamic obj,
  }) async {}

  Future<void> loadData({
    required StreamController<PsResource<dynamic>> streamController,
    PsHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {}

  Future<dynamic> postData({
    required PsHolder<dynamic>? requestBodyHolder,
    required RequestPathHolder? requestPathHolder,
  }) async {}

  void dispose() {
    if (dataListDaoSubscription != null) {
      print('DataList Subscription Cancelled');
      dataListDaoSubscription.cancel();
    }
    if (dataDaoSubscription != null) {
      dataDaoSubscription.cancel();
      print('DataSubscription Cancelled');
    }
  }

  Future<dynamic> subscribeDataList({
    required StreamController<PsResource<List<dynamic>>> dataListStream,
    required PsDao<dynamic> dao,
    required PsStatus statusOnDataChange,
    required DataConfiguration dataConfig,
  }) async {
    if (dataConfig.dataSourceType != DataSourceType.SERVER_DIRECT) {
      dataListDaoSubscription = await dao.getAllWithSubscription(
          status: PsStatus.SUCCESS,
          onDataUpdated: (List<dynamic>? resultList) {
            // print('***<< Data Updated >>*** ' + paramKey);
            if (statusOnDataChange != PsStatus.NOACTION) {
              print(statusOnDataChange);
              if (resultList != null) {
                dataListStream.sink.add(PsResource<List<dynamic>>(
                    statusOnDataChange, '', resultList));
              }
            } else {
              print('No Action');
            }
          });
    }
  }

  Future<dynamic> subscribeDataListWithMap({
    required StreamController<PsResource<List<dynamic>>> dataListStream,
    required String primaryKey,
    required String mapKey,
    required PsMapObject<dynamic, dynamic>? mapObject,
    required String paramKey,
    required PsDao<dynamic> dao,
    required PsStatus statusOnDataChange,
    required DataConfiguration dataConfig,
    required PsDao<PsMapObject<dynamic, dynamic>> mapDao,
  }) async {
    if (dataConfig.dataSourceType != DataSourceType.SERVER_DIRECT) {
      dataListDaoSubscription = await dao.getAllWithSubscriptionByMap(
          primaryKey: primaryKey,
          mapKey: mapKey,
          paramKey: paramKey,
          mapDao: mapDao,
          mapObj: mapObject,
          status: PsStatus.SUCCESS,
          onDataUpdated: (PsResource<List<dynamic>>? resultList) {
            // print('***<< Data Updated >>*** ' + paramKey);
            if (statusOnDataChange != PsStatus.NOACTION) {
              print(statusOnDataChange);
              if (resultList != null) {
                dataListStream.sink.add(PsResource<List<dynamic>>(
                    statusOnDataChange, '', resultList.data));
              }
            } else {
              print('No Action');
            }
          });
    }
  }

  Future<dynamic> subscribeDataListWithJoin({
    required StreamController<PsResource<List<dynamic>>> dataListStream,
    required String primaryKey,
    required String mapKey,
    required PsMapObject<dynamic, dynamic>? mapObject,
    required PsDao<dynamic> dao,
    required PsStatus statusOnDataChange,
    required DataConfiguration dataConfig,
    required PsDao<PsMapObject<dynamic, dynamic>> mapDao,
  }) async {
    if (dataConfig.dataSourceType != DataSourceType.SERVER_DIRECT) {
      dataListDaoSubscription = await dao.getAllWithSubscriptionByJoin(
          primaryKey: primaryKey,
          mapDao: mapDao,
          mapObj: mapObject,
          status: PsStatus.SUCCESS,
          onDataUpdated: (PsResource<List<dynamic>>? resultList) {
            if (statusOnDataChange != PsStatus.NOACTION) {
              print(statusOnDataChange);
              if (resultList != null) {
                dataListStream.sink.add(PsResource<List<dynamic>>(
                    statusOnDataChange, '', resultList.data));
              }
            } else {
              print('No Action');
            }
          });
    }
  }

  Future<dynamic> subscribeForOne({
    required StreamController<PsResource<dynamic>>? dataStream,
    required Finder finder,
    required PsDao<dynamic> dao,
    required PsStatus? status,
  }) async {
    dataDaoSubscription = await dao.getOneWithSubscription(
        status: PsStatus.SUCCESS,
        finder: finder,
        onDataUpdated: (dynamic obj) {
          if (status != null && status != PsStatus.NOACTION) {
            print(status);
            dataStream!.sink.add(PsResource<dynamic>(status, '', obj));
          } else {
            print('No Action');
          }
        });
  }

  Future<void> startResourceSinkingForOne(
      {required PsDao<dynamic> dao,
      Future<dynamic>? Function()? serverRequestCallback,
      required dynamic streamController,
      required DataConfiguration dataConfig,
      Finder? finder,
      List<SortOrder>? sortOrderList,
      PsStatus? loadingStatus}) async {
    final PsDataSourceManager dataSourceManager = PsDataSourceManager(
        dao: dao,
        dataConfig: dataConfig,
        serverRequestCallback: serverRequestCallback,
        finder: finder,
        sortOrderList: sortOrderList,
        loadingStatus: loadingStatus);
    dataSourceManager.manageForData(streamController);
  }

  Future<dynamic> startResourceSinkingForListWithJoin<
      T extends PsMapObject<dynamic, dynamic>>({
    required PsDao<dynamic> dao,
    Future<dynamic>? Function()? serverRequestCallback,
    Finder? finder,
    List<SortOrder>? sortOrderList,
    PsStatus? loadingStatus,
    required String primaryKey,
    required String mapKey,
    required PsMapObject<dynamic, dynamic> mapObject,
    required dynamic streamController,
    required PsDao<PsMapObject<dynamic, dynamic>> mapDao,
    required DataConfiguration dataConfig,
  }) async {
    final PsDataSourceManager dataSourceManager = PsDataSourceManager(
      dao: dao,
      dataConfig: dataConfig,
      serverRequestCallback: serverRequestCallback,
      finder: finder,
      sortOrderList: sortOrderList,
      loadingStatus: loadingStatus,
    );
    dataSourceManager.manageForDataListWithJoin<T>(
      mapDao: mapDao,
      isNextPage: false,
      mapKey: mapKey,
      mapObject: mapObject,
      primaryKey: primaryKey,
      streamController: streamController,
    );
  }

  Future<dynamic> startResourceSinkingForNextListWithJoin<
      T extends PsMapObject<dynamic, dynamic>>({
    required PsDao<dynamic> dao,
    Future<dynamic>? Function()? serverRequestCallback,
    required String primaryKey,
    Finder? finder,
    List<SortOrder>? sortOrderList,
    PsStatus? loadingStatus,
    required String mapKey,
    required PsMapObject<dynamic, dynamic> mapObject,
    required dynamic streamController,
    required PsDao<PsMapObject<dynamic, dynamic>> mapDao,
    required DataConfiguration dataConfig,
  }) async {
    final PsDataSourceManager dataSourceManager = PsDataSourceManager(
        dao: dao,
        dataConfig: dataConfig,
        serverRequestCallback: serverRequestCallback,
        finder: finder,
        sortOrderList: sortOrderList,
        loadingStatus: loadingStatus);
    dataSourceManager.manageForDataListWithJoin<T>(
      mapDao: mapDao,
      mapKey: mapKey,
      isNextPage: true,
      mapObject: mapObject,
      primaryKey: primaryKey,
      streamController: streamController,
    );
  }

  Future<void> startResourceSinkingForListWithMap<
      T extends PsMapObject<dynamic, dynamic>>({
    required PsDao<dynamic> dao,
    Future<dynamic>? Function()? serverRequestCallback,
    required String primaryKey,
    Finder? finder,
    List<SortOrder>? sortOrderList,
    PsStatus? loadingStatus,
    required String mapKey,
    required String paramKey,
    required PsMapObject<dynamic, dynamic> mapObject,
    required dynamic streamController,
    required PsDao<PsMapObject<dynamic, dynamic>> mapDao,
    required DataConfiguration dataConfig,
  }) async {
    final PsDataSourceManager dataSourceManager = PsDataSourceManager(
        dao: dao,
        dataConfig: dataConfig,
        serverRequestCallback: serverRequestCallback,
        finder: finder,
        sortOrderList: sortOrderList,
        loadingStatus: loadingStatus);
    dataSourceManager.manageForDataListWithMap<T>(
      mapDao: mapDao,
      mapKey: mapKey,
      isNextPage: false,
      mapObject: mapObject,
      paramKey: paramKey,
      primaryKey: primaryKey,
      streamController: streamController,
    );
  }

  Future<void> startResourceSinkingForNextListWithMap<
      T extends PsMapObject<dynamic, dynamic>>({
    required PsDao<dynamic> dao,
    Future<dynamic>? Function()? serverRequestCallback,
    required String primaryKey,
    required String mapKey,
    Finder? finder,
    List<SortOrder>? sortOrderList,
    PsStatus? loadingStatus,
    required String paramKey,
    required PsMapObject<dynamic, dynamic> mapObject,
    required dynamic streamController,
    required PsDao<PsMapObject<dynamic, dynamic>> mapDao,
    required DataConfiguration dataConfig,
  }) async {
    final PsDataSourceManager dataSourceManager = PsDataSourceManager(
        dao: dao,
        dataConfig: dataConfig,
        serverRequestCallback: serverRequestCallback,
        finder: finder,
        sortOrderList: sortOrderList,
        loadingStatus: loadingStatus);
    dataSourceManager.manageForDataListWithMap<T>(
      mapDao: mapDao,
      mapKey: mapKey,
      isNextPage: true,
      mapObject: mapObject,
      paramKey: paramKey,
      primaryKey: primaryKey,
      streamController: streamController,
    );
  }

  ///
  /// Get dataList base on [DataConfiguration] , then add dataList to the stream
  ///
  Future<void> startResourceSinkingForList({
    required PsDao<dynamic> dao,
    Finder? finder,
    List<SortOrder>? sortOrderList,
    Future<dynamic>? Function()? serverRequestCallback,
    PsStatus? loadingStatus,
    required dynamic streamController,
    required DataConfiguration dataConfig,
  }) async {
    final PsDataSourceManager dataSourceManager = PsDataSourceManager(
      dao: dao,
      dataConfig: dataConfig,
      sortOrderList: sortOrderList,
      serverRequestCallback: serverRequestCallback,
      finder: finder,
      loadingStatus: loadingStatus,
    );
    dataSourceManager.manageForDataList(
      streamController: streamController,
      isNextPage: false,
    );
  }

  ///
  /// Get dataList base on [DataConfiguration] , then add dataList to the stream
  ///
  Future<void> startResourceSinkingForNextList({
    required PsDao<dynamic> dao,
    Future<dynamic>? Function()? serverRequestCallback,
    required dynamic streamController,
    List<SortOrder>? sortOrderList,
    PsStatus? loadingStatus,
    required DataConfiguration dataConfig,
    Finder? finder,
  }) async {
    final PsDataSourceManager dataSourceManager = PsDataSourceManager(
      dao: dao,
      dataConfig: dataConfig,
      serverRequestCallback: serverRequestCallback,
      finder: finder,
      sortOrderList: sortOrderList,
      loadingStatus: loadingStatus,
    );
    dataSourceManager.manageForDataList(
      streamController: streamController,
      isNextPage: true,
    );
  }

  ///
  /// Get dataList from [database], then add dataList to stream
  ///
  Future<void> startResourceSinkingForListFromDataBase({
    required PsDao<dynamic> dao,
    Finder? finder,
    List<SortOrder>? sortOrderList,
    required StreamController<PsResource<List<dynamic>>> streamController,
  }) async {
    final PsResource<List<dynamic>> dbResource = await dao.getAll(
        finder: finder ?? Finder(),
        sortOrderList: sortOrderList,
        status: PsStatus.PROGRESS_LOADING);
    streamController.sink.add(dbResource);
  }

  ///
  /// Get single Object from database and then add data to stream
  ///
  Future<void> startResourceSinkingForOneFromDataBase({
    required PsDao<dynamic> dao,
    Finder? finder,
    List<SortOrder>? sortOrderList,
    required StreamController<PsResource<dynamic>> streamController,
  }) async {
    final PsResource<dynamic> dbResource = await dao.getOne(
      finder: finder ?? Finder(),
      status: PsStatus.PROGRESS_LOADING,
    );
    streamController.sink.add(dbResource);
  }

  Future<dynamic> loadValueHolder() async {
    PsSharedPreferences.instance.loadValueHolder();
  }

      Future<void> replaceIsPickUpOnMap(bool isPickUpOnMap) async {
    await PsSharedPreferences.instance.replaceIsPickUpOnMap(isPickUpOnMap);
  }


  Future<dynamic> replaceLoginUserId(String loginUserId) async {
    await PsSharedPreferences.instance.replaceLoginUserId(
      loginUserId,
    );
  }

  Future<dynamic> replaceCurrentLoginMethod(String loginMethod) async {
    await PsSharedPreferences.instance.replaceCurrentLoginMethod(
      loginMethod,
    );
  }

  Future<dynamic> replaceSetUserNameAttemptCount(int count) async {
    await PsSharedPreferences.instance.replaceSetUserNameAttemptCount(
      count,
    );
  }

  Future<dynamic> replaceIsUserNameAndPwdNeeded(bool hasName, bool hasPwd) async {
    await PsSharedPreferences.instance.replaceIsUserNameAndPwdNeeded(
      hasName, hasPwd
    );
  }

  Future<dynamic> replaceLoginUserName(String loginUserName) async {
    await PsSharedPreferences.instance.replaceLoginUserName(
      loginUserName,
    );
  }

  Future<dynamic> replaceNotiToken(String notiToken) async {
    await PsSharedPreferences.instance.replaceNotiToken(
      notiToken,
    );
  }

  Future<dynamic> replaceDeviceInfo(
      String phoneUniqueId, String phoneModelName, String headerToken) async {
    await PsSharedPreferences.instance
        .replaceDeviceInfo(phoneUniqueId, phoneModelName, headerToken);
  }

  Future<dynamic> replaceUserInfo(
      String userEmail, String userPassword) async {
    await PsSharedPreferences.instance.replaceUserInfo(userEmail, userPassword);
  }

  Future<dynamic> removeHeaderToken() async {
    await PsSharedPreferences.instance.removeHeaderToken();
  }

  Future<dynamic> replaceIsSubLocation(String isSubLocation) async {
    await PsSharedPreferences.instance.replaceIsSubLocation(
      isSubLocation,
    );
  }

  Future<dynamic> replaceMaxImageCount(int isSubLocation) async {
    await PsSharedPreferences.instance.replaceMaxImageCount(
      isSubLocation,
    );
  }

  Future<dynamic> replaceMobileConfigSetting(
      PSMobileConfigSetting psMobileConfigSetting) async {
    await PsSharedPreferences.instance
        .replaceMobileConfigSetting(psMobileConfigSetting);
  }

  Future<dynamic> replaceisBlockedFeatueDisabled(
      String isBlockedFeatueDisabled) async {
    await PsSharedPreferences.instance.replaceisBlockedFeatueDisabled(
      isBlockedFeatueDisabled,
    );
  }

  Future<dynamic> replaceIsPaidApp(String isPaidApp) async {
    await PsSharedPreferences.instance.replaceIsPaindApp(
      isPaidApp,
    );
  }

  Future<dynamic> replaceIsSubCatSubscribe(String isSubCatSubscribe) async {
    await PsSharedPreferences.instance.replaceIsSubCatSubscribe(
      isSubCatSubscribe,
    );
  }

  Future<dynamic> replacePackageIAPKeys(
      String packageAndroidKeyList, String packageIOSKeyList) async {
    await PsSharedPreferences.instance
        .replacePackageIAPKeys(packageAndroidKeyList, packageIOSKeyList);
  }

  Future<void> replaceUploadSetting(String uploadSetting) async {
    await PsSharedPreferences.instance
        .replaceUploadSetting(uploadSetting);
  }


  Future<dynamic> replaceDefaultCurrency(
      String defaultCurrencyId, String defaultCurrency) async {
    await PsSharedPreferences.instance
        .replaceDefaultCurrency(defaultCurrencyId, defaultCurrency);
  }

  Future<dynamic> replaceDefaultPhoneCountryCode(
      String defaulCountryCode, String defaultCountryName) async {
    await PsSharedPreferences.instance
        .replaceDefaultPhoneCountryCode(defaulCountryCode, defaultCountryName);
  }

    Future<void> replaceDefaultLatLng(
      String defaulLat, String defaultLng) async {
    await PsSharedPreferences.instance
        .replaceDefaultLatLng(defaulLat, defaultLng);
  }

  // Future<dynamic> replaceItemUploadConfig(
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
  //   await PsSharedPreferences.instance.replaceItemUploadConfig(
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

  Future<dynamic> replaceNotiSetting(bool notiSetting) async {
    await PsSharedPreferences.instance.replaceNotiSetting(
      notiSetting,
    );
  }

  Future<dynamic> replaceItemLocationTownshipData(
      String locationTownshipId,
      String locationCityId,
      String locationTownshipName,
      String locationTownshipLat,
      String locationTownshipLng) async {
    await PsSharedPreferences.instance.replaceItemLocationTownshipData(
        locationTownshipId,
        locationCityId,
        locationTownshipName,
        locationTownshipLat,
        locationTownshipLng);
  }

  Future<dynamic> replaceCustomCameraSetting(bool cameraSetting) async {
    await PsSharedPreferences.instance.replaceCustomCameraSetting(
      cameraSetting,
    );
  }

  Future<dynamic> replaceIsToShowIntroSlider(bool doNotShowAgain) async {
    await PsSharedPreferences.instance.replaceIsToShowIntroSlider(
      doNotShowAgain,
    );
  }

  Future<dynamic> replaceShowOnboardLanguage(bool showOrNot) async {
    await PsSharedPreferences.instance.replaceShowOnboardLanguage(
      showOrNot,
    );
  }

  Future<dynamic> replaceAgreeTermsAndConditions(bool doNotShowAgain) async {
    await PsSharedPreferences.instance.replaceAgreeTermsAndConditions(
      doNotShowAgain,
    );
  }

  Future<dynamic> replaceDate(String startDate, String endDate) async {
    await PsSharedPreferences.instance.replaceDate(startDate, endDate);
  }

  Future<dynamic> replaceVerifyUserData(
      String userIdToVerify,
      String userNameToVerify,
      String userEmailToVerify,
      String userPasswordToVerify) async {
    await PsSharedPreferences.instance.replaceVerifyUserData(userIdToVerify,
        userNameToVerify, userEmailToVerify, userPasswordToVerify);
  }

  Future<dynamic> replaceItemLocationData(String locationId,
      String locationName, String locationLat, String locationLng) async {
    await PsSharedPreferences.instance.replaceItemLocationData(
        locationId, locationName, locationLat, locationLng);
  }

  Future<dynamic> replaceVersionForceUpdateData(bool appInfoForceUpdate) async {
    await PsSharedPreferences.instance.replaceVersionForceUpdateData(
      appInfoForceUpdate,
    );
  }

  Future<dynamic> replaceAppInfoData(
      String appInfoVersionNo,
      bool appInfoForceUpdate,
      String appInfoForceUpdateTitle,
      String appInfoForceUpdateMsg) async {
    await PsSharedPreferences.instance.replaceAppInfoData(appInfoVersionNo,
        appInfoForceUpdate, appInfoForceUpdateTitle, appInfoForceUpdateMsg);
  }

  Future<dynamic> replaceShopInfoValueHolderData(
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
    await PsSharedPreferences.instance.replaceShopInfoValueHolderData(
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

  Future<dynamic> replaceCheckoutEnable(
      String paypalEnabled,
      String stripeEnabled,
      String codEnabled,
      String bankEnabled,
      String standardShippingEnable,
      String zoneShippingEnable,
      String noShippingEnable) async {
    await PsSharedPreferences.instance.replaceCheckoutEnable(
        paypalEnabled,
        stripeEnabled,
        codEnabled,
        bankEnabled,
        standardShippingEnable,
        zoneShippingEnable,
        noShippingEnable);
  }

  Future<dynamic> replacePublishKey(String pubKey) async {
    await PsSharedPreferences.instance.replacePublishKey(pubKey);
  }

  Future<dynamic> replaceDetailOpenCount(int count) async {
    await PsSharedPreferences.instance.replaceDetailOpenCount(count);
  }

  bool get openDetailCountLimitExceeded {
    return PsSharedPreferences.instance.openDetailCountLimitExceeded;
  }

  Future<dynamic> replaceShop(String shopId, String shopName) async {
    await PsSharedPreferences.instance.replaceShop(shopId, shopName);
  }

  Future<dynamic> replaceAppleLoginUser(bool isAppleLoginUserName) async {
    await PsSharedPreferences.instance.replaceAppleLoginUser(isAppleLoginUserName);
  }

    Future<dynamic> replaceSelectPriceType(String selectPriceType) async {
    await PsSharedPreferences.instance.replaceSelectPriceType(selectPriceType);
  }

    Future<dynamic> replaceSelectChatType(String selectChatType) async {
    await PsSharedPreferences.instance.replaceSelectChatType(selectChatType);
  }
}