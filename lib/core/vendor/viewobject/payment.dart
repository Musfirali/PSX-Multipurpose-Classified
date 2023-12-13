import 'package:quiver/core.dart';
import 'common/ps_object.dart';

class Payment extends PsObject<Payment> {
  Payment({
    this.id,
    this.name,
    this.description,
    this.status,
    this.addedDateStr,
  });

  String? id;
  String? name;
  String? description;
  String? status;
  String? addedDateStr;


  @override
  bool operator ==(dynamic other) => other is Payment && id == other.id;

  @override
  int get hashCode {
    return hash2(id.hashCode, id.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  Payment fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return Payment(
      id : dynamicData['id'],
      name: dynamicData['name'],
      description: dynamicData['description'],
      status: dynamicData['status'],
      addedDateStr: dynamicData['added_date_str'],
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(Payment? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['name'] = object.name;
      data['description'] = object.description;
      data['status'] = object.status;
      data['added_date_str'] = object.addedDateStr;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<Payment> fromMapList(List<dynamic> dynamicDataList) {
    final List<Payment> blogList = <Payment>[];

    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        blogList.add(fromMap(dynamicData));
      }
    }
    return blogList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Payment?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (Payment? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}