import '../common/ps_holder.dart';

class DeleteHistoryParameterHolder
    extends PsHolder<DeleteHistoryParameterHolder> {
  DeleteHistoryParameterHolder({
    required this.ids,
  });

  final List<dynamic>? ids;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['ids'] = ids;
    return map;
  }

  @override
  DeleteHistoryParameterHolder fromMap(dynamic dynamicData) {
    return DeleteHistoryParameterHolder(
      ids: dynamicData['ids'],
    );
  }

  @override
  String getParamKey() {
    const String key = '';

    // if (ids != '') {
    //   key += ids!;
    // }
    return key;
  }
}
