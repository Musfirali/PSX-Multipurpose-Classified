import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/conversation_list_item.dart';

class CustomConversationListItem extends StatelessWidget {
  const CustomConversationListItem(
      {required this.messageObj,
      required this.updateDataToFireBase,
      required this.insertDataToFireBase,
      required this.deleteDataToFireBase,
      required this.index,
      required this.isUserOnline,
      required this.otherUserId
      });
  final Message messageObj;
  final Function updateDataToFireBase;
  final Function insertDataToFireBase;
  final Function deleteDataToFireBase;
  final int index;
  final String? isUserOnline;
  final String? otherUserId;

  @override
  Widget build(BuildContext context) {
    return ConversationListItem(
        messageObj: messageObj,
        updateDataToFireBase: updateDataToFireBase,
        insertDataToFireBase: insertDataToFireBase,
        deleteDataToFireBase: deleteDataToFireBase,
        index: index,
        isUserOnline: isUserOnline,
        otherUserId: otherUserId);
  }
}
