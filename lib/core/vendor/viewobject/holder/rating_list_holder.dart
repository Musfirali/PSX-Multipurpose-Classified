

import '../common/ps_holder.dart';

class RatingListHolder extends PsHolder<RatingListHolder> {
  RatingListHolder({required this.userId, required this.type});

  final String? userId;
  final String? type;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['user_id'] = userId;
    map['type'] = type;

    return map;
  }

  @override
  RatingListHolder fromMap(dynamic dynamicData) {
    return RatingListHolder(
      userId: dynamicData['user_id'],
      type: dynamicData['type'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userId != '') {
      key += userId!;
    }
    if (type != '') {
      key += type!;
    }
    return key;
  }
}
