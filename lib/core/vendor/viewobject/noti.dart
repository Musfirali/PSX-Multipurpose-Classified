import 'package:quiver/core.dart';

import 'common/ps_object.dart';
import 'default_photo.dart';

class Noti extends PsObject<Noti> {
  Noti(
      {this.id,
      this.type,
      this.description,
      this.message,
      this.addedDate,
      this.addedUserId,
      this.isRead,
      this.itemId,
      this.buyerUserId,
      this.sellerUserId,
      this.userCoverPhoto,
      this.userName,
      this.addedDateStr,
      this.defaultPhoto});

  String? id;
  String? type;
  String? description;
  String? message;
  String? addedDate;
  String? addedUserId;
  String? isRead;
  String? itemId;
  String? buyerUserId;
  String? sellerUserId;
  String? userCoverPhoto;
  String? userName;

  String? addedDateStr;
  DefaultPhoto? defaultPhoto;



  @override
  bool operator ==(dynamic other) => other is Noti && id == other.id;
  @override
  int get hashCode => hash2(id.hashCode, id.hashCode);

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  Noti fromMap(dynamic dynamicData) {
    // if (dynamicData != null) {
    return Noti(
        id: dynamicData['id'],
        type: dynamicData['type'],
        description: dynamicData['description'],
        message: dynamicData['message'],
        addedDate: dynamicData['added_date'],
        addedUserId: dynamicData['added_user_id'],
        isRead: dynamicData['is_read'],
        itemId: dynamicData['item_id'],
        buyerUserId: dynamicData['buyer_user_id'],
        sellerUserId: dynamicData['seller_user_id'],
        userName: dynamicData['sender_name'],
        userCoverPhoto: dynamicData['sender_cover_photo'],
        addedDateStr: dynamicData['added_date_str'],
        defaultPhoto: DefaultPhoto().fromMap(dynamicData['default_photo']));
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(Noti? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['type'] = object.type;
      data['message'] = object.message;
      data['description'] = object.description;
      data['added_date'] = object.addedDate;
      data['added_user_id'] = object.addedUserId;
      data['is_read'] = object.isRead;
      data['item_id'] = object.itemId;
      data['buyer_user_id'] = object.buyerUserId;
      data['seller_user_id'] = object.sellerUserId;
      data['sender_name'] = object.userName;
      data['sender_cover_photo'] = object.userCoverPhoto;
      data['added_date_str'] = object.addedDateStr;
      data['default_photo'] = DefaultPhoto().toMap(object.defaultPhoto);
      return data;
    } else {
      return null;
    }
  }

  @override
  List<Noti> fromMapList(List<dynamic> dynamicDataList) {
    final List<Noti> subCategoryList = <Noti>[];

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
  List<Map<String, dynamic>?> toMapList(List<Noti?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (Noti? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    // }

    return mapList;
  }
}