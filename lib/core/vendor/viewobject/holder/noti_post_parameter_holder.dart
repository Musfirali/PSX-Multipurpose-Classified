import '../common/ps_holder.dart';

class NotiPostParameterHolder extends PsHolder<NotiPostParameterHolder> {
  NotiPostParameterHolder(
      {required this.notiId,
      required this.userId,
      this.notiType,
      required this.deviceToken});

  final String? notiId;
  final String? userId;
  final String? notiType;
  final String? deviceToken;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['noti_id'] = notiId;
    map['user_id'] = userId;
    map['noti_type'] = notiType;
    map['device_token'] = deviceToken;

    return map;
  }

  @override
  NotiPostParameterHolder fromMap(dynamic dynamicData) {
    return NotiPostParameterHolder(
      notiId: dynamicData['noti_id'],
      userId: dynamicData['user_id'],
      notiType: dynamicData['noti_type'],
      deviceToken: dynamicData['device_token'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (notiId != '') {
      key += notiId!;
    }
    if (userId != '') {
      key += userId!;
    }

    if (deviceToken != '') {
      key += deviceToken!;
    }
    return key;
  }
}
