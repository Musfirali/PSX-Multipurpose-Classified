

import '../common/ps_holder.dart';

class UserNameStatusParameterHolder
    extends PsHolder<UserNameStatusParameterHolder> {
  UserNameStatusParameterHolder({
    this.userPhone = '',
    required this.loginMethod,
    this.email = '',
  });

  final String? userPhone;
  final String? loginMethod;
  final String? email;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['user_phone'] = userPhone;
    map['loginMethod'] = loginMethod;
    map['email'] = email;
    return map;
  }

  @override
  UserNameStatusParameterHolder fromMap(dynamic dynamicData) {
    return UserNameStatusParameterHolder(
      userPhone: dynamicData['user_phone'],
      loginMethod: dynamicData['loginMethod'],
      email: dynamicData['email']
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userPhone != '') {
      key += userPhone!;
    }
    if (loginMethod != '') {
      key += loginMethod ?? '';
    }
    if (email != '') {
      key += email ?? '';
    }

    return key;
  }
}
