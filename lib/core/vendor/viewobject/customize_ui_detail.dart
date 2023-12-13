import 'common/ps_object.dart';

class CustomizeUiDetail extends PsObject<CustomizeUiDetail> {
  CustomizeUiDetail({
    this.coreKeyId,
    this.id,
    this.name,
  });
  String? id;
  String? coreKeyId;
  String? name;

  @override
  CustomizeUiDetail fromMap(dynamic dynamicData) {
    return CustomizeUiDetail(
      id: dynamicData['id'],
      coreKeyId: dynamicData['core_keys_id'],
      name: dynamicData['name'],
    );
  }

  @override
  List<CustomizeUiDetail> fromMapList(List<dynamic>? dynamicDataList) {
    final List<CustomizeUiDetail> list = <CustomizeUiDetail>[];

    if (dynamicDataList != null && dynamicDataList.isNotEmpty) {
      for (dynamic data in dynamicDataList) {
        list.add(fromMap(data));
      }
    }

    return list;
  }

  @override
  String? getPrimaryKey() {
    return id.toString();
  }

  @override
  Map<String, dynamic>? toMap(CustomizeUiDetail? object) {
    if (object != null) {
      final Map<String, dynamic> map = <String, dynamic>{};
      map['id'] = object.id;
      map['name'] = object.name;
      map['core_keys_id'] = object.coreKeyId;
      return map;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<CustomizeUiDetail> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (CustomizeUiDetail? object in objectList) {
      if (object != null) {
        mapList.add(toMap(object));
      }
    }
    return mapList;
  }
}
