

import '../../constant/ps_constants.dart';
import '../common/ps_holder.dart';


class SearchUserParameterHolder extends PsHolder<dynamic> {
  SearchUserParameterHolder() {
    keyword = '';
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;
    
  }

  String? orderBy;
  String? orderType;
  String? keyword;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['keyword'] = keyword;
    map['order_by'] = orderBy;
    map['order_type'] = orderType;
    

    return map;
  }

  @override
  dynamic fromMap(dynamic dynamicData) {
    keyword = dynamicData['keyword'];
    orderBy = PsConst.FILTERING__ADDED_DATE;
    orderType = PsConst.FILTERING__DESC;

    return this;
  }

  @override
  String getParamKey() {
    String result = '';

    if (keyword != '') {
      result += keyword!;
    }
    if (orderBy != '') {
      result += orderBy! + ':';
    }
    if (orderType != '') {
      result += orderType! + ':';
    }

    return result;
  }
}
