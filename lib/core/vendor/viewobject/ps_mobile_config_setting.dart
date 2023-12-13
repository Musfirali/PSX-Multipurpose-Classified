import 'package:quiver/core.dart' show hash2;

import 'common/language.dart';
import 'common/ps_object.dart';

class PSMobileConfigSetting extends PsObject<PSMobileConfigSetting?> {
  PSMobileConfigSetting({
    this.googlePlayStoreUrl,
    this.appleAppStoreUrl,
    this.priceFormat,
    this.dateFormat,
    this.iosAppStoreId,
    this.isUseThumbnailAsPlaceHolder,
    this.isShowSubcategory,
    this.isShowDiscount,
    this.fbKey,
    this.isShowAdmob,
    this.defaultLoadingLimit,
    this.categoryLoadingLimit,
    this.recentItemLoadingLimit,
    this.populartItemLoadingLimit,
    this.discountItemLoadingLimit,
    this.featuredItemLoadingLimit,
    this.blockSliderLoadingLimit,
    this.followerItemLoadingLimit,
    this.blockItemLoadingLimit,
    this.showFacebookLogin,
    this.showGoogleLogin,
    this.showPhoneLogin,
    this.isRazorSupportMultiCurrency,
    this.defaultRazorCurrency,
    this.itemDetailViewCountForAds,
    this.isShowAdsInItemDetail,
    this.bluemarkSize,
    this.mile,
    this.videoDuration,
    this.isUseGoogleMap,
    this.profileImageSize,
    this.uploadImageSize,
    this.chatImageSize,
    this.promoteFirstChoiceDay,
    this.promoteSecondChoiceDay,
    this.promoteThirdChoiceDay,
    this.promoteFourthChoiceDay,
    this.noFilterWithLocationOnMap,
    this.isShowOwnerInfo,
    this.defaultLanguage,
    this.includedLanguages,
    this.isForceLogin,
    this.isLanguageConfig,
    // this.collectionItemLoadingLimit,
    this.defaultFlutterWaveCurrency,
    this.defaultOrderTime,
    this.deliBoyVersionForceUpdate,
    this.deliBoyVersionMessage,
    this.deliBoyVersionNeedClearData,
    this.clolorChangeCode,
    this.deliBoyVersionNo,
    this.deliBoyVersionTitle,
    // this.shopLoadingLimit,
    this.showBestChoiceSlider,
    this.showFeaturedItems,
    this.showMainMenu,
    this.showSpecialCollections,
    this.trendingItemLoadingLimit,
    this.versionForceUpdate,
    this.versionMessage,
    this.versionNeedClearData,
    this.versionNo,
    this.versionTitle,
    this.showItemVideo,
    this.androidAdMobBannerAdUnitId,
    this.androidAdMobNativeAdUnitId,
    this.androidAdMobInterstitialAdUnitId,
    this.iosAdMobBannerAdUnitId,
    this.iosAdMobNativeAdUnitId,
    this.iosAdMobInterstitialAdUnitId,
    this.isDemoForPayment,
    this.loadingShimmerItemCount,
    this.recentSearchKeywordLimit,
    this.phoneListCount,
    this.dataConfigurationDataSourceType,
    this.dataConfigurationDay,
    this.isSliderAutoPlay,
    this.autoPlayInterval,
    this.profileDetailsWidgetList
  });

  String? googlePlayStoreUrl;
  String? appleAppStoreUrl;
  String? priceFormat;
  String? dateFormat;
  String? iosAppStoreId;
  String? isUseThumbnailAsPlaceHolder;
  String? isShowSubcategory;
  String? isShowDiscount;
  String? fbKey;
  String? isShowAdmob;
  String? defaultLoadingLimit;
  String? categoryLoadingLimit;
  String? recentItemLoadingLimit;
  String? populartItemLoadingLimit;
  String? discountItemLoadingLimit;
  String? featuredItemLoadingLimit;
  String? blockSliderLoadingLimit;
  String? followerItemLoadingLimit;
  String? blockItemLoadingLimit;
  String? showFacebookLogin;
  String? showGoogleLogin;
  String? showPhoneLogin;
  String? isRazorSupportMultiCurrency;
  String? defaultRazorCurrency;
  String? itemDetailViewCountForAds;
  String? isShowAdsInItemDetail;
  String? bluemarkSize;
  String? mile;
  String? videoDuration;
  String? isUseGoogleMap;
  String? profileImageSize;
  String? uploadImageSize;
  String? chatImageSize;
  String? promoteFirstChoiceDay;
  String? promoteSecondChoiceDay;
  String? promoteThirdChoiceDay;
  String? promoteFourthChoiceDay;
  String? noFilterWithLocationOnMap;
  String? isShowOwnerInfo;
  Language? defaultLanguage;
  List<Language?>? includedLanguages;
  String? isForceLogin;
  String? isLanguageConfig;
  // String? collectionItemLoadingLimit;
  // String? shopLoadingLimit;
  String? showMainMenu;
  String? showSpecialCollections;
  String? showFeaturedItems;
  String? showBestChoiceSlider;
  String? defaultFlutterWaveCurrency;
  String? defaultOrderTime;
  String? showItemVideo;
  String? trendingItemLoadingLimit;
  String? versionNo;
  String? versionForceUpdate;
  String? versionTitle;
  String? versionMessage;
  String? versionNeedClearData;
  String? deliBoyVersionNo;
  String? deliBoyVersionForceUpdate;
  String? deliBoyVersionTitle;
  String? deliBoyVersionMessage;
  String? deliBoyVersionNeedClearData;
  String? clolorChangeCode;
  String? androidAdMobBannerAdUnitId;
  String? androidAdMobNativeAdUnitId;
  String? androidAdMobInterstitialAdUnitId;
  String? iosAdMobBannerAdUnitId;
  String? iosAdMobNativeAdUnitId;
  String? iosAdMobInterstitialAdUnitId;
  String? isDemoForPayment;
  String? loadingShimmerItemCount;
  String? recentSearchKeywordLimit;
  String? phoneListCount;
  String? dataConfigurationDataSourceType;
  String? dataConfigurationDay;
  String? isSliderAutoPlay;
  String? autoPlayInterval;
  List<String>? profileDetailsWidgetList;

  @override
  bool operator ==(dynamic other) =>
      other is PSMobileConfigSetting &&
      googlePlayStoreUrl == other.googlePlayStoreUrl;

  @override
  int get hashCode =>
      hash2(googlePlayStoreUrl.hashCode, googlePlayStoreUrl.hashCode);

  @override
  String? getPrimaryKey() {
    return googlePlayStoreUrl;
  }

  @override
  PSMobileConfigSetting? fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return PSMobileConfigSetting(
        appleAppStoreUrl: dynamicData['apple_appstore_url'],
        iosAppStoreId: dynamicData['ios_appstore_id'],
        googlePlayStoreUrl: dynamicData['google_playstore_url'],
        isShowAdmob: dynamicData['is_show_admob'],
        fbKey: dynamicData['fb_key'],
        dateFormat: dynamicData['date_format'],
        priceFormat: dynamicData['price_format'],
        defaultRazorCurrency: dynamicData['default_razor_currency'],
        isRazorSupportMultiCurrency:
            dynamicData['is_razor_support_multi_currency'],
        isShowDiscount: dynamicData['is_show_discount'],
        isShowSubcategory: dynamicData['is_show_subcategory'],
        showFacebookLogin: dynamicData['show_facebook_login'],
        showGoogleLogin: dynamicData['show_google_login'],
        showPhoneLogin: dynamicData['show_phone_login'],
        showItemVideo: dynamicData['is_show_item_video'],
        isUseThumbnailAsPlaceHolder:
            dynamicData['is_use_thumbnail_as_placeholder'],
        isUseGoogleMap: dynamicData['is_use_googlemap'],
        itemDetailViewCountForAds:
            dynamicData['item_detail_view_count_for_ads'],
        isShowAdsInItemDetail: dynamicData['is_show_ads_in_item_detail'],
        bluemarkSize: dynamicData['blue_mark_size'],
        blockItemLoadingLimit: dynamicData['block_item_loading_limit'],
        defaultLoadingLimit: dynamicData['default_loading_limit'],
        categoryLoadingLimit: dynamicData['category_loading_limit'],
        recentItemLoadingLimit: dynamicData['recent_item_loading_limit'],
        populartItemLoadingLimit: dynamicData['popular_item_loading_limit'],
        discountItemLoadingLimit: dynamicData['discount_item_loading_limit'],
        featuredItemLoadingLimit: dynamicData['feature_item_loading_limit'],
        blockSliderLoadingLimit: dynamicData['block_slider_loading_limit'],
        followerItemLoadingLimit: dynamicData['follower_item_loading_limit'],
        mile: dynamicData['mile'],
        videoDuration: dynamicData['video_duration'],
        isShowOwnerInfo: dynamicData['is_show_owner_info'],
        noFilterWithLocationOnMap:
            dynamicData['no_filter_with_location_on_map'],
        profileImageSize: dynamicData['profile_image_size'],
        uploadImageSize: dynamicData['upload_image_size'],
        chatImageSize: dynamicData['chat_image_size'],
        promoteFirstChoiceDay: dynamicData['promote_first_choice_day'],
        promoteSecondChoiceDay: dynamicData['promote_second_choice_day'],
        promoteThirdChoiceDay: dynamicData['promote_third_choice_day'],
        promoteFourthChoiceDay: dynamicData['promote_fourth_choice_day'],
        isForceLogin: dynamicData['is_force_login'],
        isLanguageConfig: dynamicData['is_language_config'],
        defaultLanguage: Language().fromMap(dynamicData['default_language']),
        includedLanguages:
            Language().fromMapList(dynamicData['included_language']),
        // collectionItemLoadingLimit:
        //     dynamicData['collection_item_loading_limit'],
        // shopLoadingLimit: dynamicData['shop_loading_limit'],
        showMainMenu: dynamicData['show_main_menu'],
        showSpecialCollections: dynamicData['show_special_collections'],
        showFeaturedItems: dynamicData['show_featured_items'],
        showBestChoiceSlider: dynamicData['show_best_choice_slider'],
        defaultFlutterWaveCurrency:
            dynamicData['default_flutter_wave_currency'],
        defaultOrderTime: dynamicData['default_order_time'],
        trendingItemLoadingLimit: dynamicData['trending_item_loading_limit'],
        versionNo: dynamicData['version_no'],
        versionForceUpdate: dynamicData['version_force_update'],
        versionTitle: dynamicData['version_title'],
        versionMessage: dynamicData['version_message'],
        versionNeedClearData: dynamicData['version_need_clear_data'],
        deliBoyVersionNo: dynamicData['deli_boy_version_no'],
        deliBoyVersionForceUpdate: dynamicData['deli_boy_version_force_update'],
        deliBoyVersionTitle: dynamicData['deli_boy_version_title'],
        deliBoyVersionMessage: dynamicData['deli_boy_version_message'],
        deliBoyVersionNeedClearData:
            dynamicData['deli_boy_version_need_clear_data'],
        clolorChangeCode: dynamicData['color_change_code'],
        
        androidAdMobBannerAdUnitId: dynamicData['android_admob_banner_ad_unit_id'],
        androidAdMobNativeAdUnitId: dynamicData['android_admob_native_unit_id'],
        androidAdMobInterstitialAdUnitId: dynamicData['andorid_admob_interstitial_ad_unit_id'],
        iosAdMobBannerAdUnitId: dynamicData['ios_admob_banner_ad_unit_id'],
        iosAdMobNativeAdUnitId: dynamicData['ios_admob_native_ad_unit_id'],
        iosAdMobInterstitialAdUnitId: dynamicData['ios_admob_interstitial_ad_unit_id'],
        isDemoForPayment: dynamicData['is_demo_for_payment'],
        loadingShimmerItemCount: dynamicData['loading_shimmer_item_count'],
        recentSearchKeywordLimit: dynamicData['recent_search_keyword_limit'],
        phoneListCount: dynamicData['phone_list_count'],
        dataConfigurationDataSourceType: dynamicData['data_config_data_source_type'],
        dataConfigurationDay: dynamicData['data_config_day'],
        isSliderAutoPlay: dynamicData['is_slider_auto_play'],
        autoPlayInterval: dynamicData['auto_play_interval'],
      );
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['google_playstore_url'] = object.googlePlayStoreUrl;
      data['apple_appstore_url'] = object.appleAppStoreUrl;
      data['price_format'] = object.priceFormat;
      data['date_format'] = object.dateFormat;
      data['ios_appstore_id'] = object.iosAppStoreId;
      data['is_use_thumbnail_as_placeholder'] =
          object.isUseThumbnailAsPlaceHolder;
      data['is_show_subcategory'] = object.isShowSubcategory;
      data['is_show_discount'] = object.isShowDiscount;
      data['fb_key'] = object.fbKey;
      data['is_show_admob'] = object.isShowAdmob;
      data['default_loading_limit'] = object.defaultLoadingLimit;
      data['category_loading_limit'] = object.categoryLoadingLimit;
      data['recent_item_loading_limit'] = object.recentItemLoadingLimit;
      data['popular_item_loading_limit'] = object.populartItemLoadingLimit;
      data['discount_item_loading_limit'] = object.discountItemLoadingLimit;
      data['feature_item_loading_limit'] = object.featuredItemLoadingLimit;
      data['block_slider_loading_limit'] = object.blockSliderLoadingLimit;
      data['follower_item_loading_limit'] = object.followerItemLoadingLimit;
      data['block_item_loading_limit'] = object.blockItemLoadingLimit;
      data['show_facebook_login'] = object.showFacebookLogin;
      data['show_google_login'] = object.showGoogleLogin;
      data['show_phone_login'] = object.showPhoneLogin;
      data['is_show_item_video'] = object.showItemVideo;
      data['is_razor_support_multi_currency'] =
          object.isRazorSupportMultiCurrency;
      data['default_razor_currency'] = object.defaultRazorCurrency;
      data['item_detail_view_count_for_ads'] = object.itemDetailViewCountForAds;
      data['is_show_ads_in_item_detail'] = object.isShowAdsInItemDetail;
      data['blue_mark_size'] = object.bluemarkSize;
      data['mile'] = object.mile;
      data['video_duration'] = object.videoDuration;
      data['is_use_googlemap'] = object.isUseGoogleMap;
      data['profile_image_size'] = object.profileImageSize;
      data['upload_image_size'] = object.uploadImageSize;
      data['chat_image_size'] = object.chatImageSize;
      data['promote_first_choice_day'] = object.promoteFirstChoiceDay;
      data['promote_second_choice_day'] = object.promoteSecondChoiceDay;
      data['promote_third_choice_day'] = object.promoteThirdChoiceDay;
      data['promote_fourth_choice_day'] = object.promoteFourthChoiceDay;
      data['no_filter_with_location_on_map'] = object.noFilterWithLocationOnMap;
      data['is_show_owner_info'] = object.isShowOwnerInfo;
      data['is_force_login'] = object.isForceLogin;
      data['is_language_config'] = object.isLanguageConfig;
      data['default_language'] = Language().fromMap(object.defaultLanguage);
      data['included_language'] =
          Language().fromMapList(object.includedLanguages);
      // data['collection_item_loading_limit'] = object.collectionItemLoadingLimit;
      // data['shop_loading_limit'] = object.shopLoadingLimit;
      data['show_main_menu'] = object.showMainMenu;
      data['show_special_collections'] = object.showSpecialCollections;
      data['show_featured_items'] = object.showFeaturedItems;
      data['show_best_choice_slider'] = object.showBestChoiceSlider;
      data['default_flutter_wave_currency'] = object.defaultFlutterWaveCurrency;
      data['default_order_time'] = object.defaultOrderTime;
      data['trending_item_loading_limit'] = object.trendingItemLoadingLimit;
      data['version_no'] = object.versionNo;
      data['version_force_update'] = object.versionForceUpdate;
      data['version_title'] = object.versionTitle;
      data['version_message'] = object.versionMessage;
      data['version_need_clear_data'] = object.versionNeedClearData;
      data['deli_boy_version_no'] = object.deliBoyVersionNo;
      data['deli_boy_version_force_update'] = object.deliBoyVersionForceUpdate;
      data['deli_boy_version_title'] = object.deliBoyVersionTitle;
      data['deli_boy_version_message'] = object.deliBoyVersionMessage;
      data['deli_boy_version_need_clear_data'] =
          object.deliBoyVersionNeedClearData;
      data['color_change_code'] = object.clolorChangeCode;

      data['android_admob_banner_ad_unit_id'] = object.androidAdMobBannerAdUnitId;
      data['android_admob_native_unit_id'] = object.androidAdMobNativeAdUnitId;
      data['andorid_admob_interstitial_ad_unit_id'] = object.androidAdMobInterstitialAdUnitId;
      data['ios_admob_banner_ad_unit_id'] = object.iosAdMobBannerAdUnitId;
      data['ios_admob_native_ad_unit_id'] = object.iosAdMobNativeAdUnitId;
      data['ios_admob_interstitial_ad_unit_id'] = object.iosAdMobInterstitialAdUnitId;
      data['is_demo_for_payment'] = object.isDemoForPayment;
      data['loading_shimmer_item_count'] = object.loadingShimmerItemCount;
      data['recent_search_keyword_limit'] = object.recentSearchKeywordLimit;
      data['phone_list_count'] = object.phoneListCount;
      data['data_config_data_source_type'] = object.dataConfigurationDataSourceType;
      data['data_config_day'] = object.dataConfigurationDay;
      data['is_slider_auto_play'] = object.isSliderAutoPlay;
      data['auto_play_interval'] = object.autoPlayInterval;


      return data;
    } else {
      return null;
    }
  }

  @override
  List<PSMobileConfigSetting?> fromMapList(List<dynamic> dynamicDataList) {
    final List<PSMobileConfigSetting?> mobileConfigSettingList =
        <PSMobileConfigSetting?>[];

    // if (dynamicDataList != null) {
    for (dynamic json in dynamicDataList) {
      if (json != null) {
        mobileConfigSettingList.add(fromMap(json));
      }
    }
    // }
    return mobileConfigSettingList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(
      List<PSMobileConfigSetting?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (PSMobileConfigSetting? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    // }

    return mapList;
  }
}
