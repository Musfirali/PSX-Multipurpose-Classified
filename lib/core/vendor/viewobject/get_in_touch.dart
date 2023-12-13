import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class GetInTouch extends PsObject<GetInTouch> {
  GetInTouch({this.aboutEmail, this.aboutPhone, this.aboutAddress});

  String? aboutEmail;
  String? aboutPhone;
  String? aboutAddress;

  @override
  bool operator ==(dynamic other) =>
      other is GetInTouch && aboutEmail == other.aboutEmail;

  @override
  int get hashCode {
    return hash2(aboutEmail.hashCode, aboutEmail.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return '';
  }

  @override
  GetInTouch fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return GetInTouch(
      aboutEmail: dynamicData['about_email'],
      aboutPhone: dynamicData['about_phone'],
      aboutAddress: dynamicData['about_address'],
    );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(GetInTouch? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['about_email'] = object.aboutEmail;
      data['about_phone'] = object.aboutPhone;
      data['about_address'] = object.aboutAddress;
      return data;
    } else {
      return null;
    }
  }

  @override
  List<GetInTouch> fromMapList(List<dynamic> dynamicDataList) {
    final List<GetInTouch> blogList = <GetInTouch>[];

    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        blogList.add(fromMap(dynamicData));
      }
    }
    return blogList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<GetInTouch?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (GetInTouch? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
