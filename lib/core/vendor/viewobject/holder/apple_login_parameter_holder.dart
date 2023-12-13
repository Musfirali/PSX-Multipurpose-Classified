
import '../common/ps_holder.dart';

class AppleLoginParameterHolder extends PsHolder<AppleLoginParameterHolder> {
  AppleLoginParameterHolder(
      {required this.appleId,
      required this.name,
      required this.email,
      required this.profilePhotoUrl,
      required this.deviceToken,
      required this.platformName,
      required this.deviceInfo,
      required this.deviceId,
    });

  final String? appleId;
  final String? name;
  final String? email;
  final String? profilePhotoUrl;
  final String? deviceToken;
  final String? platformName;
  final String? deviceInfo;
  final String? deviceId;


  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['apple_id'] = appleId;
    map['name'] = name;
    map['email'] = email;
    map['profile_photo_url'] = profilePhotoUrl;
    map['device_token'] = deviceToken;
    map['platform_name'] = platformName;
    map['device_info'] = deviceInfo;
    map['device_id'] = deviceId;

    return map;
  }

  @override
  AppleLoginParameterHolder fromMap(dynamic dynamicData) {
    return AppleLoginParameterHolder(
      appleId: dynamicData['apple_id'],
      name: dynamicData['name'],
      email: dynamicData['email'],
      profilePhotoUrl: dynamicData['profile_photo_url'],
      deviceToken: dynamicData['device_token'],
      platformName: dynamicData['platform_name'],
      deviceInfo: dynamicData['device_info'],
      deviceId: dynamicData['device_id'],
      
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (appleId != '') {
      key += appleId!;
    }
    if (name != '') {
      key += name!;
    }

    if (email != '') {
      key += email!;
    }

    if (profilePhotoUrl != '') {
      key += profilePhotoUrl!;
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

