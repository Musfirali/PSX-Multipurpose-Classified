import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/ps_constants.dart';
import '../../utils/utils.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/ps_mobile_config_setting.dart';

class PsSharedPreferences {
  PsSharedPreferences._() {
    Utils.psPrint('init PsSharePerference $hashCode');
    futureShared = SharedPreferences.getInstance();
    futureShared.then((SharedPreferences shared) {
      this.shared = shared;
      loadValueHolder();
    });
  }

  late Future<SharedPreferences> futureShared;
  late SharedPreferences shared;

  // Singleton instance
  static final PsSharedPreferences _singleton = PsSharedPreferences._();

  // Singleton accessor
  static PsSharedPreferences get instance => _singleton;

  final StreamController<PsValueHolder> _valueController =
      StreamController<PsValueHolder>();
  Stream<PsValueHolder> get psValueHolder => _valueController.stream;

  void loadValueHolder() {
    final String? _loginUserId =
        shared.getString(PsConst.VALUE_HOLDER__USER_ID);

    final String? _loginUserName =
        shared.getString(PsConst.VALUE_HOLDER__USER_NAME);
    final String? _userIdToVerify =
        shared.getString(PsConst.VALUE_HOLDER__USER_ID_TO_VERIFY);
    final String? _userNameToVerify =
        shared.getString(PsConst.VALUE_HOLDER__USER_NAME_TO_VERIFY);
    final String? _userEmailToVerify =
        shared.getString(PsConst.VALUE_HOLDER__USER_EMAIL_TO_VERIFY);
    final String? _userPasswordToVerify =
        shared.getString(PsConst.VALUE_HOLDER__USER_PASSWORD_TO_VERIFY);
    final String? _notiToken =
        shared.getString(PsConst.VALUE_HOLDER__NOTI_TOKEN);
    final String _phoneId =
        shared.getString(PsConst.VALUE_HOLDER__PHONE_ID) ?? '';
    final String _phoneModelName =
        shared.getString(PsConst.VALUE_HOLDER__PHONE_MODEL_NAME) ?? '';
    final String _headerToken =
        shared.getString(PsConst.VALUE_HOLDER__HEADER_TOKEN) ?? '';
    final String _userEmail =
        shared.getString(PsConst.VALUE_HOLDER__USER_EMAIL) ?? '';
    final String _userPassword =
        shared.getString(PsConst.VALUE_HOLDER__USER_PASSWORD) ?? '';
    final String _isSubLocation =
        shared.getString(PsConst.VALUE_HOLDER__IS_SUB_LOCATION) ?? '';
    final int _maxImageCount =
        shared.getInt(PsConst.VALUE_HOLDER__MAX_IMAGE_COUNT) ?? 1;
    final String _defaultCurrency =
        shared.getString(PsConst.VALUE_HOLDER__DEFAULT_CURRENCY) ?? '';
    final String _defaultCurrencyId =
        shared.getString(PsConst.VALUE_HOLDER__DEFAULT_CURRENCY_ID) ?? '';
    final String _defaultPhoneCountryCode =
        shared.getString(PsConst.VALUE_HOLDER__DEFAULT_PHONE_COUNTRY_CODE) ??
            '';
    final String _defaultPhoneCountryName =
        shared.getString(PsConst.VALUE_HOLDER__DEFAULT_PHONE_COUNTRY_NAME) ??
            '';
    final bool? _notiSetting =
        shared.getBool(PsConst.VALUE_HOLDER__NOTI_SETTING);
    final bool _cameraSetting =
        shared.getBool(PsConst.VALUE_HOLDER__CAMERA_SETTING) ?? true;
    final bool _isToShowIntroSlider =
        shared.getBool(PsConst.VALUE_HOLDER__SHOW_INTRO_SLIDER) ?? true;
    final bool _showOnboardLanguage =
        shared.getBool(PsConst.VALUE_HOLDER__SHOW_ONBOARD_LANGUAGE) ?? true;
    final bool _isAggreTermsAndConditions =
        shared.getBool(PsConst.VALUE_HOLDER__TERMS_AND_CONDITIONS) ?? false;
    final String? _overAllTaxLabel =
        shared.getString(PsConst.VALUE_HOLDER__OVERALL_TAX_LABEL);
    final String? _overAllTaxValue =
        shared.getString(PsConst.VALUE_HOLDER__OVERALL_TAX_VALUE);
    final String? _shippingTaxLabel =
        shared.getString(PsConst.VALUE_HOLDER__SHIPPING_TAX_LABEL);
    final String? _shippingTaxValue =
        shared.getString(PsConst.VALUE_HOLDER__SHIPPING_TAX_VALUE);
    final String? _shippingId =
        shared.getString(PsConst.VALUE_HOLDER__SHIPPING_ID);
    final String? _shopId = shared.getString(PsConst.VALUE_HOLDER__SHOP_ID);
    final String? _messenger =
        shared.getString(PsConst.VALUE_HOLDER__MESSENGER);
    final String? _whatsApp = shared.getString(PsConst.VALUE_HOLDER__WHATSAPP);
    final String? _phone = shared.getString(PsConst.VALUE_HOLDER__PHONE);
    final String? _appInfoVersionNo =
        shared.getString(PsConst.APPINFO_PREF_VERSION_NO);
    final bool? _appInfoForceUpdate =
        shared.getBool(PsConst.APPINFO_PREF_FORCE_UPDATE);
    final String? _appInfoForceUpdateTitle =
        shared.getString(PsConst.APPINFO_FORCE_UPDATE_TITLE);
    final String? _appInfoForceUpdateMsg =
        shared.getString(PsConst.APPINFO_FORCE_UPDATE_MSG);
    final String? _startDate =
        shared.getString(PsConst.VALUE_HOLDER__START_DATE);
    final String? _endDate = shared.getString(PsConst.VALUE_HOLDER__END_DATE);

    final String? _paypalEnabled =
        shared.getString(PsConst.VALUE_HOLDER__PAYPAL_ENABLED);
    final String? _stripeEnabled =
        shared.getString(PsConst.VALUE_HOLDER__STRIPE_ENABLED);
    final String? _codEnabled =
        shared.getString(PsConst.VALUE_HOLDER__COD_ENABLED);
    final String? _bankEnabled =
        shared.getString(PsConst.VALUE_HOLDER__BANK_TRANSFER_ENABLE);
    final String? _publishKey =
        shared.getString(PsConst.VALUE_HOLDER__PUBLISH_KEY);

    final String? _standardShippingEnable =
        shared.getString(PsConst.VALUE_HOLDER__STANDART_SHIPPING_ENABLE);
    final String? _zoneShippingEnable =
        shared.getString(PsConst.VALUE_HOLDER__ZONE_SHIPPING_ENABLE);
    final String? _noShippingEnable =
        shared.getString(PsConst.VALUE_HOLDER__NO_SHIPPING_ENABLE);
    final String _locationTownshipId =
        shared.getString(PsConst.VALUE_HOLDER__LOCATION_TOWNSHIP_ID) ?? '';
    final String _locationTownshipName =
        shared.getString(PsConst.VALUE_HOLDER__LOCATION_TOWNSHIP_NAME) ?? '';
    final String _locationTownshipLat =
        shared.getString(PsConst.VALUE_HOLDER__LOCATION_TOWNSHIP_LAT) ?? '0';
    final String _locationTownshipLng =
        shared.getString(PsConst.VALUE_HOLDER__LOCATION_TOWNSHIP_LNG) ?? '0';
    final String? _locationId =
        shared.getString(PsConst.VALUE_HOLDER__LOCATION_ID);
    final String? _locationName =
        shared.getString(PsConst.VALUE_HOLDER__LOCATION_NAME);
    final String? _locationLat =
        shared.getString(PsConst.VALUE_HOLDER__LOCATION_LAT);
    final String? _locationLng =
        shared.getString(PsConst.VALUE_HOLDER__LOCATION_LNG);
    final String? _defaultlocationLat =
        shared.getString(PsConst.VALUE_HOLDER__DEFAULT_LOCATION_LAT);
    final String? _defaultlocationLng =
        shared.getString(PsConst.VALUE_HOLDER__DEFAULT_LOCATION_LNG);
    final int? _detailOpenCount =
        shared.getInt(PsConst.VALUE_HOLDER__DETAIL_OPEN_COUNTER);

    final String _isBlockedFeatureDisabled =
        shared.getString(PsConst.VALUE_HOLDER__BLOCK_FEATURE) ?? '';

    final String _isPaidApp =
        shared.getString(PsConst.VALUE_HOLDER__PAID_APP) ?? '';

    final String _isSubCatSubscribe =
        shared.getString(PsConst.VALUE_HOLDER__ISSUBCAT_SUBSCRIBE) ?? '';

    final String? _packageAndroidKeyList =
        shared.getString(PsConst.VALUE_HOLDER__PACKAGE_ANDROID_IAP);
    final String? _packageIOSKeyList =
        shared.getString(PsConst.VALUE_HOLDER__PACKAGE_IOS_IAP);

    final String? _uploadSetting = 
        shared.getString(PsConst.VAlUE_HOLDER__UPLOAD_SETTING) ?? PsConst.UPLOAD_SETTING_ALL;    

    final String? _selectPriceType = 
        shared.getString(PsConst.VAlUE_HOLDER__PRICE_TYPE) ?? PsConst.VAlUE_HOLDER__PRICE_TYPE;  

    final String? _selectChatType = 
        shared.getString(PsConst.VAlUE_HOLDER__CHAT_TYPE) ?? PsConst.VAlUE_HOLDER__CHAT_TYPE;  

    ///Mobile Config
    final String _googlePlayStoreUrl =
        shared.getString(PsConst.GOOGLEPLAYSTOREURL) ?? '';
    final String _appleAppStoreUrl =
        shared.getString(PsConst.APPLEAPPSTOREURL) ?? '';
    final String _priceFormat =
        shared.getString(PsConst.PRICEFORMAT) ?? ',##0.00';
    final String _dateFormat =
        shared.getString(PsConst.DATEFORMAT) ?? 'dd MMM yyyy';
    final String _iosAppStoreId = shared.getString(PsConst.IOSAPPSTOREID) ?? '';
    final bool _isUseThumnailAsPlaceHolder =
        shared.getBool(PsConst.ISUSETHUMBNAILASPLACEHOLDER) ?? false;
    final bool _isShowSubCategory =
        shared.getBool(PsConst.ISSHOWSUBCATEGORY) ?? false;
    final bool _isShowDiscount =
        shared.getBool(PsConst.VALUE_HOLDER__DISCOUNT_RATEBY_PERCENTAGE) ??
            false;
    final String _fbKey = shared.getString(PsConst.FBKEY) ?? '';
    final bool _isShowAdmob = shared.getBool(PsConst.ISSHOWADMOB) ?? false;
    final int _defaultLoadingLimit =
        shared.getInt(PsConst.DEFATULTLOADINGLIMIT) ?? 30;
    final int _categoryLoadingLimit =
        shared.getInt(PsConst.CATEGORYLOADINGLIMIT) ?? 30;
    final int _recentLodingLimit =
        shared.getInt(PsConst.RECENTLOADINGLIMIT) ?? 30;
    final int _popularLoadingLimit =
        shared.getInt(PsConst.POPULARLOADINGLIMIT) ?? 30;
    final int _discountLoadingLimit =
        shared.getInt(PsConst.DISCOUNTLOADINGLIMIT) ?? 30;
    final int _featuredLoadingLimit =
        shared.getInt(PsConst.FEATUREDLOADINGLIMIT) ?? 30;
    final int _blockSliderLoadingLimit =
        shared.getInt(PsConst.BLOCKSLIDERLOADINGLIMIT) ?? 30;
    final int _followerLoadingLimit =
        shared.getInt(PsConst.FOLLOWERLOADINGLIMIT) ?? 30;
    final int _blockItemLoadingLimit =
        shared.getInt(PsConst.BLOCKITEMLOADINGLIMIT) ?? 30;
    final bool _showFacebookLogin =
        shared.getBool(PsConst.SHOWFACEBOOKLOGIN) ?? false;
    final bool _showGoogleLogin =
        shared.getBool(PsConst.SHOWGOOGLELOGIN) ?? false;
    final bool _showItemVideo = shared.getBool(PsConst.SHOWITEMVIDEO) ?? false;
    final bool _showPhoneLogin =
        shared.getBool(PsConst.SHOWPHONELOGIN) ?? false;
    final bool _isRazorSupportMultiCurrency =
        shared.getBool(PsConst.ISRAZORSUPPORTMULTIICURRENCY) ?? false;
    final String _defaultRazorCurrency =
        shared.getString(PsConst.DEFAULTRAZORCURRENCY) ?? 'INR';
    final int _itemDetailViewCountforAds =
        shared.getInt(PsConst.ITEMDETAILVIEWCOUNTFORADS) ?? 5;
    final bool _isShowAdsInItemDetail =
        shared.getBool(PsConst.ISSHOWADSINITEMDETAIL) ?? false;
    final double _bluemarkSize = shared.getDouble(PsConst.BLUEMARKSIZE) ?? 15.0;
    final String _mile = shared.getString(PsConst.MILE) ?? '8';
    final String _videoDuration =
        shared.getString(PsConst.VIDEODURATION) ?? '60000';
    final bool _isUseGoogleMap =
        shared.getBool(PsConst.ISUSEGOOGLEMAP) ?? false;
    final int _profileImageSize =
        shared.getInt(PsConst.PROFILEIMAGESIZE) ?? 512;
    final int _uploadImageSize = shared.getInt(PsConst.UPLOADIMAGESIZE) ?? 1024;
    final int _chatImageSize = shared.getInt(PsConst.CHATIMAGESIZE) ?? 650;
    final String _promoteFirstChoiceDay =
        shared.getString(PsConst.PROMOTEFIRSTCHOICEDAY) ?? '7';
    final String _promoteSecondChoiceDay =
        shared.getString(PsConst.PROMOTESECONDCHOICEDAY) ?? '14';
    final String _promoteThirdChoiceDay =
        shared.getString(PsConst.PROMOTETHIRDCHOICEDAY) ?? '30';
    final String _promoteFourthChoiceDay =
        shared.getString(PsConst.PROMOTEFOURTHCHOICEDAY) ?? '60';
    final bool _nofilterWithLocationOnMap =
        shared.getBool(PsConst.NOFILTERWITHLOCATIONONMAP) ?? false;
    final bool _isShowOwnerInfo =
        shared.getBool(PsConst.ISSHOWOWNERINFO) ?? false;
    final String _defaultLanguageCode =
        shared.getString(PsConst.DEFAULTLANGUAGE) ?? 'en';
    final bool _isForceLogin = shared.getBool(PsConst.ISFORCELOGIN) ?? false;
    final bool _isLanguageConfig =
        shared.getBool(PsConst.ISLANGUAGECONFIG) ?? false;

    // final String? _collectionProductLoadingLimit =
    //     shared.getString(PsConst.VALUE_HOLDER__COLLECTION_PRODUCT_LOADING_LIMIT) ??
    //         '30';
    // final String? _shopLoadingLimit =
    //     shared.getString(PsConst.VALUE_HOLDER__SHOP_LOADING_LIMIT) ?? '30';
    final bool? _showMainMenu =
        shared.getBool(PsConst.VALUE_HOLDER__SHOW_MAIN_MENU) ?? false;
    final bool? _showSpecialCollections =
        shared.getBool(PsConst.VALUE_HOLDER__SHOW_SPECIAL_COLLECTIONS) ?? false;
    final bool? _showFeaturedItem =
        shared.getBool(PsConst.VALUE_HOLDER__SHOW_FEATURED_ITEM) ?? false;
    final bool? _showBestChoiceSlider =
        shared.getBool(PsConst.VALUE_HOLDER__SHOW_BEST_CHOICE_SLIDER) ?? false;
    final String? _defaultflutterWaveCurrency =
        shared.getString(PsConst.VALUE_HOLDER__DEFAULT_FLUTTER_WAVE_CURRENCY) ??
            'USD';
    final String? _defaultOrderTime =
        shared.getString(PsConst.VALUE_HOLDER__DEFAULT_ORDER_TIME) ?? '20';
    final String? _colorChangeCode =
        shared.getString(PsConst.VALUE_HOLDER__COLOR_CHANGE_CODE) ??
            '1673602972546';

    final String? _androidAdmodBannerUnitID =
        shared.getString(PsConst.VALUE_HOLDER__ANDROID_ADMOD_BANNER_UNIT_ID) ??
            'ca-app-pub-0000000000000000~0000000000';
    final String? _androidAdmodNativeUnitID =
        shared.getString(PsConst.VALUE_HOLDER__ANDROID_ADMOD_NATIVE_UNIT_ID) ??
            'ca-app-pub-0000000000000000~0000000000';
    final String? _androidAdmodIntertitialUnitID = shared.getString(
            PsConst.VALUE_HOLDER__ANDROID_ADMOD_INTERSTITIALAd_UNIT_ID) ??
        'ca-app-pub-0000000000000000~0000000000';
    final String? _iosAdmodBannerUnitID =
        shared.getString(PsConst.VALUE_HOLDER__IOS_ADMOD_BANNER_UNIT_ID) ??
            'ca-app-pub-0000000000000000~0000000000';
    final String? _iosAdmodNativeUnitID =
        shared.getString(PsConst.VALUE_HOLDER__IOS_ADMOD_NATIVE_UNIT_ID) ??
            'ca-app-pub-0000000000000000~0000000000';
    final String? _iosAdmodIntertitialUnitID = shared.getString(
            PsConst.VALUE_HOLDER__IOS_ADMOD_INTERSTITIALAD_UNIT_ID) ??
        'ca-app-pub-0000000000000000~0000000000';
    final bool? _isDemoForPayment =
        shared.getBool(PsConst.VALUE_HOLDER__ID_DEMO_FOR_PAYMENT) ?? false;
    final int? _loadingShimmerItemCount =
        shared.getInt(PsConst.VALUE_HOLDER__LOADING_SHIMMER_ITEM_COUNT) ?? 0;
    final int? _recentSearchKeywordLimit =
        shared.getInt(PsConst.VALUE_HOLDER__RECENT_SEARCH_KEYWORD_LIMIT) ?? 2;
    final int? _phoneListCount =
        shared.getInt(PsConst.VALUE_HOLDER__PHONE_LIST_COUNT) ?? 0;
    final String? _dataConfigurationDataSourceType =
        shared.getString(PsConst.VALUE_HOLDER__DATA_SOURCE_TYPE) ?? '';
    final int? _dataConfigurationDay =
        shared.getInt(PsConst.VALUE_HOLDER__DATA_CONFIGURATION_DAY) ?? 0;
    final bool? _isSliderAutoPlay =
        shared.getBool(PsConst.VALUE_HOLDER__IS_SLIDER_AUTO_PLAY) ?? false;
    final int? _autoPlayInterval =
        shared.getInt(PsConst.VALUE_HOLDER__AUTO_PLAY_INTERVAL) ?? 3;
    final bool? _isPickUpOnMap =
        shared.getBool(PsConst.VALUE_HOLDER__IS_PICK_UP_ON_MAP) ?? false;
    final String? _languageCodeKey =
        shared.getString(PsConst.LANGUAGE__LANGUAGE_CODE_KEY) ?? 'en';
    final String? _currentLoginMethod = 
        shared.getString(PsConst.VALUEHOLDER_LOGIN_METHOD) ?? '';
    final int _setUserNameAttemptCount = 
        shared.getInt(PsConst.VALUEHOLDER_USER_NAME_ATTEMPT_COUNT) ?? 0; 
    final bool _isUseNameNeeded = 
        shared.getBool(PsConst.VALUEHOLDER_IS_USER_NAME_NEEDED) ?? false;   
    final bool _isPasswordNeeded = 
        shared.getBool(PsConst.VALUEHOLDER_IS_USER_NAME_NEEDED) ?? false;  
    final bool _isAppleLoginUser = 
        shared.getBool(PsConst.VALUEHOLDER__APPLE_LOGIN_USER) ?? false; 
    
    // final WidgetProviderDynamic? _profileDetailsWidgetList =
    //     Utils.psWidgetToProvider(shared.getStringList(
    //             PsConst.VALUE_HOLDER__PROFILE_DETAILS_WIDGET_SORT_LIST) ??
    //         <String>[]);
    final PsValueHolder _valueHolder = PsValueHolder(
        loginUserId: _loginUserId,
        loginUserName: _loginUserName,
        locationId: _locationId,
        locactionName: _locationName,
        locationLat: _locationLat,
        locationLng: _locationLng,
        defaultlocationLat: _defaultlocationLat,
        defaultlocationLng: _defaultlocationLng,
        locationTownshipId: _locationTownshipId,
        locationTownshipName: _locationTownshipName,
        locationTownshipLat: _locationTownshipLat,
        locationTownshipLng: _locationTownshipLng,
        userIdToVerify: _userIdToVerify,
        userNameToVerify: _userNameToVerify,
        userEmailToVerify: _userEmailToVerify,
        userPasswordToVerify: _userPasswordToVerify,
        deviceToken: _notiToken,
        deviceUniqueId: _phoneId,
        deviceModelName: _phoneModelName,
        headerToken: _headerToken,
        userEmail: _userEmail,
        userPassword: _userPassword,
        isSubLocation: _isSubLocation,
        maxImageCount: _maxImageCount,
        defaultCurrency: _defaultCurrency,
        defaultCurrencyId: _defaultCurrencyId,
        defaulPhoneCountryCode: _defaultPhoneCountryCode,
        defaulPhoneCountryName: _defaultPhoneCountryName,
        notiSetting: _notiSetting,
        isCustomCamera: _cameraSetting,
        isToShowIntroSlider: _isToShowIntroSlider,
        showOnboardLanguage: _showOnboardLanguage,
        isAggreTermsAndConditions: _isAggreTermsAndConditions,
        overAllTaxLabel: _overAllTaxLabel,
        overAllTaxValue: _overAllTaxValue,
        shippingTaxLabel: _shippingTaxLabel,
        shippingTaxValue: _shippingTaxValue,
        shopId: _shopId,
        messenger: _messenger,
        whatsApp: _whatsApp,
        phone: _phone,
        appInfoVersionNo: _appInfoVersionNo,
        appInfoForceUpdate: _appInfoForceUpdate,
        appInfoForceUpdateTitle: _appInfoForceUpdateTitle,
        appInfoForceUpdateMsg: _appInfoForceUpdateMsg,
        startDate: _startDate,
        endDate: _endDate,
        packageAndroidKeyList: _packageAndroidKeyList,
        packageIOSKeyList: _packageIOSKeyList,
        paypalEnabled: _paypalEnabled,
        stripeEnabled: _stripeEnabled,
        codEnabled: _codEnabled,
        bankEnabled: _bankEnabled,
        publishKey: _publishKey,
        shippingId: _shippingId,
        standardShippingEnable: _standardShippingEnable,
        zoneShippingEnable: _zoneShippingEnable,
        noShippingEnable: _noShippingEnable,
        detailOpenCount: _detailOpenCount,
        blockedFeatureDisabled: _isBlockedFeatureDisabled,
        isPaidApp: _isPaidApp,
        isSubCatSubscribe: _isSubCatSubscribe,
        googlePlayStoreUrl: _googlePlayStoreUrl,
        appleAppStoreUrl: _appleAppStoreUrl,
        priceFormat: _priceFormat,
        dateFormat: _dateFormat,
        iosAppStoreId: _iosAppStoreId,
        isUseThumbnailAsPlaceHolder: _isUseThumnailAsPlaceHolder,
        isShowSubcategory: _isShowSubCategory,
        fbKey: _fbKey,
        isShowAdmob: _isShowAdmob,
        defaultLoadingLimit: _defaultLoadingLimit,
        categoryLoadingLimit: _categoryLoadingLimit,
        recentItemLoadingLimit: _recentLodingLimit,
        populartItemLoadingLimit: _popularLoadingLimit,
        discountItemLoadingLimit: _discountLoadingLimit,
        featuredItemLoadingLimit: _featuredLoadingLimit,
        blockSliderLoadingLimit: _blockSliderLoadingLimit,
        followerItemLoadingLimit: _followerLoadingLimit,
        blockItemLoadingLimit: _blockItemLoadingLimit,
        showFacebookLogin: _showFacebookLogin,
        showGoogleLogin: _showGoogleLogin,
        showItemVideo: _showItemVideo,
        showPhoneLogin: _showPhoneLogin,
        isRazorSupportMultiCurrency: _isRazorSupportMultiCurrency,
        defaultRazorCurrency: _defaultRazorCurrency,
        itemDetailViewCountForAds: _itemDetailViewCountforAds,
        isShowAdsInItemDetail: _isShowAdsInItemDetail,
        bluemarkSize: _bluemarkSize,
        mile: _mile,
        videoDuration: _videoDuration,
        isUseGoogleMap: _isUseGoogleMap,
        profileImageSize: _profileImageSize,
        uploadImageSize: _uploadImageSize,
        chatImageSize: _chatImageSize,
        promoteFirstChoiceDay: _promoteFirstChoiceDay,
        promoteSecondChoiceDay: _promoteSecondChoiceDay,
        promoteThirdChoiceDay: _promoteThirdChoiceDay,
        promoteFourthChoiceDay: _promoteFourthChoiceDay,
        noFilterWithLocationOnMap: _nofilterWithLocationOnMap,
        isShowOwnerInfo: _isShowOwnerInfo,
        defaultLanguageCode: _defaultLanguageCode,
        isShowDiscount: _isShowDiscount,
        isForceLogin: _isForceLogin,
        isLanguageConfig: _isLanguageConfig,
        // collectionProductLoadingLimit: _collectionProductLoadingLimit,
        defaultFlutterWaveCurrency: _defaultflutterWaveCurrency,
        defaultOrderTime: _defaultOrderTime,
        colorChangeCode: _colorChangeCode,
        // shopLoadingLimit: _shopLoadingLimit,
        showBestChoiceSlider: _showBestChoiceSlider,
        showFeaturedItems: _showFeaturedItem,
        showMainMenu: _showMainMenu,
        showSpecialCollections: _showSpecialCollections,
        androidAdMobBannerAdUnitId: _androidAdmodBannerUnitID,
        androidAdMobNativeAdUnitId: _androidAdmodNativeUnitID,
        androidAdMobInterstitialAdUnitId: _androidAdmodIntertitialUnitID,
        iosAdMobBannerAdUnitId: _iosAdmodBannerUnitID,
        iosAdMobNativeAdUnitId: _iosAdmodNativeUnitID,
        iosAdMobInterstitialAdUnitId: _iosAdmodIntertitialUnitID,
        isDemoForPayment: _isDemoForPayment,
        loadingShimmerItemCount: _loadingShimmerItemCount,
        recentSearchKeywordLimit: _recentSearchKeywordLimit,
        phoneListCount: _phoneListCount,
        dataConfigurationDataSourceType: _dataConfigurationDataSourceType,
        dataConfigurationDay: _dataConfigurationDay,
        isSliderAutoPlay: _isSliderAutoPlay,
        autoPlayInterval: _autoPlayInterval,
        isPickUpOnMap: _isPickUpOnMap,
        languageCode: _languageCodeKey,
        currentLoginMethod: _currentLoginMethod,
        setUserNameAttemptCount: _setUserNameAttemptCount,
        isUserNameNeeded: _isUseNameNeeded,
        isPasswordNeeded: _isPasswordNeeded,
        isAppleLoginUser: _isAppleLoginUser,
        uploadSetting: _uploadSetting,
        selectPriceType: _selectPriceType,
        selectChatType: _selectChatType
        );

    _valueController.add(_valueHolder);
  }

  Future<dynamic> replaceIsPickUpOnMap(bool isPickUpOnMap) async {
    await shared.setBool(
        PsConst.VALUE_HOLDER__IS_PICK_UP_ON_MAP, isPickUpOnMap);

    loadValueHolder();
  }

  Future<dynamic> replaceLoginUserId(String loginUserId) async {
    await shared.setString(PsConst.VALUE_HOLDER__USER_ID, loginUserId);

    loadValueHolder();
  }

  Future<dynamic> replaceCurrentLoginMethod(String loginMethod) async {
    await shared.setString(PsConst.VALUEHOLDER_LOGIN_METHOD, loginMethod);

    loadValueHolder();
  }

  Future<dynamic> replaceSetUserNameAttemptCount(int count) async {
    await shared.setInt(PsConst.VALUEHOLDER_USER_NAME_ATTEMPT_COUNT, count);

    loadValueHolder();
  }

  Future<dynamic> replaceIsUserNameAndPwdNeeded(bool hasName, bool hasPwd) async {
    await shared.setBool(PsConst.VALUEHOLDER_IS_USER_NAME_NEEDED, hasName);
    await shared.setBool(PsConst.VALUEHOLDER_IS_PASSWORD_NEEDED, hasPwd);
    loadValueHolder();
  }

  Future<dynamic> replaceAddedUserId(String addedUserId) async {
    await shared.setString(PsConst.VALUE_HOLDER__ADDED_USER_ID, addedUserId);

    loadValueHolder();
  }

  Future<dynamic> replaceLoginUserName(String loginUserName) async {
    await shared.setString(PsConst.VALUE_HOLDER__USER_NAME, loginUserName);

    loadValueHolder();
  }

  Future<dynamic> replaceNotiToken(String notiToken) async {
    await shared.setString(PsConst.VALUE_HOLDER__NOTI_TOKEN, notiToken);

    loadValueHolder();
  }

  Future<dynamic> replaceDeviceInfo(
      String phoneId, String phoneModelName, String headerToken) async {
    await shared.setString(PsConst.VALUE_HOLDER__PHONE_ID, phoneId);
    await shared.setString(
        PsConst.VALUE_HOLDER__PHONE_MODEL_NAME, phoneModelName);
    await shared.setString(PsConst.VALUE_HOLDER__HEADER_TOKEN, headerToken);
    loadValueHolder();
  }

  Future<dynamic> replaceUserInfo(String userEmail, String userPassword) async {
    await shared.setString(PsConst.VALUE_HOLDER__USER_EMAIL, userEmail);
    await shared.setString(PsConst.VALUE_HOLDER__USER_PASSWORD, userPassword);
    loadValueHolder();
  }

  Future<dynamic> removeHeaderToken() async {
    await shared.setString(PsConst.VALUE_HOLDER__HEADER_TOKEN, '');
    loadValueHolder();
  }

  Future<dynamic> replaceIsSubLocation(String isSubLocation) async {
    await shared.setString(
        PsConst.VALUE_HOLDER__IS_SUB_LOCATION, isSubLocation);

    loadValueHolder();
  }

  Future<dynamic> replaceMaxImageCount(int maxImageCount) async {
    await shared.setInt(PsConst.VALUE_HOLDER__MAX_IMAGE_COUNT, maxImageCount);

    loadValueHolder();
  }

  Future<dynamic> replacePackageIAPKeys(
      String packageAndroidKeyList, String packageIOSKeyList) async {
    await shared.setString(
        PsConst.VALUE_HOLDER__PACKAGE_ANDROID_IAP, packageAndroidKeyList);
    await shared.setString(
        PsConst.VALUE_HOLDER__PACKAGE_IOS_IAP, packageIOSKeyList);

    loadValueHolder();
  }

  Future<dynamic> replaceMobileConfigSetting(
      PSMobileConfigSetting psMobileConfigSetting) async {
    await shared.setString(PsConst.GOOGLEPLAYSTOREURL,
        psMobileConfigSetting.googlePlayStoreUrl ?? '');
    await shared.setString(
        PsConst.APPLEAPPSTOREURL, psMobileConfigSetting.appleAppStoreUrl ?? '');
    await shared.setString(
        PsConst.PRICEFORMAT, psMobileConfigSetting.priceFormat ?? ',##0.00');
    await shared.setString(
        PsConst.DATEFORMAT, psMobileConfigSetting.dateFormat ?? 'dd MMM yyyy');
    await shared.setString(
        PsConst.IOSAPPSTOREID, psMobileConfigSetting.iosAppStoreId ?? '');
    await shared.setBool(PsConst.ISUSETHUMBNAILASPLACEHOLDER,
        psMobileConfigSetting.isUseThumbnailAsPlaceHolder == '1');
    await shared.setBool(PsConst.ISSHOWSUBCATEGORY,
        psMobileConfigSetting.isShowSubcategory == '1');
    await shared.setBool(PsConst.VALUE_HOLDER__DISCOUNT_RATEBY_PERCENTAGE,
        psMobileConfigSetting.isShowDiscount == '1');
    await shared.setString(PsConst.FBKEY, psMobileConfigSetting.fbKey ?? '');
    await shared.setBool(
        PsConst.ISSHOWADMOB, psMobileConfigSetting.isShowAdmob == '1');
    await shared.setInt(PsConst.DEFATULTLOADINGLIMIT,
        int.parse(psMobileConfigSetting.defaultLoadingLimit ?? '30'));
    await shared.setInt(PsConst.CATEGORYLOADINGLIMIT,
        int.parse(psMobileConfigSetting.categoryLoadingLimit ?? '30'));
    await shared.setInt(PsConst.RECENTLOADINGLIMIT,
        int.parse(psMobileConfigSetting.recentItemLoadingLimit ?? '30'));
    await shared.setInt(PsConst.POPULARLOADINGLIMIT,
        int.parse(psMobileConfigSetting.populartItemLoadingLimit ?? '30'));
    await shared.setInt(PsConst.DISCOUNTLOADINGLIMIT,
        int.parse(psMobileConfigSetting.discountItemLoadingLimit ?? '30'));
    await shared.setInt(PsConst.FEATUREDLOADINGLIMIT,
        int.parse(psMobileConfigSetting.featuredItemLoadingLimit ?? '30'));
    await shared.setInt(PsConst.BLOCKSLIDERLOADINGLIMIT,
        int.parse(psMobileConfigSetting.blockSliderLoadingLimit ?? '30'));
    await shared.setInt(PsConst.FOLLOWERLOADINGLIMIT,
        int.parse(psMobileConfigSetting.followerItemLoadingLimit ?? '30'));
    await shared.setInt(PsConst.BLOCKITEMLOADINGLIMIT,
        int.parse(psMobileConfigSetting.blockItemLoadingLimit ?? '30'));
    await shared.setBool(PsConst.SHOWFACEBOOKLOGIN,
        psMobileConfigSetting.showFacebookLogin == '1');
    await shared.setBool(
        PsConst.SHOWGOOGLELOGIN, psMobileConfigSetting.showGoogleLogin == '1');
    await shared.setBool(
        PsConst.SHOWITEMVIDEO, psMobileConfigSetting.showItemVideo == '1');

    await shared.setBool(
        PsConst.SHOWPHONELOGIN, psMobileConfigSetting.showPhoneLogin == '1');
    await shared.setBool(PsConst.ISRAZORSUPPORTMULTIICURRENCY,
        psMobileConfigSetting.isRazorSupportMultiCurrency == '1');
    await shared.setString(PsConst.DEFAULTRAZORCURRENCY,
        psMobileConfigSetting.defaultRazorCurrency ?? 'INR');
    await shared.setInt(PsConst.ITEMDETAILVIEWCOUNTFORADS,
        int.parse(psMobileConfigSetting.itemDetailViewCountForAds ?? '5'));
    await shared.setBool(PsConst.ISSHOWADSINITEMDETAIL,
        psMobileConfigSetting.isShowAdsInItemDetail == '1');
    await shared.setDouble(PsConst.BLUEMARKSIZE,
        double.parse(psMobileConfigSetting.bluemarkSize ?? '15'));
    await shared.setString(PsConst.MILE, psMobileConfigSetting.mile ?? '8');
    await shared.setString(
        PsConst.VIDEODURATION, psMobileConfigSetting.videoDuration ?? '60000');
    await shared.setBool(PsConst.ISUSEGOOGLEMAP,
        psMobileConfigSetting.isUseGoogleMap == '1'); //*** */
    await shared.setInt(PsConst.PROFILEIMAGESIZE,
        int.parse(psMobileConfigSetting.profileImageSize ?? '512'));
    await shared.setInt(PsConst.UPLOADIMAGESIZE,
        int.parse(psMobileConfigSetting.uploadImageSize ?? '1024'));
    await shared.setInt(PsConst.CHATIMAGESIZE,
        int.parse(psMobileConfigSetting.chatImageSize ?? '650'));
    await shared.setString(PsConst.PROMOTEFIRSTCHOICEDAY,
        psMobileConfigSetting.promoteFirstChoiceDay ?? '7');
    await shared.setString(PsConst.PROMOTESECONDCHOICEDAY,
        psMobileConfigSetting.promoteSecondChoiceDay ?? '14');
    await shared.setString(PsConst.PROMOTETHIRDCHOICEDAY,
        psMobileConfigSetting.promoteThirdChoiceDay ?? '30');
    await shared.setString(PsConst.PROMOTEFOURTHCHOICEDAY,
        psMobileConfigSetting.promoteFourthChoiceDay ?? '60');
    await shared.setBool(PsConst.NOFILTERWITHLOCATIONONMAP,
        psMobileConfigSetting.noFilterWithLocationOnMap == '1');
    await shared.setBool(
        PsConst.ISSHOWOWNERINFO, psMobileConfigSetting.isShowOwnerInfo == '1');
    await shared.setString(PsConst.DEFAULTLANGUAGE,
        psMobileConfigSetting.defaultLanguage!.languageCode ?? 'en');
    await shared.setBool(
        PsConst.ISFORCELOGIN, psMobileConfigSetting.isForceLogin == '1');
    await shared.setBool(PsConst.ISLANGUAGECONFIG,
        psMobileConfigSetting.isLanguageConfig == '1');
    // await shared.setString(PsConst.VALUE_HOLDER__COLLECTION_PRODUCT_LOADING_LIMIT,
    //     psMobileConfigSetting.collectionItemLoadingLimit ?? '30');
    // await shared.setString(PsConst.VALUE_HOLDER__SHOP_LOADING_LIMIT,
    //     psMobileConfigSetting.shopLoadingLimit ?? '30');
    await shared.setBool(PsConst.VALUE_HOLDER__SHOW_MAIN_MENU,
        psMobileConfigSetting.showMainMenu == '1');
    await shared.setBool(PsConst.VALUE_HOLDER__SHOW_SPECIAL_COLLECTIONS,
        psMobileConfigSetting.showSpecialCollections == '1');
    await shared.setBool(PsConst.VALUE_HOLDER__SHOW_FEATURED_ITEM,
        psMobileConfigSetting.showFeaturedItems == '1');
    await shared.setBool(PsConst.VALUE_HOLDER__SHOW_BEST_CHOICE_SLIDER,
        psMobileConfigSetting.showBestChoiceSlider == '1');
    await shared.setString(PsConst.VALUE_HOLDER__DEFAULT_FLUTTER_WAVE_CURRENCY,
        psMobileConfigSetting.defaultFlutterWaveCurrency ?? 'USD');
    await shared.setString(PsConst.VALUE_HOLDER__DEFAULT_ORDER_TIME,
        psMobileConfigSetting.defaultOrderTime ?? '20');
    await shared.setString(PsConst.VALUE_HOLDER__COLOR_CHANGE_CODE,
        psMobileConfigSetting.clolorChangeCode ?? '1673602972546');

    await shared.setString(
        PsConst.VALUE_HOLDER__ANDROID_ADMOD_BANNER_UNIT_ID,
        psMobileConfigSetting.androidAdMobBannerAdUnitId ??
            'ca-app-pub-0000000000000000~0000000000');
    await shared.setString(
        PsConst.VALUE_HOLDER__ANDROID_ADMOD_NATIVE_UNIT_ID,
        psMobileConfigSetting.androidAdMobNativeAdUnitId ??
            'ca-app-pub-0000000000000000~0000000000');
    await shared.setString(
        PsConst.VALUE_HOLDER__ANDROID_ADMOD_INTERSTITIALAd_UNIT_ID,
        psMobileConfigSetting.androidAdMobInterstitialAdUnitId ??
            'ca-app-pub-0000000000000000~0000000000');
    await shared.setString(
        PsConst.VALUE_HOLDER__IOS_ADMOD_BANNER_UNIT_ID,
        psMobileConfigSetting.iosAdMobBannerAdUnitId ??
            'ca-app-pub-0000000000000000~0000000000');
    await shared.setString(
        PsConst.VALUE_HOLDER__IOS_ADMOD_NATIVE_UNIT_ID,
        psMobileConfigSetting.iosAdMobNativeAdUnitId ??
            'ca-app-pub-0000000000000000~0000000000');
    await shared.setString(
        PsConst.VALUE_HOLDER__IOS_ADMOD_INTERSTITIALAD_UNIT_ID,
        psMobileConfigSetting.iosAdMobInterstitialAdUnitId ??
            'ca-app-pub-0000000000000000~0000000000');

    await shared.setBool(PsConst.VALUE_HOLDER__ID_DEMO_FOR_PAYMENT,
        psMobileConfigSetting.isDemoForPayment == '1');
    await shared.setInt(PsConst.VALUE_HOLDER__LOADING_SHIMMER_ITEM_COUNT,
        int.parse(psMobileConfigSetting.loadingShimmerItemCount ?? '20'));
    await shared.setInt(PsConst.VALUE_HOLDER__RECENT_SEARCH_KEYWORD_LIMIT,
        int.parse(psMobileConfigSetting.recentSearchKeywordLimit ?? '20'));
    await shared.setInt(PsConst.VALUE_HOLDER__PHONE_LIST_COUNT,
        int.parse(psMobileConfigSetting.phoneListCount ?? '20'));
    await shared.setString(PsConst.VALUE_HOLDER__DATA_SOURCE_TYPE,
        psMobileConfigSetting.dataConfigurationDataSourceType ?? '');
    await shared.setInt(PsConst.VALUE_HOLDER__DATA_CONFIGURATION_DAY,
        int.parse(psMobileConfigSetting.dataConfigurationDay ?? '20'));

    await shared.setBool(PsConst.VALUE_HOLDER__IS_SLIDER_AUTO_PLAY,
        psMobileConfigSetting.isSliderAutoPlay == '1');
    await shared.setInt(PsConst.VALUE_HOLDER__AUTO_PLAY_INTERVAL,
        int.parse(psMobileConfigSetting.autoPlayInterval ?? '20'));
    // await shared.setStringList(
    //     PsConst.VALUE_HOLDER__PROFILE_DETAILS_WIDGET_SORT_LIST,
    //     psMobileConfigSetting.profileDetailsWidgetList!);

    loadValueHolder();
  }

  Future<dynamic> replaceisBlockedFeatueDisabled(
      String isBlockedFeatueDisabled) async {
    await shared.setString(
        PsConst.VALUE_HOLDER__BLOCK_FEATURE, isBlockedFeatueDisabled);

    loadValueHolder();
  }

  Future<dynamic> replaceIsPaindApp(String isPaidApp) async {
    await shared.setString(PsConst.VALUE_HOLDER__PAID_APP, isPaidApp);

    loadValueHolder();
  }

  Future<dynamic> replaceIsSubCatSubscribe(String isSubCatSubscribe) async {
    await shared.setString(
        PsConst.VALUE_HOLDER__ISSUBCAT_SUBSCRIBE, isSubCatSubscribe);

    loadValueHolder();
  }

  Future<void> replaceUploadSetting(String uploadSetting) async {
    await shared.setString(
        PsConst.VAlUE_HOLDER__UPLOAD_SETTING, uploadSetting);
    loadValueHolder();
  }

  Future<dynamic> replaceDefaultCurrency(
      String defaultCurrencyId, String defaultCurrency) async {
    await shared.setString(
        PsConst.VALUE_HOLDER__DEFAULT_CURRENCY_ID, defaultCurrencyId);
    await shared.setString(
        PsConst.VALUE_HOLDER__DEFAULT_CURRENCY, defaultCurrency);

    loadValueHolder();
  }

  Future<dynamic> replaceDefaultPhoneCountryCode(
      String defaulCountryCode, String defaultCountryName) async {
    await shared.setString(
        PsConst.VALUE_HOLDER__DEFAULT_PHONE_COUNTRY_CODE, defaulCountryCode);
    await shared.setString(
        PsConst.VALUE_HOLDER__DEFAULT_PHONE_COUNTRY_NAME, defaultCountryName);

    loadValueHolder();
  }

  Future<dynamic> replaceDefaultLatLng(
      String defaulLat, String defaultLng) async {
    await shared.setString(
        PsConst.VALUE_HOLDER__DEFAULT_LOCATION_LAT, defaulLat);
    await shared.setString(
        PsConst.VALUE_HOLDER__DEFAULT_LOCATION_LNG, defaultLng);

    loadValueHolder();
  }

  String? getNotiMessage() {
    return shared.getString(PsConst.VALUE_HOLDER__NOTI_MESSAGE);
  }

  Future<dynamic> replaceNotiSetting(bool notiSetting) async {
    await shared.setBool(PsConst.VALUE_HOLDER__NOTI_SETTING, notiSetting);

    loadValueHolder();
  }

  Future<dynamic> replaceItemLocationTownshipData(
      String townshipId,
      String locationId,
      String locationTownshipName,
      String locationTownshipLat,
      String locationTownshipLng) async {
    await shared.setString(
        PsConst.VALUE_HOLDER__LOCATION_TOWNSHIP_ID, townshipId);
    await shared.setString(PsConst.VALUE_HOLDER__LOCATION_ID, locationId);
    await shared.setString(
        PsConst.VALUE_HOLDER__LOCATION_TOWNSHIP_NAME, locationTownshipName);
    await shared.setString(
        PsConst.VALUE_HOLDER__LOCATION_TOWNSHIP_LAT, locationTownshipLat);
    await shared.setString(
        PsConst.VALUE_HOLDER__LOCATION_TOWNSHIP_LNG, locationTownshipLng);

    loadValueHolder();
  }

  Future<dynamic> replaceCustomCameraSetting(bool cameraSetting) async {
    await shared.setBool(PsConst.VALUE_HOLDER__CAMERA_SETTING, cameraSetting);

    loadValueHolder();
  }

  Future<dynamic> replaceIsToShowIntroSlider(bool doNotShowAgain) async {
    await shared.setBool(
        PsConst.VALUE_HOLDER__SHOW_INTRO_SLIDER, doNotShowAgain);

    loadValueHolder();
  }

  Future<dynamic> replaceShowOnboardLanguage(bool showOrNot) async {
    await shared.setBool(
        PsConst.VALUE_HOLDER__SHOW_ONBOARD_LANGUAGE, showOrNot);

    loadValueHolder();
  }

  Future<dynamic> replaceAgreeTermsAndConditions(bool value) async {
    await shared.setBool(PsConst.VALUE_HOLDER__TERMS_AND_CONDITIONS, value);

    loadValueHolder();
  }

  Future<dynamic> replaceNotiMessage(String message) async {
    await shared.setString(PsConst.VALUE_HOLDER__NOTI_MESSAGE, message);
  }

  Future<dynamic> replaceDate(String startDate, String endDate) async {
    await shared.setString(PsConst.VALUE_HOLDER__START_DATE, startDate);
    await shared.setString(PsConst.VALUE_HOLDER__END_DATE, endDate);

    loadValueHolder();
  }

  Future<dynamic> replaceVerifyUserData(
      String userIdToVerify,
      String userNameToVerify,
      String userEmailToVerify,
      String userPasswordToVerify) async {
    await shared.setString(
        PsConst.VALUE_HOLDER__USER_ID_TO_VERIFY, userIdToVerify);
    await shared.setString(
        PsConst.VALUE_HOLDER__USER_NAME_TO_VERIFY, userNameToVerify);
    await shared.setString(
        PsConst.VALUE_HOLDER__USER_EMAIL_TO_VERIFY, userEmailToVerify);
    await shared.setString(
        PsConst.VALUE_HOLDER__USER_PASSWORD_TO_VERIFY, userPasswordToVerify);

    loadValueHolder();
  }

  Future<dynamic> replaceItemLocationData(String locationId,
      String locationName, String locationLat, String locationLng) async {
    await shared.setString(PsConst.VALUE_HOLDER__LOCATION_ID, locationId);
    await shared.setString(PsConst.VALUE_HOLDER__LOCATION_NAME, locationName);
    await shared.setString(PsConst.VALUE_HOLDER__LOCATION_LAT, locationLat);
    await shared.setString(PsConst.VALUE_HOLDER__LOCATION_LNG, locationLng);

    loadValueHolder();
  }

  Future<dynamic> replaceVersionForceUpdateData(bool appInfoForceUpdate) async {
    await shared.setBool(PsConst.APPINFO_PREF_FORCE_UPDATE, appInfoForceUpdate);

    loadValueHolder();
  }

  Future<dynamic> replaceDetailOpenCount(int count) async {
    await shared.setInt(PsConst.VALUE_HOLDER__DETAIL_OPEN_COUNTER, count);

    loadValueHolder();
  }

  Future<dynamic> replaceAppInfoData(
      String appInfoVersionNo,
      bool appInfoForceUpdate,
      String appInfoForceUpdateTitle,
      String appInfoForceUpdateMsg) async {
    await shared.setString(PsConst.APPINFO_PREF_VERSION_NO, appInfoVersionNo);
    await shared.setBool(PsConst.APPINFO_PREF_FORCE_UPDATE, appInfoForceUpdate);
    await shared.setString(
        PsConst.APPINFO_FORCE_UPDATE_TITLE, appInfoForceUpdateTitle);
    await shared.setString(
        PsConst.APPINFO_FORCE_UPDATE_MSG, appInfoForceUpdateMsg);

    loadValueHolder();
  }

  Future<dynamic> replaceShopInfoValueHolderData(
    String overAllTaxLabel,
    String overAllTaxValue,
    String shippingTaxLabel,
    String shippingTaxValue,
    String shippingId,
    String shopId,
    String messenger,
    String whatsapp,
    String phone,
  ) async {
    await shared.setString(
        PsConst.VALUE_HOLDER__OVERALL_TAX_LABEL, overAllTaxLabel);
    await shared.setString(
        PsConst.VALUE_HOLDER__OVERALL_TAX_VALUE, overAllTaxValue);
    await shared.setString(
        PsConst.VALUE_HOLDER__SHIPPING_TAX_LABEL, shippingTaxLabel);
    await shared.setString(
        PsConst.VALUE_HOLDER__SHIPPING_TAX_VALUE, shippingTaxValue);
    await shared.setString(PsConst.VALUE_HOLDER__SHIPPING_ID, shippingId);
    await shared.setString(PsConst.VALUE_HOLDER__SHOP_ID, shopId);
    await shared.setString(PsConst.VALUE_HOLDER__MESSENGER, messenger);
    await shared.setString(PsConst.VALUE_HOLDER__WHATSAPP, whatsapp);
    await shared.setString(PsConst.VALUE_HOLDER__PHONE, phone);

    loadValueHolder();
  }

  Future<dynamic> replaceCheckoutEnable(
      String paypalEnabled,
      String stripeEnabled,
      String codEnabled,
      String bankEnabled,
      String standardShippingEnable,
      String zoneShippingEnable,
      String noShippingEnable) async {
    await shared.setString(PsConst.VALUE_HOLDER__PAYPAL_ENABLED, paypalEnabled);
    await shared.setString(PsConst.VALUE_HOLDER__STRIPE_ENABLED, stripeEnabled);
    await shared.setString(PsConst.VALUE_HOLDER__COD_ENABLED, codEnabled);
    await shared.setString(
        PsConst.VALUE_HOLDER__BANK_TRANSFER_ENABLE, bankEnabled);
    await shared.setString(
        PsConst.VALUE_HOLDER__STANDART_SHIPPING_ENABLE, standardShippingEnable);
    await shared.setString(
        PsConst.VALUE_HOLDER__ZONE_SHIPPING_ENABLE, zoneShippingEnable);
    await shared.setString(
        PsConst.VALUE_HOLDER__NO_SHIPPING_ENABLE, noShippingEnable);

    loadValueHolder();
  }

  Future<dynamic> replacePublishKey(String pubKey) async {
    await shared.setString(PsConst.VALUE_HOLDER__PUBLISH_KEY, pubKey);

    loadValueHolder();
  }

  bool get openDetailCountLimitExceeded {
    final int? userOpenDetailCount =
        shared.getInt(PsConst.VALUE_HOLDER__DETAIL_OPEN_COUNTER);
    final int itemDetailViewCountForAd =
        shared.getInt(PsConst.ITEMDETAILVIEWCOUNTFORADS) ?? 5;
    return userOpenDetailCount != null &&
        userOpenDetailCount > itemDetailViewCountForAd;
  }

  Future<dynamic> replaceShop(String shopId, String shopName) async {
    await shared.setString(PsConst.VALUE_HOLDER__SHOP_ID, shopId);
    await shared.setString(PsConst.VALUE_HOLDER__SHOP_NAME, shopName);

    loadValueHolder();
  }

  Future<dynamic> replaceAppleLoginUser(bool isAppleLoginUser) async {
    await shared.setBool(PsConst.VALUEHOLDER__APPLE_LOGIN_USER, isAppleLoginUser);

    loadValueHolder();
  }


  Future<dynamic> replaceSelectPriceType(String selectPriceType) async {
    await shared.setString(
        PsConst.VAlUE_HOLDER__PRICE_TYPE, selectPriceType);

    loadValueHolder();
  }


  Future<dynamic> replaceSelectChatType(String selectChatType) async {
    await shared.setString(
        PsConst.VAlUE_HOLDER__CHAT_TYPE, selectChatType);

    loadValueHolder();
  }
}
