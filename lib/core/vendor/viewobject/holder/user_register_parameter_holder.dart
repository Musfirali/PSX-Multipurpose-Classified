import '../common/ps_holder.dart';

class UserRegisterParameterHolder
    extends PsHolder<UserRegisterParameterHolder> {
  UserRegisterParameterHolder(
      {required this.name,
      required this.userName,
      required this.userEmail,
      required this.userPassword,
      required this.userPhone,
      required this.deviceToken,
      required this.platformName,
      required this.deviceInfo,
      required this.deviceId
      });

  final String? name;
  final String? userName;
  final String? userEmail;
  final String? userPassword;
  final String? userPhone;
  final String? deviceToken;
  final String? platformName;
  final String? deviceInfo;
  final String? deviceId;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['name'] = name;
    map['username'] = userName;
    map['email'] = userEmail;
    map['password'] = userPassword;
    map['user_phone'] = userPhone;
    map['device_token'] = deviceToken;
    map['platform_name'] = platformName;
    map['device_info'] = deviceInfo;
    map['device_id'] = deviceId;

    return map;
  }

  @override
  UserRegisterParameterHolder fromMap(dynamic dynamicData) {
    return UserRegisterParameterHolder(
      name: dynamicData['name'],
      userName: dynamicData['username'],
      userEmail: dynamicData['email'],
      userPassword: dynamicData['password'],
      userPhone: dynamicData['user_phone'],
      deviceToken: dynamicData['device_token'],
      platformName: dynamicData['platform_name'],
      deviceInfo: dynamicData['device_info'],
      deviceId: dynamicData['device_id']
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (name != '') {
      key += name!;
    }
        if (userName != '') {
      key += userName!;
    }
    if (userEmail != '') {
      key += userEmail!;
    }
    if (userPassword != '') {
      key += userPassword!;
    }
    if (userPhone != '') {
      key += userPhone!;
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
