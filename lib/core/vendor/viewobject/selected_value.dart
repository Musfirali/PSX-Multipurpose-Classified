
import 'common/ps_object.dart';
class SelectedValue extends PsObject<SelectedValue> {
  SelectedValue({
    this.id, 
    this.value});

  String? id;
  String? value;

  @override
  SelectedValue fromMap(dynamic dynamicData) {
    return SelectedValue(
      id: dynamicData['id'], 
      value: dynamicData['value']);
  }

  @override
  List<SelectedValue> fromMapList(List<dynamic>? dynamicDataList) {
    final List<SelectedValue> list = <SelectedValue>[];
    if (dynamicDataList != null) {
      for (dynamic element in dynamicDataList) {
        list.add(fromMap(element));
      }
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return id.toString();
  }

  @override
  Map<String, dynamic>? toMap(SelectedValue? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['value'] = object.value;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<SelectedValue> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (SelectedValue? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }
}
