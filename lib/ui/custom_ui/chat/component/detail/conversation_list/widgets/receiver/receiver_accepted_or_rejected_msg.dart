import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/receiver/receiver_accepted_or_rejected_msg.dart';

class CustomReceiverAcceptedOrRejectedMsg extends StatelessWidget {
  const CustomReceiverAcceptedOrRejectedMsg({
    required this.messageObj,
  });
  final Message messageObj;

  @override
  Widget build(BuildContext context) {
    return ReceiverAcceptedOrRejectedMsg(messageObj: messageObj);
  }
}
