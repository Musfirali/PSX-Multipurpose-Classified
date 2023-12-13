import 'package:quiver/core.dart';

import '../../vendor/viewobject/rating_detail.dart';
import '../constant/ps_constants.dart';
import 'common/ps_object.dart';
import 'user_relation.dart';

class User extends PsObject<User> {
  User(
      {this.userId,
      this.userIsSysAdmin,
      this.emailVerifiedAt,
      this.facebookId,
      this.googleId,
      this.phoneId,
      this.appleId,
      this.name,
      this.userName,
      this.userEmail,
      this.userPhone,
      this.userAddress,
      this.userAboutMe,
      this.userCoverPhoto,
      this.roleId,
      this.needVerify,
      this.isBanned,
      this.code,
      this.overallRating,
      this.isShowEmail,
      this.isShowPhone,
      this.isShopAdmin,
      this.isCityAdmin,
      this.userLat,
      this.userLng,
      this.addedDate,
      this.addedDateTimeStamp,
      this.verifyTypes,
      this.remainingPost,
      this.postCount,
      this.activeItemCount,
      this.ratingCount,
      this.ratingDetail,
      this.followerCount,
      this.followingCount,
      this.isFollowed,
      this.isBlocked,
      this.userRelation,
      // this.city,
      this.isVerifyBlueMark,
      this.addedDateStr});

  String? userId;
  String? userIsSysAdmin;
  String? emailVerifiedAt;
  String? facebookId;
  String? googleId;
  String? phoneId;
  String? appleId;
  String? name;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userAddress;
  String? userAboutMe;
  String? userCoverPhoto;
  String? roleId;
  String? needVerify;
  String? isBanned;
  String? code;
  String? overallRating;
  String? isShowEmail;
  String? isShowPhone;
  String? isShopAdmin;
  String? isCityAdmin;
  String? userLat;
  String? userLng;
  String? addedDate;
  String? addedDateTimeStamp;
  String? verifyTypes;
  String? remainingPost;
  String? postCount;
  String? activeItemCount;
  String? ratingCount;
  RatingDetail? ratingDetail;
  String? followerCount;
  String? followingCount;
  String? isFollowed;
  String? isBlocked;
  List<UserRelation>? userRelation;
  // String? city;
  String? isVerifyBlueMark;
  String? addedDateStr;

  @override
  bool operator ==(dynamic other) => other is User && userId == other.userId;

  @override
  int get hashCode {
    return hash2(userId.hashCode, userId.hashCode);
  }

  @override
  String getPrimaryKey() {
    return userId ?? '';
  }

  @override
  User fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return User(
        userId: dynamicData['id'],
        userIsSysAdmin: dynamicData['user_is_sys_admin'],
        emailVerifiedAt: dynamicData['email_verified_at'],
        facebookId: dynamicData['facebook_id'],
        googleId: dynamicData['google_id'],
        phoneId: dynamicData['phone_id'],
        appleId: dynamicData['apple_id'],
        name: dynamicData['name'],
        userName: dynamicData['username'],
        userEmail: dynamicData['email'],
        userPhone: dynamicData['user_phone'],
        userAddress: dynamicData['user_address'],
        userCoverPhoto: dynamicData['user_cover_photo'],
        userAboutMe: dynamicData['user_about_me'],
        roleId: dynamicData['role_id'],
        needVerify: dynamicData['need_verify'],
        isBanned: dynamicData['is_banned'],
        code: dynamicData['has_code'],
        overallRating: dynamicData['overall_rating'],
        isShowEmail: dynamicData['is_show_email'],
        isShowPhone: dynamicData['is_show_phone'],
        isCityAdmin: dynamicData['is_city_admin'],
        userLat: dynamicData['user_lat'],
        userLng: dynamicData['user_lng'],
        addedDate: dynamicData['added_date'],
        addedDateTimeStamp: dynamicData['added_date_timestamp'],
        verifyTypes: dynamicData['verify_types'],
        remainingPost: dynamicData['remaining_post'], // * to add
        postCount: dynamicData['post_count'],
        activeItemCount: dynamicData['active_item_count'],
        ratingCount: dynamicData['rating_count'],
        ratingDetail: RatingDetail().fromMap(dynamicData['rating_details']),
        followerCount: dynamicData['follower_count'],
        followingCount: dynamicData['following_count'],
        isFollowed: dynamicData['is_followed'],
        isBlocked: dynamicData['is_blocked'],
        userRelation: UserRelation().fromMapList(dynamicData['userRelation']),
        isVerifyBlueMark: dynamicData['is_verify_blue_mark'],
      );
    } else {
      return User();
    }
  }

  @override
  Map<String, dynamic>? toMap(User object) {
    // if (object != null) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = object.userId;
    data['user_is_sys_admin'] = object.userIsSysAdmin;
    data['email_verified_at'] = object.emailVerifiedAt;
    data['facebook_id'] = object.facebookId;
    data['google_id'] = object.googleId;
    data['phone_id'] = object.phoneId;
    data['apple_id'] = object.appleId;
    data['name'] = object.name;
    data['username'] = object.userName;
    data['email'] = object.userEmail;
    data['user_phone'] = object.userPhone;
    data['user_address'] = object.userAddress;
    data['user_about_me'] = object.userAboutMe;
    data['user_cover_photo'] = object.userCoverPhoto;
    data['role_id'] = object.roleId;
    data['need_verify'] = object.needVerify;
    data['is_banned'] = object.isBanned;
    data['has_code'] = object.code;
    data['overall_rating'] = object.overallRating;
    data['is_show_email'] = object.isShowEmail;
    data['is_show_phone'] = object.isShowPhone;
    data['is_city_admin'] = object.isCityAdmin;
    data['user_lat'] = object.userLat;
    data['user_lng'] = object.userLng;
    data['added_date'] = object.addedDate;
    data['added_date_timestamp'] = object.addedDateTimeStamp;
    data['verify_types'] = object.verifyTypes;
    data['remaining_post'] = object.remainingPost;
    data['post_count'] = object.postCount;
    data['active_item_count'] = object.activeItemCount;
    data['rating_count'] = object.ratingCount;
    data['rating_details'] = RatingDetail().toMap(object.ratingDetail);
    data['follower_count'] = object.followerCount;
    data['following_count'] = object.followingCount;
    data['is_followed'] = object.isFollowed;
    data['is_blocked'] = object.isBlocked;
    data['userRelation'] = UserRelation().toMapList(object.userRelation!);
    data['is_verify_blue_mark'] = object.isVerifyBlueMark;

    return data;
  }

  @override
  List<User> fromMapList(List<dynamic> dynamicDataList) {
    final List<User> subUserList = <User>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<User> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (User? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }

  bool get showPhone {
    return isShowPhone == PsConst.ONE;
  }

  bool get hasPhone {
    return userPhone != null && userPhone != '';
  }

  bool get showEmail {
    return userEmail != null && userEmail != '' && isShowEmail == PsConst.ONE;
  }

  bool get isVefifiedBlueMarkUser {
    return isVerifyBlueMark == PsConst.ONE;
  }

  bool get isUserWaitingForApproval {
    return isVerifyBlueMark == PsConst.TWO;
  }

  bool get isRejectedUser {
    return isVerifyBlueMark == PsConst.THREE;
  }

  bool get isNormalUser {
    return isVerifyBlueMark == PsConst.ZERO;
  }

  bool isOwnUserData(String loginUserId) {
    return loginUserId == userId;
  }
}
