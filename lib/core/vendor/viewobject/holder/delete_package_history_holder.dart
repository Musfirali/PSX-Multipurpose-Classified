

import '../common/ps_holder.dart';

class DeletePackageHistoryHolder extends PsHolder<DeletePackageHistoryHolder> {
  DeletePackageHistoryHolder({
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
  DeletePackageHistoryHolder fromMap(dynamic dynamicData) {
    return DeletePackageHistoryHolder(
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
