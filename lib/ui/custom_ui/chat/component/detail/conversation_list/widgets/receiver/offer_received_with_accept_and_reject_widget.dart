import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/receiver/offer_received_with_accept_and_reject_widget.dart';

class CustomOfferReceivedBoxWithAcceptAndRejectWidget extends StatelessWidget {
  const CustomOfferReceivedBoxWithAcceptAndRejectWidget({
    required this.messageObj,
    required this.updateDataToFireBase,
    required this.insertDataToFireBase,
    required this.isUserOnline,
  });
  final Message messageObj;
  final Function updateDataToFireBase;
  final Function insertDataToFireBase;
  final String? isUserOnline;

  @override
  Widget build(BuildContext context) {
    return OfferReceivedBoxWithAcceptAndRejectWidget(
      insertDataToFireBase: insertDataToFireBase,
      updateDataToFireBase: updateDataToFireBase,
      isUserOnline: isUserOnline,
      messageObj: messageObj,
    );
  }
}
