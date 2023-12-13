import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class ItemCurrency extends PsObject<ItemCurrency> {
  ItemCurrency(
      {this.id,
      this.currencyShortForm,
      this.status,
      this.addedDate,
      this.currencySymbol,
      this.isDefault});

  String? id;
  String? currencyShortForm;
  String? status;
  String? addedDate;
  String? currencySymbol;
  String? isDefault;

  @override
  bool operator ==(dynamic other) => other is ItemCurrency && id == other.id;

  @override
  int get hashCode => hash2(id.hashCode, id.hashCode);

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  ItemCurrency fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return ItemCurrency(
      id: dynamicData['id'],
      currencyShortForm: dynamicData['currency_short_form'],
      status: dynamicData['status'],
      addedDate: dynamicData['added_date'],
      currencySymbol: dynamicData['currency_symbol'],
      isDefault: dynamicData['is_default'],
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
      data['currency_short_form'] = object.currencyShortForm;
      data['status'] = object.status;
      data['added_date'] = object.addedDate;
      data['currency_symbol'] = object.currencySymbol;
      data['is_default'] = object.isDefault;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<ItemCurrency> fromMapList(List<dynamic> dynamicDataList) {
    final List<ItemCurrency> userLoginList = <ItemCurrency>[];

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
