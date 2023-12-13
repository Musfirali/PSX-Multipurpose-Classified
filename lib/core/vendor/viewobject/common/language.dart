import 'dart:ui';

import 'package:quiver/core.dart';
import 'ps_object.dart';

class Language extends PsObject<Language> {
  Language(
      {this.id,
      this.symbol,
      this.languageCode,
      this.countryCode,
      this.name,
      this.code,
      this.status,
      this.enable,
      this.addedDateStr});
  String? id;
  String? symbol;
  String? languageCode;
  String? countryCode;
  String? name;
  String? code;
  String? status;
  String? enable;
  String? addedDateStr;

  Locale toLocale() {
    return Locale(languageCode!, countryCode);
  }

  @override
  bool operator ==(dynamic other) =>
      other is Language && languageCode == other.languageCode;

  @override
  int get hashCode => hash2(languageCode.hashCode, languageCode.hashCode);

  @override
  String? getPrimaryKey() {
    return languageCode;
  }

  @override
  Language fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return Language(
        id: dynamicData['id'],
        symbol: dynamicData['symbol'],
        languageCode: dynamicData['language_code'],
        countryCode: dynamicData['country_code'],
        name: dynamicData['name'],
        code: dynamicData['code'],
        status: dynamicData['status'],
        enable: dynamicData['enable'],
        addedDateStr: dynamicData['added_date_str']);
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['symbol'] = object.symbol;
      data['language_code'] = object.languageCode;
      data['country_code'] = object.countryCode;
      data['name'] = object.name;
      data['code'] = object.code;
      data['status'] = object.status;
      data['enable'] = object.enable;
      data['added_date_str'] = object.addedDateStr;
      return data;
    } else {
      return null;
    }
  }

  static List<String> getLanguageCodeStringList(List<Language?> languageList) {
    final List<String> result = <String>[];
    for (int i = 0; i < languageList.length; i++) {
      if (languageList[i]?.languageCode != null &&
          languageList[i]!.languageCode!.isNotEmpty)
        result.add(languageList[i]!.languageCode!);
    }
    return result;
  }

  @override
  List<Language> fromMapList(List<dynamic> dynamicDataList) {
    final List<Language> psAppVersionList = <Language>[];

    // if (dynamicDataList != null) {
    for (dynamic json in dynamicDataList) {
      if (json != null) {
        psAppVersionList.add(fromMap(json));
      }
    }
    // }
    return psAppVersionList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Language?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (Language? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
