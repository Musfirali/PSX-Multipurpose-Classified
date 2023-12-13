

import '../common/ps_holder.dart';

class FBLoginParameterHolder extends PsHolder<FBLoginParameterHolder> {
  FBLoginParameterHolder(
      {required this.facebookId,
      required this.name,
      required this.email,
      required this.profileImgId,
      required this.deviceToken,
      required this.platformName,
      required this.deviceInfo,
      required this.deviceId,
    });

  final String? facebookId;
  final String? name;
  final String? email;
  final String? profileImgId;
  final String? deviceToken;
  final String? platformName;
  final String? deviceInfo;
  final String? deviceId;


  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['facebook_id'] = facebookId;
    map['name'] = name;
    map['email'] = email;
    map['profile_img_id'] = profileImgId;
    map['device_token'] = deviceToken;
    map['platform_name'] = platformName;
    map['device_info'] = deviceInfo;
    map['device_id'] = deviceId;

    return map;
  }

  @override
  FBLoginParameterHolder fromMap(dynamic dynamicData) {
    return FBLoginParameterHolder(
      facebookId: dynamicData['facebook_id'],
      name: dynamicData['user_name'],
      email: dynamicData['user_email'],
      profileImgId: dynamicData['profile_img_id'],
      deviceToken: dynamicData['device_token'],
      platformName: dynamicData['platform_name'],
      deviceInfo: dynamicData['device_info'],
      deviceId: dynamicData['device_id'],
      
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (facebookId != '') {
      key += facebookId!;
    }
    if (name != '') {
      key += name!;
    }

    if (email != '') {
      key += email!;
    }

    if (profileImgId != '') {
      key += profileImgId!;
    }

    if (deviceToken != '') {
      key += deviceToken!;
    }

    if (platformName != '') {
      key += platformName!;
    }

    if (deviceInfo != '') {
      key += deviceInfo!;
    }

    if (deviceId != '') {
      key += deviceId!;
    }
    return key;
  }
}
