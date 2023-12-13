import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/sender/mark_as_sold_button.dart';

class CustomMarkAsSoldButton extends StatelessWidget {
  const CustomMarkAsSoldButton(
      {required this.messageObj,
      required this.updateDataToFireBase,
      required this.insertDataToFireBase});
  final Message messageObj;
  final Function updateDataToFireBase;
  final Function insertDataToFireBase;

  @override
  Widget build(BuildContext context) {
    return MarkAsSoldButton(
        messageObj: messageObj,
        updateDataToFireBase: updateDataToFireBase,
        insertDataToFireBase: insertDataToFireBase);
  }
}
