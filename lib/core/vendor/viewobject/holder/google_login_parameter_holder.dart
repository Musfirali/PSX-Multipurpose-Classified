import '../common/ps_holder.dart';

class GoogleLoginParameterHolder extends PsHolder<GoogleLoginParameterHolder> {
  GoogleLoginParameterHolder(
      {required this.googleId,
      required this.userName,
      required this.userEmail,
      required this.profilePhotoUrl,
      required this.deviceToken,
      required this.platformName,
      required this.deviceInfo,
      required this.deviceId,
      });

  final String? googleId;
  final String? userName;
  final String? userEmail;
  final String? profilePhotoUrl;
  final String? deviceToken;
  final String? platformName;
  final String? deviceInfo;
  final String? deviceId;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['google_id'] = googleId;
    map['name'] = userName;
    map['email'] = userEmail;
    map['profile_photo_url'] = profilePhotoUrl;
    map['device_token'] = deviceToken;
    map['platform_name'] = platformName;
    map['device_info'] = deviceInfo;
    map['device_id'] = deviceId;

    return map;
  }

  @override
  GoogleLoginParameterHolder fromMap(dynamic dynamicData) {
    return GoogleLoginParameterHolder(
      googleId: dynamicData['google_id'],
      userName: dynamicData['name'],
      userEmail: dynamicData['email'],
      profilePhotoUrl: dynamicData['profile_photo_url'],
      deviceToken: dynamicData['device_token'],
      platformName: dynamicData['platform_name'],
      deviceInfo: dynamicData['device_info'],
      deviceId: dynamicData['device_id']
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userName != '') {
      key += userName!;
    }
    if (userEmail != '') {
      key += userEmail!;
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
