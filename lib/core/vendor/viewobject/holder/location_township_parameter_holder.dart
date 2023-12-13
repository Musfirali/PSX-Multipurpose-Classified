

import '../../constant/ps_constants.dart';
import '../common/ps_holder.dart';

class LocationTownshipParameterHolder extends PsHolder<dynamic> {
  LocationTownshipParameterHolder() {
    keyword = '';
    cityId = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
  }

  String? keyword;
  String? orderBy;
  String? orderType;
  String? cityId;

  LocationTownshipParameterHolder getDefaultParameterHolder() {
    cityId = '';
    keyword = '';
    orderBy = PsConst.FILTERING__ORDERING;
    orderType = PsConst.FILTERING__DESC;

    return this;
  }

  LocationTownshipParameterHolder getLatestParameterHolder() {
    cityId = '';
    keyword = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;

    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['city_id'] = cityId;
    map['keyword'] = keyword;
    map['order_by'] = orderBy;
    map['order_type'] = orderType;

    return map;
  }

  @override
  dynamic fromMap(dynamic dynamicData) {
    keyword = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    cityId = '';
    return this;
  }

  @override
  String getParamKey() {
    String key = '';

    if (keyword != '') {
      key += keyword!;
    }
    if (orderBy != '') {
      key += orderBy!;
    }
    if (orderType != '') {
      key += orderType!;
    }
    if (cityId != '') {
      key += cityId!;
    }


    return key;
  }
}
