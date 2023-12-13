import 'common/ps_object.dart';
class EntryProductRelation extends PsObject<EntryProductRelation> {
  EntryProductRelation({
    this.coreKeyId,
    this.value,
  });
  String? coreKeyId;
  String? value;

  @override
  EntryProductRelation fromMap(dynamic dynamicData) {
    return EntryProductRelation(
        coreKeyId: dynamicData['core_keys_id'], value: dynamicData['value']);
  }

  @override
  List<EntryProductRelation> fromMapList(List<dynamic>? dynamicDataList) {
    final List<EntryProductRelation> list = <EntryProductRelation>[];
    if (dynamicDataList != null) {
      for (EntryProductRelation data in dynamicDataList) {
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
      List<EntryProductRelation>? objectList) {
    final List<Map<String, dynamic>?> list = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (EntryProductRelation? element in objectList) {
        if (element != null) {
          list.add(toMap(element));
        }
      }
    }

    return list;
  }

  @override
  Map<String, dynamic>? toMap(EntryProductRelation object) {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['core_keys_id'] = object.coreKeyId;
    map['value'] = object.value;
    return map;
  }
}
