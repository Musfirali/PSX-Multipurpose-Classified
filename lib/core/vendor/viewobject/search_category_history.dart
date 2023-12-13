import 'common/ps_object.dart';

class SearchCategoryHistory extends PsObject<SearchCategoryHistory> {
  SearchCategoryHistory({
    this.id,
    this.keyword,
    this.userId,
    this.type,
    this.isHomePageSearch,
    this.addedDate,
    this.addedUserId,
    this.updateDate,
    this.updatedUserId,
    this.updatedFlag,
    this.addedDateStr,
  });

  String? id;
  String? keyword;
  String? userId;
  String? type;
  String? isHomePageSearch;
  String? addedDate;
  String? addedUserId;
  String? updateDate;
  String? updatedUserId;
  String? updatedFlag;
  String? addedDateStr;

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  SearchCategoryHistory fromMap(dynamic dynamicData) {
    //if (dynamicData != null) {
    return SearchCategoryHistory(
      id: dynamicData['id'],
      keyword: dynamicData['keyword'],
      userId: dynamicData['user_id'],
      type: dynamicData['type'],
      isHomePageSearch: dynamicData['is_home_page_search'],
      addedDate: dynamicData['added_date'],
      addedUserId: dynamicData['added_user_id'],
      updateDate: dynamicData['updated_date'],
      updatedUserId: dynamicData['updated_user_id'],
      updatedFlag: dynamicData['updated_flag'],
      addedDateStr: dynamicData['added_date_str'],
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
      data['keyword'] = object.keyword;
      data['user_id'] = object.userId;
      data['type'] = object.type;
      data['is_home_page_search'] = object.isHomePageSearch;
      data['added_date'] = object.addedDate;
      data['added_user_id'] = object.addedUserId;
      data['updated_date'] = object.updateDate;
      data['updated_user_id'] = object.updatedUserId;
      data['updated_flag'] = object.updatedFlag;
      data['added_date_str'] = object.addedDateStr;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<SearchCategoryHistory> fromMapList(List<dynamic> dynamicDataList) {
    final List<SearchCategoryHistory> favouriteProductMapList = <SearchCategoryHistory>[];

    //if (dynamicDataList != null) {
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        favouriteProductMapList.add(fromMap(dynamicData));
      }
    }
    //}
    return favouriteProductMapList;
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
