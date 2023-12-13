import 'package:flutter/material.dart';
import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/receiver/offer_received_msg.dart';

class CustomOfferReceivedMsg extends StatelessWidget {
  const CustomOfferReceivedMsg({
    required this.messageObj,
  });
  final Message messageObj;

  @override
  Widget build(BuildContext context) {
    return OfferReceivedMsg(messageObj: messageObj);
  }
}
