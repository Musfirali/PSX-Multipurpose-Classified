import '../common/ps_holder.dart';

class DeliveryBoyRatingParameterHolder extends PsHolder<DeliveryBoyRatingParameterHolder> {
  DeliveryBoyRatingParameterHolder(
      {required this.transactionHeaderId,
       required this.rating,
      required this.title,
      required this.description});

  final String ?transactionHeaderId;
   final String? rating;
  final String? title;
  final String? description;


  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['transactions_header_id'] = transactionHeaderId;
    map['rating'] = rating;
    map['title'] = title;
    map['description'] = description;


    return map;
  }

  @override
  DeliveryBoyRatingParameterHolder fromMap(dynamic dynamicData) {
    return DeliveryBoyRatingParameterHolder(
      transactionHeaderId: dynamicData['transactions_header_id'],
      rating: dynamicData['rating'],
      title: dynamicData['title'],
      description: dynamicData['description'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (transactionHeaderId != '') {
      key += transactionHeaderId!;
    }
    if (rating != '') {
      key += rating!;
    }
    if (title != '') {
      key += title!;
    }
    if (description != '') {
      key += description!;
    }
    
    return key;
  }
}
