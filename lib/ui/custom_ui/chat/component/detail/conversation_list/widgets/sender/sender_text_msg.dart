import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/sender/sender_text_msg.dart';

class CustomSenderTextMsg extends StatelessWidget {
  const CustomSenderTextMsg({
    Key? key,
    required this.deleteDataToFireBase,
    required this.messageObj,
  }) : super(key: key);

  final Function deleteDataToFireBase;
  final Message messageObj;

  @override
  Widget build(BuildContext context) {
    return SenderTextMsg(
        deleteDataToFireBase: deleteDataToFireBase, messageObj: messageObj);
  }
}
