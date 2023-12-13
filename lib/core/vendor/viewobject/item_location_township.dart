import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class ItemLocationTownship extends PsObject<ItemLocationTownship> {
  ItemLocationTownship(
      {this.id,
      this.cityId,
      this.townshipName,
      this.ordering,
      this.lat,
      this.lng,
      this.status,
      this.addedDate,
      this.addedDateStr,
      this.description,
      this.touchCount,
      this.isFeatured,
      this.featuredDate});
  String? id;
  String? cityId;
  String? townshipName;
  String? ordering;
  String? lat;
  String? lng;
  String? status;
  String? addedDate;
  String? addedDateStr;
  String? description;
  String? touchCount;
  String? isFeatured;
  String? featuredDate;

  @override
  bool operator ==(dynamic other) =>
      other is ItemLocationTownship && id == other.id;

  @override
  int get hashCode {
    return hash2(id.hashCode, id.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  ItemLocationTownship fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return ItemLocationTownship(
        id: dynamicData['id'],
        cityId: dynamicData['location_city_id'],
        townshipName: dynamicData['name'],
        ordering: dynamicData['ordering'],
        lat: dynamicData['lat'],
        lng: dynamicData['lng'],
        status: dynamicData['status'],
        addedDate: dynamicData['added_date'],
        addedDateStr: dynamicData['added_date_str'],
        description: dynamicData['description'],
        touchCount: dynamicData['touch_count'],
        isFeatured: dynamicData['is_featured'],
        featuredDate: dynamicData['featured_date']);
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(ItemLocationTownship? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['location_city_id'] = object.cityId;
      data['name'] = object.townshipName;
      data['odering'] = object.ordering;
      data['lat'] = object.lat;
      data['lng'] = object.lng;
      data['status'] = object.status;
      data['added_date'] = object.addedDate;
      data['added_date_str'] = object.addedDateStr;
      data['description'] = object.description;
      data['touch_count'] = object.touchCount;
      data['is_featured'] = object.isFeatured;
      data['featured_date'] = object.featuredDate;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<ItemLocationTownship> fromMapList(List<dynamic> dynamicDataList) {
    final List<ItemLocationTownship> itemLocationTownshipList =
        <ItemLocationTownship>[];

    // if (dynamicDataList != null) {
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        itemLocationTownshipList.add(fromMap(dynamicData));
      }
    }
    // }
    return itemLocationTownshipList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(
      List<ItemLocationTownship?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (ItemLocationTownship? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    // }

    return mapList;
  }

  bool isListEqual(
      List<ItemLocationTownship> cache, List<ItemLocationTownship> newList) {
    if (cache.length == newList.length) {
      bool status = true;
      for (int i = 0; i < cache.length; i++) {
        if (cache[i].id != newList[i].id) {
          status = false;
          break;
        }
      }

      return status;
    } else {
      return false;
    }
  }
}
