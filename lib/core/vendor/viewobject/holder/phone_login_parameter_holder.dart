

import '../common/ps_holder.dart';

class PhoneLoginParameterHolder extends PsHolder<PhoneLoginParameterHolder> {
  PhoneLoginParameterHolder(
      {required this.phoneId,
      required this.userName,
      required this.userPhone,
      required this.deviceToken,
      required this.platformName,
      required this.deviceInfo,
      required this.deviceId,});

  final String? phoneId;
  final String? userName;
  final String? userPhone;
  final String? deviceToken;
  final String? platformName;
  final String? deviceInfo;
  final String? deviceId;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['phone_id'] = phoneId;
    map['name'] = userName;
    map['user_phone'] = userPhone;
    map['device_token'] = deviceToken;
    map['platform_name'] = platformName;
    map['device_info'] = deviceInfo;
    map['device_id'] = deviceId;

    return map;
  }

  @override
  PhoneLoginParameterHolder fromMap(dynamic dynamicData) {
    return PhoneLoginParameterHolder(
      phoneId: dynamicData['phone_id'],
      userName: dynamicData['name'],
      userPhone: dynamicData['user_phone'],
      deviceToken: dynamicData['device_token'],
      platformName: dynamicData['platform_name'],
      deviceInfo: dynamicData['device_info'],
      deviceId: dynamicData['device_id'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userName != '') {
      key += userName!;
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
