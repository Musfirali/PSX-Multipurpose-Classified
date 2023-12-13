import 'common/ps_object.dart';
import 'core_field.dart';
import 'custom_field.dart';

class ItemEntryField extends PsObject<ItemEntryField> {
  ItemEntryField({this.coreField, this.customField});

  List<CustomField>? customField;
  List<CoreField>? coreField;

  @override
  ItemEntryField fromMap(dynamic dynamicData) {
    return ItemEntryField(
      coreField: CoreField().fromMapList(dynamicData['core']),
      customField: CustomField().fromMapList(dynamicData['custom']),
    );
  }

  @override
  List<ItemEntryField> fromMapList(List<dynamic> dynamicDataList) {
    final List<ItemEntryField> list = <ItemEntryField>[];
    for (ItemEntryField element in dynamicDataList) {
      list.add(ItemEntryField().fromMap(element));
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return 'customKey';
  }

  @override
  Map<String, dynamic>? toMap(ItemEntryField? object) {
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
  List<Map<String, dynamic>?> toMapList(List<ItemEntryField> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (ItemEntryField? object in objectList) {
      if (object != null) {
        mapList.add(toMap(object));
      }
    }
    return mapList;
  }
}
