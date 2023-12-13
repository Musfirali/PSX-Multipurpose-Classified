import 'package:quiver/core.dart';
import 'common/ps_object.dart';
import 'to_user.dart';
import 'transaction_header.dart';
import 'user.dart';

class DeliveryBoyRating extends PsObject<DeliveryBoyRating> {
  DeliveryBoyRating({
    this.id,
    this.transactionHeaderId,
    this.fromUserId,
    this.toUserId,
    this.rating,
    this.title,
    this.description,
    this.addedDate,
    this.user,
    this.toUser,
    this.addedDateStr,
    this.transactionHeader,
  });
  String? id;
  String? transactionHeaderId;
  String? fromUserId;
  String? toUserId;
  String? rating;
  String? title;
  String? description;
  String? addedDate;
  User? user;
  ToUser? toUser;
  String? addedDateStr;
  TransactionHeader? transactionHeader;

  @override
  bool operator ==(dynamic other) => other is DeliveryBoyRating && id == other.id;

  @override
  int get hashCode {
    return hash2(id.hashCode, id.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return id;
  }

  @override
  DeliveryBoyRating fromMap(dynamic dynamicData) {
    //if (dynamicData != null) {
      return DeliveryBoyRating(
        id: dynamicData['id'],
        transactionHeaderId: dynamicData['transactions_header_id'],
        fromUserId: dynamicData['from_user_id'],
        toUserId: dynamicData['to_user_id'],
        rating: dynamicData['rating'],
        title: dynamicData['title'],
        description: dynamicData['description'],
        addedDate: dynamicData['added_date'], 
        user: User().fromMap(dynamicData['user']),
        toUser: ToUser().fromMap(dynamicData['to_user']),
        addedDateStr: dynamicData['added_date_str'],
        transactionHeader: TransactionHeader().fromMap(dynamicData['transactions_header']),
      );
    // } else {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toMap(DeliveryBoyRating? object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['id'] = object.id;
      data['transactions_header_id'] = object.transactionHeaderId;
      data['from_user_id'] = object.fromUserId;
      data['to_user_id'] = object.toUserId;
      data['rating'] = object.rating;
      data['title'] = object.title;
      data['description'] = object.description;
      data['added_date'] = object.addedDate;
      data['user'] = User().toMap(object.user!);
      data['to_user'] = ToUser().toMap(object.toUser!);
      data['added_date_str'] = object.addedDateStr;
      data['transactions_header'] = TransactionHeader().toMap(object.transactionHeader);
      return data;
    } else {
      return null;
    }
  }

  @override
  List<DeliveryBoyRating> fromMapList(List<dynamic> dynamicDataList) {
    final List<DeliveryBoyRating> commentList = <DeliveryBoyRating>[];

    //if (dynamicDataList != null) {
      for (dynamic dynamicData in dynamicDataList) {
        if (dynamicData != null) {
          commentList.add(fromMap(dynamicData));
        }
      }
   // }
    return commentList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<DeliveryBoyRating> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    //if (objectList != null) {
      for (DeliveryBoyRating? data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
   // }

    return mapList;
  }
}
