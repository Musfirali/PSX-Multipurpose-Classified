import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/sender/sender_accept_or_rejected_msg.dart';

class CustomSenderAcceptedOrRejectedMessage extends StatelessWidget {
  const CustomSenderAcceptedOrRejectedMessage({
    required this.messageObj,
  });
  final Message messageObj;

  @override
  Widget build(BuildContext context) {
    return SenderAcceptedOrRejectedMessage(messageObj: messageObj);
  }
}
