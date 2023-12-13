import 'dart:async';
import '../../constant/ps_constants.dart';
import '../../repository/chat_history_repository.dart';
import '../../viewobject/chat_history.dart';
import '../common/ps_provider.dart';

class ChatHistoryListProvider extends PsProvider<ChatHistory> {
  ChatHistoryListProvider({
    required ChatHistoryRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.NO_SUBSCRIPTION) {
    _repo = repo;
  }
  ChatHistoryRepository? _repo;

  Future<dynamic> updateUnreadMessageCount(
    Map<dynamic, dynamic> jsonMap, String loginUserId, String headerToken,String languageCode
  ) async {
    await _repo!.updateUnreadMessageCount(jsonMap, loginUserId, headerToken,languageCode);
  }

  // Future<dynamic> getChatHistory(
  //   GetChatHistoryParameterHolder holder,
  // ) async {
  //   isConnectedToInternet = await Utils.checkInternetConnectivity();
  //   isLoading = true;
  //   daoSubscription = await _repo!.getChatHistory(chatHistoryListStream, holder,
  //       isConnectedToInternet, PsStatus.PROGRESS_LOADING);
  // }

  // Future<dynamic> postChatHistory(
  //   Map<dynamic, dynamic> jsonMap,
  // ) async {
  //   isLoading = true;

  //   isConnectedToInternet = await Utils.checkInternetConnectivity();

  //   daoSubscription = await _repo.postChatHistory(
  //       jsonMap, isConnectedToInternet, PsStatus.PROGRESS_LOADING);

  //   return daoSubscription;
  // }

  // Future<dynamic> postAcceptedOffer(
  //     Map<dynamic, dynamic> jsonMap, String loginUserId) async {
  //   isLoading = true;

  //   isConnectedToInternet = await Utils.checkInternetConnectivity();

  //   daoSubscription = await _repo.postAcceptedOffer(
  //       jsonMap, loginUserId, isConnectedToInternet, PsStatus.PROGRESS_LOADING);

  //   return daoSubscription;
  // }

  // Future<dynamic> postRejectedOffer(
  //     Map<dynamic, dynamic> jsonMap, String loginUserId) async {
  //   isLoading = true;

  //   isConnectedToInternet = await Utils.checkInternetConnectivity();

  //   daoSubscription = await _repo.postRejectedOffer(
  //       jsonMap, loginUserId, isConnectedToInternet, PsStatus.PROGRESS_LOADING);

  //   return daoSubscription;
  // }

  // Future<dynamic> makeMarkAsSoldItem(
  //     String loginUserId, MakeMarkAsSoldParameterHolder holder) async {
  //   isLoading = true;

  //   isConnectedToInternet = await Utils.checkInternetConnectivity();

  //   daoSubscription =await _repo.makeMarkAsSold(
  //     chatHistoryStream,
  //     loginUserId,
  //     holder.toMap(),
  //     isConnectedToInternet,
  //     PsStatus.PROGRESS_LOADING,
  //   );
  // }
}
