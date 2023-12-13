

import '../common/ps_holder.dart';

class UserReportItemParameterHolder
    extends PsHolder<UserReportItemParameterHolder> {
  UserReportItemParameterHolder({
    required this.itemId,
    required this.reportedUserId,
    this.textNote = '',
  });

  final String? itemId;
  final String? reportedUserId;
  final String? textNote;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['item_id'] = itemId;
    map['reported_user_id'] = reportedUserId;
    map['text_note'] = textNote;
    return map;
  }

  @override
  UserReportItemParameterHolder fromMap(dynamic dynamicData) {
    return UserReportItemParameterHolder(
      itemId: dynamicData['item_id'],
      reportedUserId: dynamicData['reported_user_id'],
      textNote: dynamicData['text_note']
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (reportedUserId != '') {
      key += reportedUserId!;
    }
    if (itemId != '') {
      key += itemId!;
    }

    return key;
  }
}
