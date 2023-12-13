import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class ItemLocation extends PsObject<ItemLocation> {
  ItemLocation(
      {this.id = '',
      this.name,
      this.lat,
      this.lng,
      this.status,
      this.description,
      this.touchCount,
      this.ordering,
      this.isFeatured,
      this.featuredDate});
  String id;
  String? name;
  String? lat;
  String? lng;
  String? status;
  String? description;
  String? touchCount;
  String? ordering;
  String? isFeatured;
  String? featuredDate;

  @override
  bool operator ==(dynamic other) => other is ItemLocation && id == other.id;

  @override
  int get hashCode {
    return hash2(id.hashCode, id.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  ItemLocation fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return ItemLocation(
        id: dynamicData['id'],
        name: dynamicData['name'],
        lat: dynamicData['lat'],
        lng: dynamicData['lng'],
        status: dynamicData['status'],
        description: dynamicData['description'],
        touchCount: dynamicData['touch_count'],
        ordering: dynamicData['ordering'],
        isFeatured: dynamicData['is_featured'],
        featuredDate: dynamicData['featured_date']);
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(ItemLocation? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['name'] = object.name;
      data['lat'] = object.lat;
      data['lng'] = object.lng;
      data['status'] = object.status;
      data['description'] = object.description;
      data['touch_count'] = object.touchCount;
      data['ordering'] = object.ordering;
      data['is_featured'] = object.isFeatured;
      data['featured_date'] = object.featuredDate;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<ItemLocation> fromMapList(List<dynamic> dynamicDataList) {
    final List<ItemLocation> itemLocationList = <ItemLocation>[];

    // if (dynamicDataList != null) {
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        itemLocationList.add(fromMap(dynamicData));
      }
    }
    // }
    return itemLocationList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ItemLocation?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (ItemLocation? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    // }

    return mapList;
  }

  bool isListEqual(List<ItemLocation> cache, List<ItemLocation> newList) {
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
