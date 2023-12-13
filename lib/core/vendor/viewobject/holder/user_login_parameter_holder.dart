import '../common/ps_holder.dart';

class UserLoginParameterHolder extends PsHolder<UserLoginParameterHolder> {
  UserLoginParameterHolder(
      {required this.userEmail,
      required this.userPassword,
      required this.deviceToken,
      required this.platformName,
      required this.deviceInfo,
      required this.deviceId,
      });

  final String? userEmail;
  final String? userPassword;
  final String? deviceToken;
  final String? platformName;
  final String? deviceInfo;
  final String? deviceId;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['email'] = userEmail;
    map['password'] = userPassword;
    map['device_token'] = deviceToken;
    map['platform_name'] = platformName;
    map['device_info'] = deviceInfo;
    map['device_id'] = deviceId;

    return map;
  }

  @override
  UserLoginParameterHolder fromMap(dynamic dynamicData) {
    return UserLoginParameterHolder(
      userEmail: dynamicData['email'],
      userPassword: dynamicData['password'],
      deviceToken: dynamicData['device_token'],
      platformName: dynamicData['platform_name'],
      deviceInfo: dynamicData['device_info'],
      deviceId: dynamicData['device_id']
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userEmail != '') {
      key += userEmail!;
    }
    if (userPassword != '') {
      key += userPassword!;
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
