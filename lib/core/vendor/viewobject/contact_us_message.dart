import 'package:quiver/core.dart';
import 'common/ps_object.dart';

class ContactUsMessage extends PsObject<ContactUsMessage> {
  ContactUsMessage(
      {this.id,
       this.name,
       this.email,
       this.message,
       this.phone,
       this.addedDateStr});

  final String? id;
  final String? name;
  final String? email;
  final String? message;
  final String? phone;
  final String? addedDateStr;

  @override
  bool operator ==(dynamic other) =>
      other is ContactUsMessage && id == other.id;

  @override
  int get hashCode => hash2(id.hashCode, id.hashCode);

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  ContactUsMessage fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return ContactUsMessage(
        id: dynamicData['id'],
        name: dynamicData['contact_name'],
        email: dynamicData['contact_email'],
        message: dynamicData['contact_message'],
        phone: dynamicData['contact_phone'],
        addedDateStr: dynamicData['added_date_str']);
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(dynamic object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['contact_name'] = object.name;
      data['contact_email'] = object.email;
      data['contact_message'] = object.message;
      data['contact_phone'] = object.phone;
      data['added_date_str'] = object.addedDateStr;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<ContactUsMessage> fromMapList(List<dynamic> dynamicDataList) {
    final List<ContactUsMessage> addOnList = <ContactUsMessage>[];

    //if (dynamicDataList != null) {
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        addOnList.add(fromMap(dynamicData));
      }
    }
    // }
    return addOnList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<dynamic> objectList) {
    final List<Map<String, dynamic>?> dynamicList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (dynamic data in objectList) {
      if (data != null) {
        dynamicList.add(toMap(data));
      }
    }
    // }
    return dynamicList;
  }
}
