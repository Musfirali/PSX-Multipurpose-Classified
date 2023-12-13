import 'common/ps_object.dart';
import 'selected_value.dart';

class UserRelation extends PsObject<UserRelation> {
  UserRelation({
    this.id,
    this.userId,
    this.value,
    this.coreKeyId,
    this.uiTypeId,
    this.addedDateStr,
    this.selectedValues,
  });

  String? id;
  String? userId;
  String? value;
  String? coreKeyId;
  String? uiTypeId;
  String? addedDateStr;
  List<SelectedValue>? selectedValues;

  @override
  UserRelation fromMap(dynamic dynamicData) {
    return UserRelation(
      id: dynamicData['id'],
      userId: dynamicData['user_id'],
      value: dynamicData['value'],
      coreKeyId: dynamicData['core_keys_id'],
      uiTypeId: dynamicData['ui_type_id'],
      addedDateStr: dynamicData['added_date_str'],
      selectedValues: SelectedValue().fromMapList(dynamicData['selectedValue']),
    );
  }

  @override
  List<UserRelation> fromMapList(List<dynamic>? dynamicDataList) {
    final List<UserRelation> list = <UserRelation>[];
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
  Map<String, dynamic>? toMap(UserRelation? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['user_id'] = object.userId;
      data['value'] = object.value;
      data['core_keys_id'] = object.coreKeyId;
      data['ui_type_id'] = object.uiTypeId;
      data['added_date_str'] = object.addedDateStr;
      data['selectedValue'] = SelectedValue().toMapList(object.selectedValues!);

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<UserRelation> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (UserRelation? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }
}
