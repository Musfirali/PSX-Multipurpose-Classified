
import '../../constant/ps_constants.dart';
import '../common/ps_holder.dart';

class BlogParameterHolder extends PsHolder<BlogParameterHolder> {
  BlogParameterHolder() {
    keyword = '';
    cityId = '';
    orderBy = PsConst.FILTERING__NAME;
    orderType = PsConst.FILTERING__DESC;
  }

  String? keyword;
  String? cityId;
  String? orderBy;
  String? orderType;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['keyword'] = keyword;
    map['location_city_id'] = cityId;
    map['order_by'] = orderBy;
    map['order_type'] = orderType;

    return map;
  }

  @override
  BlogParameterHolder fromMap(dynamic dynamicData) {
    keyword = '';
    cityId = '';
    orderBy = '';
    orderType = '';
    return this;
  }

  @override
  String getParamKey() {
    String key = '';

    if (keyword != '') {
      key += keyword! + ':';
    }
    if (cityId != '') {
      key += cityId ?? '';
    }
    if (orderBy != '') {
      key += orderBy ?? '';
    }
    if (orderType != '') {
      key += orderType ?? '';
    }
    return key;
  }
}
