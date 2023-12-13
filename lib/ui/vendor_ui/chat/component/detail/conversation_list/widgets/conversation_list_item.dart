import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/ui/vendor_ui/chat/component/detail/conversation_list/widgets/receiver/receiver_blocked_widget.dart';
import 'package:psxmpc/ui/vendor_ui/chat/component/detail/conversation_list/widgets/sender/sender_blocked_widget.dart';

import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/common/give_review_button.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/common/item_been_bought_msg.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/common/item_been_sold_msg.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/receiver/offer_received_msg.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/receiver/offer_received_with_accept_and_reject_widget.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/receiver/receiver_accepted_or_rejected_msg.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/receiver/receiver_image_widget.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/receiver/receiver_text_msg.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/sender/mark_as_sold_button.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/sender/offer_accepted_msg_with_user_bought_box.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/sender/sender_accept_or_rejected_msg.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/sender/sender_image_widget.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/sender/sender_make_offer_msg.dart';
import '../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/sender/sender_text_msg.dart';

class ConversationListItem extends StatelessWidget {
  const ConversationListItem(
      {required this.messageObj,
      required this.updateDataToFireBase,
      required this.insertDataToFireBase,
      required this.deleteDataToFireBase,
      required this.index,
      required this.isUserOnline,
      required this.otherUserId});
  final Message messageObj;
  final Function updateDataToFireBase;
  final Function insertDataToFireBase;
  final Function deleteDataToFireBase;
  final int index;
  final String? isUserOnline;
  final String? otherUserId;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final GetChatHistoryProvider chatHistoryProvider =
        Provider.of<GetChatHistoryProvider>(context);
    // Checking User id
    if (psValueHolder.loginUserId == '' || messageObj.sendByUserId == '') {
      return const SizedBox();
    }

    if (psValueHolder.loginUserId == messageObj.sendByUserId) {
      // sender
      if (messageObj.type == PsConst.CHAT_TYPE_TEXT) {
        if (messageObj.offerStatus == PsConst.CHAT_STATUS_OFFER) {
          return CustomSenderMakeOfferMessage(
            messageObj: messageObj,
          );
        } else if (messageObj.offerStatus == PsConst.CHAT_STATUS_ACCEPT) {
          if (psValueHolder.loginUserId == chatHistoryProvider.sellerId &&
              messageObj.isSold != null &&
              messageObj.isUserBought != null &&
              !messageObj.isSold! &&
              !messageObj.isUserBought!) {
            return CustomOfferAcceptedMsgWithUserBought(
              messageObj: messageObj,
              updateDataToFireBase: updateDataToFireBase,
              insertDataToFireBase: insertDataToFireBase,
              loginUserId: psValueHolder.loginUserId,
              isUserOnline: isUserOnline,
            );
          } else if (psValueHolder.loginUserId ==
                  chatHistoryProvider.sellerId &&
              messageObj.isSold != null &&
              messageObj.isUserBought != null &&
              messageObj.isSold! &&
              messageObj.isUserBought!) {
            return const SizedBox();
          } else {
            return CustomSenderAcceptedOrRejectedMessage(
              messageObj: messageObj,
            );
          }
        } else if (messageObj.offerStatus == PsConst.CHAT_STATUS_REJECT) {
          return CustomSenderAcceptedOrRejectedMessage(
            messageObj: messageObj,
          );
        } else {
          return CustomSenderTextMsg(
            messageObj: messageObj,
            deleteDataToFireBase: deleteDataToFireBase,
          );
        }
      } else if (messageObj.type == PsConst.CHAT_TYPE_OFFER) {
        return CustomSenderMakeOfferMessage(
          messageObj: messageObj,
        );
      } else if (messageObj.type == PsConst.CHAT_TYPE_BOUGHT) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CustomItemHasBeenBoughtMsg(messageObj: messageObj),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CustomGiveReviewButton(),
                        CustomMarkAsSoldButton(
                            messageObj: messageObj,
                            updateDataToFireBase: updateDataToFireBase,
                            insertDataToFireBase: insertDataToFireBase)
                      ]),
                ),
              ),
            ),
          ],
        );
      } else if (messageObj.type == PsConst.CHAT_TYPE_SOLD) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    CustomItemHasBeenBoughtMsg(messageObj: messageObj),
                    CustomItemHasBeenSoldMsg(messageObj: messageObj),
                  ]),
              CustomGiveReviewButton(),
            ]);
      } else if (messageObj.type == PsConst.CHAT_TYPE_IMAGE) {
        return CustomSenderImageWidget(
          messageObj: messageObj,
          deleteDataToFireBase: deleteDataToFireBase,
        );
      } else if (messageObj.type == PsConst.CHAT_TYPE_IS_BLOCKED) {
        return SenderBlockedWidget(
            messageObj: messageObj,
            otherUserId: otherUserId!,
            updateDataToFireBase: updateDataToFireBase);
      } else if (messageObj.type == PsConst.CHAT_TYPE_IS_UNBLOCKED) {
        return const SizedBox();
      } else {
        return const SizedBox();
      }
    } else {
      //receiver
      if (messageObj.type == PsConst.CHAT_TYPE_TEXT) {
        if (messageObj.offerStatus == PsConst.CHAT_STATUS_OFFER) {
          return CustomOfferReceivedMsg(
            messageObj: messageObj,
          );
        } else if (messageObj.offerStatus == PsConst.CHAT_STATUS_ACCEPT) {
          if (psValueHolder.loginUserId == chatHistoryProvider.buyerId &&
              messageObj.isSold != null &&
              messageObj.isUserBought != null &&
              messageObj.isSold! &&
              messageObj.isUserBought!) {
            return const SizedBox();
          } else {
            return CustomReceiverAcceptedOrRejectedMsg(
              messageObj: messageObj,
            );
          }
        } else if (messageObj.offerStatus == PsConst.CHAT_STATUS_REJECT) {
          return CustomReceiverAcceptedOrRejectedMsg(
            messageObj: messageObj,
          );
        } else {
          return CustomReceiverTextMsg(
            messageObj: messageObj,
          );
        }
      } else if (messageObj.type == PsConst.CHAT_TYPE_OFFER) {
        return CustomOfferReceivedBoxWithAcceptAndRejectWidget(
          messageObj: messageObj,
          updateDataToFireBase: updateDataToFireBase,
          insertDataToFireBase: insertDataToFireBase,
          isUserOnline: isUserOnline,
        );
      } else if (messageObj.type == PsConst.CHAT_TYPE_SOLD) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    CustomItemHasBeenBoughtMsg(messageObj: messageObj),
                    CustomItemHasBeenSoldMsg(messageObj: messageObj),
                  ]),
              CustomGiveReviewButton(),
            ]);
      } else if (messageObj.type == PsConst.CHAT_TYPE_IMAGE) {
        return CustomReceiverImageMsg(messageObj: messageObj);
      } else if (messageObj.type == PsConst.CHAT_TYPE_BOUGHT) {
        return Column(
          children: <Widget>[
            CustomItemHasBeenBoughtMsg(messageObj: messageObj),
            CustomGiveReviewButton(),
          ],
        );
      } else if (messageObj.type == PsConst.CHAT_TYPE_IS_BLOCKED) {
        return ReceiverBlockedWidget();
      } else if (messageObj.type == PsConst.CHAT_TYPE_IS_UNBLOCKED) {
        return const SizedBox();
      } else {
        return const SizedBox();
      }
    }
  }
}
