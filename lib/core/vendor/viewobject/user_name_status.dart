import 'package:quiver/core.dart';

import 'common/ps_object.dart';

class UserNameStatus extends PsObject<UserNameStatus?> {
  UserNameStatus({
    this.status,
    this.message,
  });

  String? status;
  MessageObj? message;

  @override
  bool operator ==(dynamic other) =>
      other is UserNameStatus && status == other.status;

  @override
  int get hashCode => hash2(status.hashCode, status.hashCode);

  @override
  String? getPrimaryKey() {
    return status;
  }

  @override
  UserNameStatus? fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return UserNameStatus(
        status: dynamicData['status'],
        message: MessageObj().fromMap(dynamicData['message']),
      );
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toMap(UserNameStatus? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['status'] = object.status;
      data['message'] = object.message;

      return data;
    } else {
      return null;
    }
  }

    @override
  List<UserNameStatus?> fromMapList(List<dynamic> dynamicDataList) {
    final List<UserNameStatus?> subCategoryList = <UserNameStatus?>[];

    // if (dynamicDataList != null) {
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subCategoryList.add(fromMap(dynamicData));
      }
    }
    // }
    return subCategoryList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<UserNameStatus?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (UserNameStatus? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    // }
    return mapList;
  }
}

class MessageObj extends PsObject<MessageObj?> {
  MessageObj({
    this.isUserNameExisted,
    this.hasPassword
  });

  String? isUserNameExisted;
  String? hasPassword;

  @override
  bool operator ==(dynamic other) =>
      other is MessageObj && isUserNameExisted == other.isUserNameExisted;

  @override
  int get hashCode => hash2(isUserNameExisted.hashCode, isUserNameExisted.hashCode);

  @override
  String? getPrimaryKey() {
    return isUserNameExisted;
  }

  @override
  MessageObj? fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return MessageObj(
        isUserNameExisted: dynamicData['user_isexisted'],
        hasPassword: dynamicData['hasPassword'],
      );
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toMap(MessageObj? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['user_isexisted'] = object.isUserNameExisted;
      data['hasPassword'] = object.hasPassword;
      return data;
    } else {
      return null;
    }
  }

    @override
  List<MessageObj?> fromMapList(List<dynamic> dynamicDataList) {
    final List<MessageObj?> subCategoryList = <MessageObj?>[];

    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subCategoryList.add(fromMap(dynamicData));
      }
    }
    return subCategoryList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<MessageObj?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (MessageObj? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
