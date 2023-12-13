

import '../common/ps_holder.dart';

class TouchCountParameterHolder extends PsHolder<TouchCountParameterHolder> {
  TouchCountParameterHolder({required this.typeId, required this.userId,required this.typeName});

  final String? typeId;
  final String? userId;
  final String? typeName;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['type_id'] = typeId;
    map['user_id'] = userId;
    map['type_name'] = typeName;
    return map;
  }

  @override
  TouchCountParameterHolder fromMap(dynamic dynamicData) {
    return TouchCountParameterHolder(
      typeId: dynamicData['type_id'],
      userId: dynamicData['user_id'],
      typeName: dynamicData['type_name']
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (typeId != '') {
      key += typeId!;
    }

    if (userId != '') {
      key += userId!;
    }
        if (typeName != '') {
      key += typeName!;
    }
    return key;
  }
}
