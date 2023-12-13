import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/receiver/receiver_text_msg.dart';

class CustomReceiverTextMsg extends StatelessWidget {
  const CustomReceiverTextMsg({required this.messageObj});
  final Message messageObj;

  @override
  Widget build(BuildContext context) {
    return ReceiverTextMsg(messageObj: messageObj);
  }
}
