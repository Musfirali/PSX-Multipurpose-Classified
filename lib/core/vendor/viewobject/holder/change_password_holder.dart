
import '../common/ps_holder.dart';

class ChangePasswordParameterHolder
    extends PsHolder<ChangePasswordParameterHolder> {
  ChangePasswordParameterHolder(
      {required this.userId, required this.userPassword, this.confPassword, this.oldPassword});

  final String? userId;
  final String? userPassword;
  final String? confPassword;
  final String? oldPassword;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['user_id'] = userId;
    map['user_password'] = userPassword;
    map['conf_password'] = confPassword;
    map['old_password'] = oldPassword;

    return map;
  }

  @override
  ChangePasswordParameterHolder fromMap(dynamic dynamicData) {
    return ChangePasswordParameterHolder(
      userId: dynamicData['user_id'],
      userPassword: dynamicData['user_password'],
      confPassword: dynamicData['conf_password'],
      oldPassword: dynamicData['old_password']
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userId != '') {
      key += userId!;
    }
    if (userPassword != '') {
      key += userPassword!;
    }
    if (confPassword != ''){
      key += confPassword!;
    }
    if (oldPassword != ''){
      key += oldPassword!;
    }
    return key;
  }
}
