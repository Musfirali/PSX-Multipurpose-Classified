import 'package:flutter/material.dart';

import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/sender/offer_accepted_msg_with_user_bought_box.dart';

class CustomOfferAcceptedMsgWithUserBought extends StatelessWidget {
  const CustomOfferAcceptedMsgWithUserBought(
      {required this.messageObj,
      required this.updateDataToFireBase,
      required this.insertDataToFireBase,
      required this.loginUserId,
      required this.isUserOnline});
      
  final Message messageObj;
  final Function updateDataToFireBase;
  final Function insertDataToFireBase;
  final String? loginUserId;

  final String? isUserOnline;

  @override
  Widget build(BuildContext context) {
    return OfferAcceptedMsgWithUserBought(
        messageObj: messageObj,
        updateDataToFireBase: updateDataToFireBase,
        insertDataToFireBase: insertDataToFireBase,
        loginUserId: loginUserId,
        isUserOnline: isUserOnline);
  }
}
