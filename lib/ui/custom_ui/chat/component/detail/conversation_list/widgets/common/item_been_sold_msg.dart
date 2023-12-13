import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/common/item_been_sold_msg.dart';

class CustomItemHasBeenSoldMsg extends StatelessWidget {
  const CustomItemHasBeenSoldMsg({
    required this.messageObj,
  });
  final Message messageObj;
  
  @override
  Widget build(BuildContext context) {
    return ItemHasBeenSoldMsg(messageObj: messageObj);
  }
}
