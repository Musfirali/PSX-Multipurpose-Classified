
import '../constant/ps_constants.dart';
import 'common/ps_object.dart';

class CoreField extends PsObject<CoreField> {
  CoreField({
    this.fieldName,
    this.mandatory,
    this.labelName,
    this.visible,
  });

  String? fieldName;
  String? labelName;
  String? visible;
  String? mandatory;

  @override
  CoreField fromMap(dynamic dynamicData) {
    return CoreField(
      fieldName: dynamicData['field_name'],
      mandatory: dynamicData['mandatory'],
      visible: dynamicData['is_visible'],
      labelName: dynamicData['label_name'],
    );
  }

  @override
  List<CoreField> fromMapList(List<dynamic>? dynamicDataList) {
    final List<CoreField> list = <CoreField>[];
    if (dynamicDataList != null) {
      for (dynamic element in dynamicDataList) {
        list.add(fromMap(element));
      }
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return '';
  }

  @override
  Map<String, dynamic>? toMap(CoreField? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['field_name'] = object.fieldName;
      data['mandatory'] = object.mandatory;
      data['is_visible'] = object.visible;
      data['label_name'] = object.labelName;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<CoreField> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (CoreField? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }

  bool get isVisible {
    return visible == PsConst.ONE;
  }

  bool get isMandatory {
    return mandatory == PsConst.ONE;
  }
}
