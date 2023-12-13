import 'common/ps_object.dart';
import 'core_field.dart';
import 'custom_field.dart';

class UserField extends PsObject<UserField> {
  UserField({this.coreField, this.customField});

  List<CustomField>? customField;
  List<CoreField>? coreField;

  @override
  UserField fromMap(dynamic dynamicData) {
    return UserField(
      coreField: CoreField().fromMapList(dynamicData['core']),
      customField: CustomField().fromMapList(dynamicData['custom']),
    );
  }

  @override
  List<UserField> fromMapList(List<dynamic> dynamicDataList) {
    final List<UserField> list = <UserField>[];
    for (UserField element in dynamicDataList) {
      list.add(UserField().fromMap(element));
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return 'customKey';
  }

  @override
  Map<String, dynamic>? toMap(UserField? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['core'] = CoreField().toMapList(object.coreField!);
      data['custom'] = CustomField().toMapList(object.customField!);

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<UserField> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (UserField? object in objectList) {
      if (object != null) {
        mapList.add(toMap(object));
      }
    }
    return mapList;
  }
}
