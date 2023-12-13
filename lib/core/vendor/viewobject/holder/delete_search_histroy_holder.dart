

import '../common/ps_holder.dart';

class DeleteSearchHistoryHolder extends PsHolder<DeleteSearchHistoryHolder> {
  DeleteSearchHistoryHolder({
    required this.id,
  });

  final String? id;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['id'] = id;
    return map;
  }

  @override
  DeleteSearchHistoryHolder fromMap(dynamic dynamicData) {
    return DeleteSearchHistoryHolder(
      id: dynamicData['id'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (id != '') {
      key += id!;
    }

    return key;
  }
}
