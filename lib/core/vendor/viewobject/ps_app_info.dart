import 'common/ps_object.dart';
import 'item_currency.dart';
import 'phone_country_code.dart';
import 'ps_app_setting.dart';
import 'ps_mobile_config_setting.dart';
import 'user_info.dart';

class PSAppInfo extends PsObject<PSAppInfo?> {
  PSAppInfo(
      {
      // this.psAppVersion,
      this.appSetting,
      this.userInfo,
      this.defaultCurrency,
      this.defaultPhoneCountryCode,
      // this.itemUploadConfig,
      this.psMobileConfigSetting,
      // this.deleteObject,
      this.currencySymbol,
      this.currencyShortForm,
      this.stripePublishableKey,
      this.paypalEnable,
      this.stripeEnable,
      this.razorEnable,
      this.razorKey,
      this.offlineEnabled,
      this.payStackEnabled,
      this.payStackKey,
      this.inAppPurchasedEnabled,
      this.inAppPurchasedPrdIdAndroid,
      this.inAppPurchasedPrdIdIOS,
      this.packageInAppPurchaseKeyInAndroid,
      this.packageInAppPurchaseKeyInIOS,
      this.uploadSetting});
  // PSAppVersion? psAppVersion;
  AppSetting? appSetting;
  UserInfo? userInfo;
  ItemCurrency? defaultCurrency;
  PhoneCountryCode? defaultPhoneCountryCode;
  // ItemUploadConfig? itemUploadConfig;
  PSMobileConfigSetting? psMobileConfigSetting;
  // List<DeleteObject?>? deleteObject;
  String? currencySymbol;
  String? currencyShortForm;
  String? stripePublishableKey;
  String? stripeEnable;
  String? paypalEnable;
  String? razorEnable;
  String? razorKey;
  String? offlineEnabled;
  String? payStackEnabled;
  String? inAppPurchasedEnabled;
  String? inAppPurchasedPrdIdAndroid;
  String? inAppPurchasedPrdIdIOS;
  String? payStackKey;
  String? packageInAppPurchaseKeyInAndroid;
  String? packageInAppPurchaseKeyInIOS;
  String? uploadSetting;

  @override
  String getPrimaryKey() {
    return '';
  }

  @override
  PSAppInfo? fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return PSAppInfo(
          // psAppVersion: PSAppVersion().fromMap(dynamicData['version']),
          appSetting: AppSetting().fromMap(dynamicData['app_setting']),
          userInfo: UserInfo().fromMap(dynamicData['user_info']),
          defaultCurrency:
              ItemCurrency().fromMap(dynamicData['default_currency']),
          defaultPhoneCountryCode: PhoneCountryCode()
              .fromMap(dynamicData['default_phone_country_code']),
          // deleteObject:
          //     DeleteObject().fromMapList(dynamicData['delete_history']),
          // itemUploadConfig:
          //     ItemUploadConfig().fromMap(dynamicData['item_upload_config']),
          psMobileConfigSetting: PSMobileConfigSetting()
              .fromMap(dynamicData['mobile_config_setting']),
          currencySymbol: dynamicData['currency_symbol'],
          currencyShortForm: dynamicData['currency_short_form'],
          stripePublishableKey: dynamicData['stripe_publishable_key'],
          paypalEnable: dynamicData['paypal_enabled'],
          razorEnable: dynamicData['razor_enabled'],
          razorKey: dynamicData['razor_key'],
          stripeEnable: dynamicData['stripe_enabled'],
          offlineEnabled: dynamicData['offline_enabled'],
          payStackEnabled: dynamicData['paystack_enabled'],
          payStackKey: dynamicData['paystack_key'],
          inAppPurchasedEnabled: dynamicData['promote_in_app_purchased_enable'],
          inAppPurchasedPrdIdAndroid:
              dynamicData['in_app_purchased_prd_id_android'],
          inAppPurchasedPrdIdIOS: dynamicData['in_app_purchased_prd_id_ios'],
          packageInAppPurchaseKeyInAndroid:
              dynamicData['package_in_app_purchased_android'],
          packageInAppPurchaseKeyInIOS:
              dynamicData['package_in_app_purchased_ios'],
          uploadSetting: dynamicData['upload_setting']);
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      // data['version'] = PSAppVersion().fromMap(object.psAppVersion);
      data['app_setting'] = AppSetting().fromMap(object.appSetting);
      data['user_info'] = UserInfo().fromMap(object.userInfo);
      data['default_currency'] = ItemCurrency().fromMap(object.defaultCurrency);
      data['default_phone_country_code'] =
          PhoneCountryCode().fromMap(object.defaultPhoneCountryCode);
      // data['item_upload_config'] = ItemUploadConfig().fromMap(object.itemUploadConfig);
      data['mobile_config_setting'] =
          PSMobileConfigSetting().fromMap(object.psMobileConfigSetting);
      // data['delete_history'] = object.deleteObject.toList();
      data['currency_symbol'] = object.currencySymbol;
      data['currency_short_form'] = object.currencyShortForm;
      data['stripe_publishable_key'] = object.stripePublishableKey;
      data['stripe_enabled'] = object.stripeEnable;
      data['paypal_enabled'] = object.paypalEnable;
      data['razor_enabled'] = object.razorEnable;
      data['razor_key'] = object.razorKey;
      data['offline_enabled'] = object.offlineEnabled;
      data['paystack_enabled'] = object.payStackEnabled;
      data['paystack_key'] = object.payStackKey;
      data['promote_in_app_purchased_enable'] = object.inAppPurchasedEnabled;
      data['in_app_purchased_prd_id_android'] =
          object.inAppPurchasedPrdIdAndroid;
      data['in_app_purchased_prd_id_ios'] = object.inAppPurchasedPrdIdIOS;
      data['package_in_app_purchased_android'] =
          object.packageInAppPurchaseKeyInAndroid;
      data['package_in_app_purchased_ios'] =
          object.packageInAppPurchaseKeyInIOS;
      data['upload_setting'] = object.uploadSetting;    
      return data;
    } else {
      return null;
    }
  }

  @override
  List<PSAppInfo?> fromMapList(List<dynamic> dynamicDataList) {
    final List<PSAppInfo?> psAppInfoList = <PSAppInfo?>[];

    // if (dynamicDataList != null) {
    for (dynamic json in dynamicDataList) {
      if (json != null) {
        psAppInfoList.add(fromMap(json));
      }
    }
    // }
    return psAppInfoList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<dynamic> objectList) {
    final List<dynamic> dynamicList = <dynamic>[];
    // if (objectList != null) {
    for (dynamic data in objectList) {
      if (data != null) {
        dynamicList.add(toMap(data));
      }
    }
    // }

    return dynamicList as List<Map<String, dynamic>?>;
  }
}
