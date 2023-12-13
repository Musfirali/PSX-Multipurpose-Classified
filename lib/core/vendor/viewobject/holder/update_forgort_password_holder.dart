
import '../common/ps_holder.dart';

class UpdateForgotPasswordParameterHolder
    extends PsHolder<UpdateForgotPasswordParameterHolder> {
  UpdateForgotPasswordParameterHolder(
      {required this.userId, required this.userPassword,required this.code,required this.confPassword});

  final String? userId;
  final String? userPassword;
  final String? confPassword;
  final String? code;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['user_id'] = userId;
    map['user_password'] = userPassword;
    map['conf_password'] = confPassword;
    map['code'] = code;

    return map;
  }

  @override
  UpdateForgotPasswordParameterHolder fromMap(dynamic dynamicData) {
    return UpdateForgotPasswordParameterHolder(
      userId: dynamicData['user_id'],
      userPassword: dynamicData['user_password'],
      confPassword: dynamicData['conf_password'],
      code: dynamicData['code'],
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

        if (confPassword != '') {
      key += confPassword!;
    }

        if (code != '') {
      key += code!;
    }
    return key;
  }
}
