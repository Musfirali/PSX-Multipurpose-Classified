import 'common/ps_object.dart';
class EditProfileUserRelation extends PsObject<EditProfileUserRelation> {
  EditProfileUserRelation({
    this.coreKeyId,
    this.value,
  });
  String? coreKeyId;
  String? value;

  @override
  EditProfileUserRelation fromMap(dynamic dynamicData) {
    return EditProfileUserRelation(
        coreKeyId: dynamicData['core_keys_id'], value: dynamicData['value']);
  }

  @override
  List<EditProfileUserRelation> fromMapList(List<dynamic>? dynamicDataList) {
    final List<EditProfileUserRelation> list = <EditProfileUserRelation>[];
    if (dynamicDataList != null) {
      for (EditProfileUserRelation data in dynamicDataList) {
        list.add(fromMap(data));
      }
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return '';
  }

  @override
  List<Map<String, dynamic>?> toMapList(
      List<EditProfileUserRelation>? objectList) {
    final List<Map<String, dynamic>?> list = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (EditProfileUserRelation? element in objectList) {
        if (element != null) {
          list.add(toMap(element));
        }
      }
    }

    return list;
  }

  @override
  Map<String, dynamic>? toMap(EditProfileUserRelation object) {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['core_keys_id'] = object.coreKeyId;
    map['value'] = object.value;
    return map;
  }
}
