import '../common/ps_holder.dart';

class AllSearchParameterHolder extends PsHolder<AllSearchParameterHolder> {
  AllSearchParameterHolder({
    this.keyword,
    this.type,
  });

  String? keyword;
  String? type;

  AllSearchParameterHolder getDefaultParameterHolder() {
    return AllSearchParameterHolder(keyword: '', type: 'all');
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['keyword'] = keyword;
    map['type'] = type;

    return map;
  }

  @override
  AllSearchParameterHolder fromMap(dynamic dynamicData) {
    return AllSearchParameterHolder(
      keyword: dynamicData['keyword'],
      type: dynamicData['type'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (keyword != '') {
      key += keyword!;
    }
    if (type != '') {
      key += type!;
    }
    return key;
  }
}
