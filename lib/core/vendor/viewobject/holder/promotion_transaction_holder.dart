import '../common/ps_holder.dart';

class PromotionTransactionParameterHolder
    extends PsHolder<PromotionTransactionParameterHolder> {
  PromotionTransactionParameterHolder({
    this.userId,
  });
  final String? userId;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['user_id'] = userId;

    return map;
  }

  @override
  PromotionTransactionParameterHolder fromMap(dynamic dynamicData) {
    return PromotionTransactionParameterHolder(
      userId: dynamicData['user_id'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (userId != '') {
      key += userId!;
    }

    return key;
  }
}
