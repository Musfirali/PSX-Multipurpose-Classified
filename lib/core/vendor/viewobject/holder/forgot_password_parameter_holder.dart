

import '../common/ps_holder.dart';

class ForgotPasswordParameterHolder
    extends PsHolder<ForgotPasswordParameterHolder> {
  ForgotPasswordParameterHolder({required this.userEmail});

  final String? userEmail;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['email'] = userEmail;

    return map;
  }

  @override
  ForgotPasswordParameterHolder fromMap(dynamic dynamicData) {
    return ForgotPasswordParameterHolder(
      userEmail: dynamicData['emailemail'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userEmail != '') {
      key += userEmail!;
    }
    return key;
  }
}
