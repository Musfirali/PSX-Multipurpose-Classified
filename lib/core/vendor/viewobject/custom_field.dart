import '../constant/ps_constants.dart';
import 'common/ps_object.dart';
import 'customize_ui_detail.dart';

class CustomField extends PsObject<CustomField> {
  CustomField({
    this.visible,
    this.id,
    this.isDelete,
    this.mandatory,
    this.moduleName,
    this.name,
    this.coreKeyId,
    this.uiType,
    this.placeHolder,
    this.customizeUiDetails,
  });

  String? id;
  String? name;
  String? mandatory;
  String? visible;
  String? isDelete;
  String? moduleName;
  String? placeHolder;
  String? coreKeyId;
  UiType? uiType;
  List<CustomizeUiDetail>? customizeUiDetails;

  @override
  CustomField fromMap(dynamic dynamicData) {
    return CustomField(
      id: dynamicData['id'],
      name: dynamicData['name'],
      placeHolder: dynamicData['placeholder'],
      coreKeyId: dynamicData['core_keys_id'],
      uiType: UiType().fromMap(dynamicData['ui_type']),
      mandatory: dynamicData['mandatory'],
      visible: dynamicData['is_visible'],
      isDelete: dynamicData['is_delete'],
      moduleName: dynamicData['module_name'],
      customizeUiDetails:
          CustomizeUiDetail().fromMapList(dynamicData['customize_ui_details']),
    );
  }

  @override
  List<CustomField> fromMapList(List<dynamic> dynamicDataList) {
    final List<CustomField> list = <CustomField>[];
    for (dynamic element in dynamicDataList) {
      list.add(CustomField().fromMap(element));
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    return id.toString();
  }

  @override
  Map<String, dynamic>? toMap(CustomField? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['name'] = object.name;
      data['mandatory'] = object.mandatory;
      data['placeholder'] = object.placeHolder;
      data['is_visible'] = object.visible;
      data['is_delete'] = object.isDelete;
      data['module_name'] = object.moduleName;
      data['core_keys_id'] = object.coreKeyId;
      data['ui_type'] = UiType().toMap(object.uiType);
      data['customize_ui_details'] =
          CustomizeUiDetail().toMapList(object.customizeUiDetails!);

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<CustomField> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (CustomField? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }

  void copy(CustomField object) {
    id = object.id;
    name = object.name;
    mandatory = object.mandatory;
    visible = object.visible;
    isDelete = object.isDelete;
    moduleName = object.moduleName;
    placeHolder = object.placeHolder;
    coreKeyId = object.coreKeyId;
    uiType = object.uiType;
    customizeUiDetails = object.customizeUiDetails;
  }

  bool get isMandatory {
    return mandatory == PsConst.ONE;
  }

  bool get isVisible {
    return visible == PsConst.ONE;
  }
}

class UiType extends PsObject<UiType> {
  UiType({
    this.coreKeyId,
    this.id,
    this.name,
  });

  String? id;
  String? name;
  String? coreKeyId;

  @override
  UiType fromMap(dynamic dynamicData) {
    return UiType(
        id: dynamicData['id'],
        coreKeyId: dynamicData['core_keys_id'],
        name: dynamicData['name']);
  }

  @override
  List<UiType> fromMapList(List<dynamic>? dynamicDataList) {
    final List<UiType> list = <UiType>[];
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
  Map<String, dynamic>? toMap(UiType? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['name'] = object.name;
      data['core_keys_id'] = object.coreKeyId;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<UiType> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];

    for (UiType? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }

    return mapList;
  }
}
