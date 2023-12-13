import 'common/ps_object.dart';
class UserUnreadMessage extends PsObject<UserUnreadMessage> {
  UserUnreadMessage(
      {
        //this.id,
      this.buyerUnreadCount,
      this.sellerUnreadCount,
      this.notiUnreadCount});
 // String? id;
  String? buyerUnreadCount;
  String? sellerUnreadCount;
  String? notiUnreadCount;

  // @override
  // bool operator ==(dynamic other) =>
  //     other is UserUnreadMessage && id == other.id;

  // @override
  // int get hashCode {
  //   return hash2(id.hashCode, id.hashCode);
  // }

  @override
  String getPrimaryKey() {
    return '';
  }

  @override
  UserUnreadMessage fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return UserUnreadMessage(
       // id: dynamicData['id'],
        buyerUnreadCount: dynamicData['buyer_unread_count'],
        sellerUnreadCount: dynamicData['seller_unread_count'],
        notiUnreadCount: dynamicData['noti_unread_count'],
      );
    } else {
      return UserUnreadMessage();
    }
  }

  @override
  Map<String, dynamic> toMap(UserUnreadMessage object) {
    //if (object != null) {
    final Map<String, dynamic> data = <String, dynamic>{};
   // data['id'] = object.id;
    data['buyer_unread_count'] = object.buyerUnreadCount;
    data['seller_unread_count'] = object.sellerUnreadCount;
    data['noti_unread_count'] = object.notiUnreadCount;

    return data;
    // } else {
    //   return null;
    // }
  }

  @override
  List<UserUnreadMessage> fromMapList(List<dynamic> dynamicDataList) {
    final List<UserUnreadMessage> blogList = <UserUnreadMessage>[];

    // if (dynamicDataList != null) {
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        blogList.add(fromMap(dynamicData));
      }
    }
    // }
    return blogList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<UserUnreadMessage?> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    // if (objectList != null) {
    for (UserUnreadMessage? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    // }
    return mapList;
  }
}
