import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/receiver/receiver_image_widget.dart';

class CustomReceiverImageMsg extends StatelessWidget {
  const CustomReceiverImageMsg({
    Key? key,
    required this.messageObj,
  }) : super(key: key);

  final Message messageObj;

  @override
  Widget build(BuildContext context) {
    return ReceiverImageMsg(messageObj: messageObj,);
  }
}
