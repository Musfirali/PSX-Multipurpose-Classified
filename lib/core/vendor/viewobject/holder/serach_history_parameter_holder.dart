

import '../../constant/ps_constants.dart';
import '../common/ps_holder.dart';


class SerachHistoryParameterHolder extends PsHolder<dynamic> {
  SerachHistoryParameterHolder() {
    userId = '';
    type = '';
  }

  String? userId;
  String? type;

  SerachHistoryParameterHolder getItemSearchHistoryList() {
    userId = '';
    type = PsConst.ITEM;

    return this;
  }

    SerachHistoryParameterHolder getAllSearchHistoryList() {
    userId = '';
    type = PsConst.ALL;

    return this;
  }

  SerachHistoryParameterHolder getCategorySerachHistoryList() {
    userId = '';
    type = PsConst.CATEGORY;

    return this;
  }

    SerachHistoryParameterHolder getUserSerachHistoryList() {
    userId = '';
    type = PsConst.USER;

    return this;
  }

SerachHistoryParameterHolder resetParameterHolder() {
    userId = '';
    type = '';

    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['user_id'] = userId;
    map['type'] = type;
    return map;
  }

  @override
  dynamic fromMap(dynamic dynamicData) {
    userId = '';
    type = '';

    return this;
  }

  @override
  String getParamKey() {
    String result = '';

    if (userId != '') {
      result += userId! + ':';
    }
    if (type != '') {
      result += type! + ':';
    }
    return result;
  }
}
