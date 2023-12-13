import 'common/ps_holder.dart';

class ForgotPasswordVerifyParameterHolder extends PsHolder<ForgotPasswordVerifyParameterHolder> {
  ForgotPasswordVerifyParameterHolder({
    required this.userEmail, 
    required this.code});

  final String? userEmail;
  final String? code;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['email'] = userEmail;
    map['code'] = code;

    return map;
  }

  @override
  ForgotPasswordVerifyParameterHolder fromMap(dynamic dynamicData) {
    return ForgotPasswordVerifyParameterHolder(
      userEmail: dynamicData['email'],
      code: dynamicData['code'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userEmail != '') {
      key += userEmail!;
    }
    if (code != '') {
      key += code!;
    }
    return key;
  }
}
