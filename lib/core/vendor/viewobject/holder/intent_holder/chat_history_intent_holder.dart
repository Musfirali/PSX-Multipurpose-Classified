import '../../product.dart';

class ChatHistoryIntentHolder {
  const ChatHistoryIntentHolder(
      {required this.itemId,
      required this.chatFlag,
      required this.buyerUserId,
      required this.sellerUserId,
      this.userCoverPhoto,
      this.userName,
      this.itemDetail});
  final String? itemId;
  final String chatFlag;
  final String? buyerUserId;
  final String? sellerUserId;
  final String? userCoverPhoto;
  final String? userName;
  final Product? itemDetail;
}
