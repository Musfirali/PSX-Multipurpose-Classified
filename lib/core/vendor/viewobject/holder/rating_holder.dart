

import '../common/ps_holder.dart';

class RatingParameterHolder extends PsHolder<RatingParameterHolder> {
  RatingParameterHolder({
    required this.fromUserId,
    required this.toUserId,
    required this.title,
    required this.description,
    required this.rating,
    required this.type
  });

  final String? fromUserId;
  final String? toUserId;
  final String? title;
  final String? description;
  final String? rating;
  final String? type;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['from_user_id'] = fromUserId;
    map['to_user_id'] = toUserId;
    map['title'] = title;
    map['description'] = description;
    map['rating'] = rating;
    map['type'] = type;

    return map;
  }

  @override
  RatingParameterHolder fromMap(dynamic dynamicData) {
    return RatingParameterHolder(
      fromUserId: dynamicData['from_user_id'],
      toUserId: dynamicData['to_user_id'],
      title: dynamicData['title'],
      description: dynamicData['description'],
      rating: dynamicData['rating'],
      type: dynamicData['type']
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (fromUserId != '') {
      key += fromUserId!;
    }
    if (toUserId != '') {
      key += toUserId!;
    }

    if (title != '') {
      key += title!;
    }
    if (description != '') {
      key += description!;
    }
    if (rating != '') {
      key += rating!;
    }
    if (type != '') {
      key += type!;
    }
    return key;
  }
}
