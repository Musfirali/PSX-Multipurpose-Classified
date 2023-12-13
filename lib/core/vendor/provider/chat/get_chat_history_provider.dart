import 'dart:async';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/chat_history_repository.dart';
import '../../viewobject/chat_history.dart';
import '../../viewobject/holder/get_chat_history_parameter_holder.dart';
import '../../viewobject/holder/make_mark_as_sold_parameter_holder.dart';
import '../common/ps_provider.dart';

class GetChatHistoryProvider extends PsProvider<ChatHistory> {
  GetChatHistoryProvider({
    required ChatHistoryRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }
  String? itemCurrency = '';
  
  late ChatHistoryRepository _repo;

  PsResource<ChatHistory?> get chatHistory => super.data;

  late GetChatHistoryParameterHolder getChatHistoryParameterHolder;

  Future<dynamic> acceptOffer(
      Map<dynamic, dynamic> jsonMap, String? loginUserId, String headerToken,String languageCode) async {
    return await _repo.acceptOffer(jsonMap, loginUserId, headerToken,languageCode);
  }

  Future<dynamic> makeOrRejectOffer(
      Map<dynamic, dynamic> jsonMap, String? loginUserId, String headerToken,String languageCode) async {
    return await _repo.makeOrRejectOffer(jsonMap, loginUserId, headerToken,languageCode);
  }

  Future<dynamic> makeMarkAsSoldItem(
      String? loginUserId, String headerToken, MakeMarkAsSoldParameterHolder holder,String languageCode) async {
    await _repo.makeMarkAsSold(
      loginUserId,
      headerToken,
      holder.toMap(),
      languageCode
    );
  }

  Future<dynamic> makeUserBoughtItem(
    Map<dynamic, dynamic> jsonMap,
    String? loginUserId,
    String headerToken,String languageCode
  ) async {
    return await _repo.makeUserBoughtItem(loginUserId, headerToken, jsonMap,languageCode);
  }

  bool get isItemInOfferableMode {
    return chatHistory.data != null &&
        chatHistory.data!.isOffer != PsConst.ONE &&
        chatHistory.data!.item != null &&
        chatHistory.data!.item!.isSoldOut != PsConst.ONE;
  }

  String get buyerId {
    return getChatHistoryParameterHolder.buyerUserId ?? '';
  }

  String get sellerId {
    return getChatHistoryParameterHolder.sellerUserId ?? '';
  }
}
