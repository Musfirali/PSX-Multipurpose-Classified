

import '../common/ps_holder.dart';

class UserNameAndPwdHolder
    extends PsHolder<UserNameAndPwdHolder> {
  UserNameAndPwdHolder({
    required this.userId,
    required this.userName,
    required this.password,
  });

  final String? userId;
  final String? userName;
  final String? password;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['user_id'] = userId;
    map['username'] = userName;
    map['password'] = password;
    return map;
  }

  @override
  UserNameAndPwdHolder fromMap(dynamic dynamicData) {
    return UserNameAndPwdHolder(
      userId: dynamicData['user_id'],
      userName: dynamicData['username'],
      password: dynamicData['password']
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userId != '') {
      key += userId!;
    }
    if (userName != '') {
      key += userName ?? '';
    }
    if (password != '') {
      key += password ?? '';
    }

    return key;
  }
}
