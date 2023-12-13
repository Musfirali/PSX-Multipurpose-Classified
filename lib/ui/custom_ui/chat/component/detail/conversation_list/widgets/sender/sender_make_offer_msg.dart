import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/sender/sender_make_offer_msg.dart';

class CustomSenderMakeOfferMessage extends StatelessWidget {
  const CustomSenderMakeOfferMessage({required this.messageObj});
  final Message messageObj;

  @override
  Widget build(BuildContext context) {
    return SenderMakeOfferMessage(
      messageObj: messageObj,
    );
  }
}
