import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/sync_chat_history_parameter_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';

class ChatSendButton extends StatelessWidget {
  const ChatSendButton(
      {required this.messageController,
      required this.chatFlag,
      required this.insertDataToFireBase,
      required this.isUserOnline,
      required this.sessionId});

  final TextEditingController messageController;
  final String chatFlag;
  final Function insertDataToFireBase;
  final String isUserOnline;
  final String sessionId;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final GetChatHistoryProvider chatHistoryProvider =
        Provider.of<GetChatHistoryProvider>(context);
    final ItemDetailProvider itemDetailProvider =
        Provider.of<ItemDetailProvider>(context, listen: false);
    final Product itemData = itemDetailProvider.product;
    return Container(
      height: PsDimens.space44,
      child: InkWell(
        child: Container(
          child: const Icon(
            Icons.send_outlined,
            size: PsDimens.space24,
          ),
        ),
        onTap: () async {
          if (messageController.text == '') {
            return;
          }
          SyncChatHistoryParameterHolder holder;
          if (chatFlag == PsConst.CHAT_FROM_BUYER) {
            holder = SyncChatHistoryParameterHolder(
                itemId: itemData.id,
                buyerUserId: chatHistoryProvider.buyerId,
                sellerUserId: chatHistoryProvider.sellerId,
                type: PsConst.CHAT_TO_BUYER,
                isUserOnline: isUserOnline,
                message: messageController.text);
            chatHistoryProvider.postData(
                requestBodyHolder: holder,
                requestPathHolder: RequestPathHolder(
                    loginUserId: psValueHolder.loginUserId,
                    headerToken: psValueHolder.headerToken));
          } else {
            holder = SyncChatHistoryParameterHolder(
                itemId: itemData.id,
                sellerUserId: chatHistoryProvider.sellerId,
                buyerUserId: chatHistoryProvider.buyerId,
                type: PsConst.CHAT_TO_SELLER,
                isUserOnline: isUserOnline,
                message: messageController.text);
            print('TOKEN_HEADER::: ${psValueHolder.headerToken}');    
            chatHistoryProvider.postData(
                requestBodyHolder: holder,
                requestPathHolder: RequestPathHolder(
                    loginUserId: psValueHolder.loginUserId,
                    headerToken: psValueHolder.headerToken));
          }
          await insertDataToFireBase(
              '',
              false,
              false,
              false,
              itemData.id,
              messageController.text,
              PsConst.CHAT_STATUS_NULL,
              psValueHolder.loginUserId!,
              sessionId,
              PsConst.CHAT_TYPE_TEXT);
          messageController.clear();
        },
      ),
    );
  }
}
