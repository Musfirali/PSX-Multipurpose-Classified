import 'package:quiver/core.dart';
import 'common/ps_object.dart';

class CoreKey extends PsObject<CoreKey> {
  CoreKey({
    this.coreKeysId,
    this.name,
    this.description,
    this.status,
    this.addedDateStr,
  });

  String? coreKeysId;
  String? name;
  String? description;
  String? status;
  String? addedDateStr;


  @override
  bool operator ==(dynamic other) => other is CoreKey && coreKeysId == other.coreKeysId;

  @override
  int get hashCode {
    return hash2(coreKeysId.hashCode, coreKeysId.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return coreKeysId;
  }

  @override
  CoreKey fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return CoreKey(
      coreKeysId : dynamicData['core_keys_id'],
      name: dynamicData['name'],
      description: dynamicData['description'],
      status: dynamicData['status'],
      addedDateStr: dynamicData['added_date_str'],
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(CoreKey? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['core_keys_id'] = object.coreKeysId;
      data['name'] = object.name;
      data['description'] = object.description;
      data['status'] = object.status;
      data['added_date_str'] = object.addedDateStr;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<CoreKey> fromMapList(List<dynamic> dynamicDataList) {
    final List<CoreKey> blogList = <CoreKey>[];

    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        blogList.add(fromMap(dynamicData));
      }
    }
    return blogList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<CoreKey?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (CoreKey? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}