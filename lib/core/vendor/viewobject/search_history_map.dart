import 'package:quiver/core.dart';

import 'common/ps_map_object.dart';
import 'search_history.dart';

class SearchHistoryMap extends PsMapObject<SearchHistoryMap, SearchHistory> {
  SearchHistoryMap(
      {this.id,
      this.mapKey,
      this.searchHistoryId,
      int? sorting,
      this.addedDate}) {
    super.sorting = sorting;
  }

  String? id;
  String? mapKey;
  String? searchHistoryId;
  String? addedDate;

  @override
  bool operator ==(dynamic other) =>
      other is SearchHistoryMap && id == other.id;

  @override
  int get hashCode => hash2(id.hashCode, id.hashCode);

  @override
  SearchHistoryMap fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return SearchHistoryMap(
        id: dynamicData['id'],
        mapKey: dynamicData['map_key'],
        searchHistoryId: dynamicData['search_history_id'],
        sorting: dynamicData['sorting'],
        addedDate: dynamicData['added_date']);
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    // if (object != null) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = object.id;
    data['map_key'] = object.mapKey;
    data['search_history_id'] = object.searchHistoryId;
    data['sorting'] = object.sorting;
    data['added_date'] = object.addedDate;

    return data;
    // } else {
    //   return null;
    // }
  }

  @override
  List<SearchHistoryMap> fromMapList(List<dynamic> dynamicDataList) {
    final List<SearchHistoryMap> categoryMapList = <SearchHistoryMap>[];

    // if (dynamicDataList != null) {
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        categoryMapList.add(fromMap(dynamicData));
      }
    }
    // }
    return categoryMapList;
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

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  List<String> getIdList(List<dynamic> mapList) {
    final List<String> idList = <String>[];
    // if (mapList != null) {
    for (dynamic category in mapList) {
      if (category != null) {
        idList.add(category.searchHistoryId);
      }
    }
    // }
    return idList;
  }

  @override
  SearchHistoryMap fromPsObject(
      {required SearchHistory obj,
      required String? addedDate,
      required String mapKey,
      required int sorting}) {
    return SearchHistoryMap(
      id: obj.id! + mapKey,
      addedDate: addedDate ?? DateTime.now().toString(),
      searchHistoryId: obj.id,
      mapKey: mapKey,
      sorting: sorting,
    );
  }
}
