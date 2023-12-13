import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/common/item_been_bought_msg.dart';

class CustomItemHasBeenBoughtMsg extends StatelessWidget {
  const CustomItemHasBeenBoughtMsg({
    required this.messageObj,
  });
  final Message messageObj;
  
  @override
  Widget build(BuildContext context) {
    return ItemHasBeenBoughtMsg(messageObj: messageObj);
  }
}
