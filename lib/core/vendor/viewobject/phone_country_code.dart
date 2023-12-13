import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class PhoneCountryCode extends PsObject<PhoneCountryCode> {
  PhoneCountryCode({
    this.id, 
    this.countryName, 
    this.countryCode, 
    this.status, 
    this.isDefault,
    this.addedDate,
    this.addDateString});

  String? id;
  String? countryName;
  String? countryCode;
  String? status;
  String? isDefault;
  String? addedDate;
  String? addDateString;

  @override
  bool operator ==(dynamic other) => other is PhoneCountryCode && id == other.id;

  @override
  int get hashCode => hash2(id.hashCode, id.hashCode);

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  PhoneCountryCode fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return PhoneCountryCode(
      id: dynamicData['id'],
      countryName: dynamicData['country_name'],
      countryCode: dynamicData['country_code'],
      status: dynamicData['status'],
      isDefault: dynamicData['is_default'],
      addedDate: dynamicData['added_date'],
      addDateString: dynamicData['added_date_str'],
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['country_name'] = object.countryName;
      data['country_code'] = object.countryCode;
      data['status'] = object.status;
      data['is_default'] = object.isDefault;
      data['added_date'] = object.addedDate;
      data['added_date_str'] = object.addDateString;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<PhoneCountryCode> fromMapList(List<dynamic> dynamicDataList) {
    final List<PhoneCountryCode> userLoginList = <PhoneCountryCode>[];

    // if (dynamicDataList != null) {
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        userLoginList.add(fromMap(dynamicData));
      }
    }
    // }
    return userLoginList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<dynamic> objectList) {
    final List<Map<String, dynamic>?> dynamicList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (dynamic data in objectList) {
      if (data != null) {
        dynamicList.add(toMap(data));
      }
    }
    // }
    return dynamicList;
  }
}
