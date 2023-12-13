import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class AppSetting extends PsObject<AppSetting?> {
  AppSetting({
    this.latitude,
    this.longitude, 
    this.isSubLocation, 
    this.isBlockedDisabled, 
    this.isPaidApp,
    this.isSubCatSubscribe, 
    this.maxImageCount,
    this.adType,
    this.promoCellNo,
    this.isApprovedEnable,
    this.isThumbGenerate,
    this.oneDayPerPrice,
    this.selectPriceType,
    this.selectChatType});
  String? latitude;
  String? longitude;
  String? isSubLocation;
  String? isBlockedDisabled;
  String? isPaidApp;
  String? isSubCatSubscribe;
  String? maxImageCount;
  String? adType;
  String? promoCellNo;
  String? isApprovedEnable;
  String? isThumbGenerate;
  String? oneDayPerPrice;
  String? selectPriceType;
  String? selectChatType;

  @override
  bool operator ==(dynamic other) =>
      other is AppSetting && latitude == other.latitude;

  @override
  int get hashCode => hash2(latitude.hashCode, latitude.hashCode);

  @override
  String? getPrimaryKey() {
    return latitude;
  }

  @override
  AppSetting? fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return AppSetting(
          latitude: dynamicData['lat'],
          longitude: dynamicData['lng'],
          isApprovedEnable: dynamicData['is_approved_enable'],
          isSubLocation: dynamicData['is_sub_location'],
          isThumbGenerate: dynamicData['is_thumb2x_3x_generate'],
          isPaidApp: dynamicData['is_paid_app'],
          isBlockedDisabled: dynamicData['is_block_user'],
          isSubCatSubscribe: dynamicData['is_sub_subscription'],
          maxImageCount: dynamicData['max_img_upload_of_item'],
          adType: dynamicData['ad_type'],
          promoCellNo: dynamicData['promo_cell_interval_no'],
          oneDayPerPrice: dynamicData['one_day_per_price'],
          selectPriceType: dynamicData['selected_price_type'],
          selectChatType: dynamicData['selected_chat_type']);
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['lat'] = object.latitude;
      data['lng'] = object.longitude;
      data['is_sub_location'] = object.isSubLocation;
      data['is_block_user'] = object.isBlockedDisabled;
      data['is_paid_app'] = object.isPaidApp;
      data['is_sub_subscription'] = object.isSubCatSubscribe;
      data['max_img_upload_of_item'] = object.maxImageCount;
      data['ad_type'] = object.adType;
      data['promo_cell_interval_no'] = object.promoCellNo;
      data['is_approved_enable'] = object.isApprovedEnable;
      data['is_thumb2x_3x_generate'] = object.isThumbGenerate;
      data['one_day_per_price'] = object.oneDayPerPrice;
      data['selected_price_type'] = object.selectPriceType;
      data['selected_chat_type'] = object.selectChatType;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<AppSetting?> fromMapList(List<dynamic> dynamicDataList) {
    final List<AppSetting?> appSettingList = <AppSetting?>[];

    // if (dynamicDataList != null) {
    for (dynamic json in dynamicDataList) {
      if (json != null) {
        appSettingList.add(fromMap(json));
      }
    }
    // }
    return appSettingList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<AppSetting?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (AppSetting? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    // }

    return mapList;
  }
}
