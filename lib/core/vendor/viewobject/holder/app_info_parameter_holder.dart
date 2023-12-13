import '../common/ps_holder.dart';

class AppInfoParameterHolder extends PsHolder<AppInfoParameterHolder> {
  AppInfoParameterHolder({
    required this.languageCode,
    required this.countryCode,
  });

  final String? languageCode;
  final String? countryCode;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['langauge_code'] = languageCode;
    map['country_code'] = countryCode;

    return map;
  }

  @override
  AppInfoParameterHolder fromMap(dynamic dynamicData) {
    return AppInfoParameterHolder(
      languageCode: dynamicData['langauge_code'],
      countryCode: dynamicData['country_code'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (languageCode != '') {
      key += languageCode!;
    }
    if (countryCode != '') {
      key += countryCode!;
    }
    return key;
  }
}
