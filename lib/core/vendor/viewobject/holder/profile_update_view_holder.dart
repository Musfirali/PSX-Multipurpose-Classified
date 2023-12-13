

import 'package:psxmpc/core/vendor/viewobject/edit_profile_user_relation.dart';

import '../common/ps_holder.dart';

class ProfileUpdateParameterHolder
    extends PsHolder<ProfileUpdateParameterHolder> {
  ProfileUpdateParameterHolder({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userAboutMe,
    required this.isShowEmail,
    required this.isShowPhone,
    required this.userRelation,
    // required this.userAddress,
    // required this.city,
    // required this.deviceToken,
  });

  final String? userId;
  final String? userName;
  final String? userEmail;
  final String? userPhone;
  final String? userAboutMe;
  final String? isShowEmail;
  final String? isShowPhone;
  final  List<EditProfileUserRelation>? userRelation;
  // final String? userAddress;
  // final String? city;
  // final String? deviceToken;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['user_id'] = userId;
    map['name'] = userName;
    map['email'] = userEmail;
    map['user_phone'] = userPhone;
    map['user_about_me'] = userAboutMe;
    map['is_show_email'] = isShowEmail;
    map['is_show_phone'] = isShowPhone;
    map['user_relation'] = EditProfileUserRelation().toMapList(userRelation!);
    // map['user_address'] = userAddress;
    // map['city'] = city;
    // map['device_token'] = deviceToken;

    return map;
  }

  @override
  ProfileUpdateParameterHolder fromMap(dynamic dynamicData) {
    return ProfileUpdateParameterHolder(
      userId: dynamicData['user_id'],
      userName: dynamicData['namename'],
      userEmail: dynamicData['email'],
      userPhone: dynamicData['user_phone'],
      userAboutMe: dynamicData['user_about_me'],
      isShowEmail: dynamicData['is_show_email'],
      isShowPhone: dynamicData['is_show_phone'],
      userRelation: dynamicData['user_relation'],
      // userAddress: dynamicData['user_address'],
      // city: dynamicData['city'],
      // deviceToken: dynamicData['device_token'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userId != '') {
      key += userId!;
    }
    if (userName != '') {
      key += userName!;
    }

    if (userEmail != '') {
      key += userEmail!;
    }
    if (userPhone != '') {
      key += userPhone!;
    }

    if (userAboutMe != '') {
      key += userAboutMe!;
    }


    // if (userRelation != '') {
    //   key += userRelation!;
    // }
    if (isShowEmail != '') {
      key += isShowEmail!;
    }
    if (isShowPhone != '') {
      key += isShowPhone!;
    }
    return key;
  }
}
