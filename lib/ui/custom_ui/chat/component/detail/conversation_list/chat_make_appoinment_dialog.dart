import 'package:flutter/material.dart';
import 'package:psxmpc/ui/vendor_ui/chat/component/detail/conversation_list/widgets/chat_make_appointment_dialog.dart';

import '../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';

class CustomChatMakeAppointmentDialog extends StatefulWidget {
  const CustomChatMakeAppointmentDialog(
      {Key? key, 
      required this.itemDetail, 
      required this.onMakeOfferTap,
      required this.getChatHistoryProvider,})
      : super(key: key);

  final Product? itemDetail;
  final Function onMakeOfferTap;
  final GetChatHistoryProvider? getChatHistoryProvider;

  @override
  _CustomChatMakeAppointmentDialogState createState() => _CustomChatMakeAppointmentDialogState();
}

class _CustomChatMakeAppointmentDialogState extends State<CustomChatMakeAppointmentDialog> {
  @override
  Widget build(BuildContext context) {
    return ChatMakeAppointmentDialog(
        itemDetail: widget.itemDetail, 
        getChatHistoryProvider: widget.getChatHistoryProvider,
        onMakeOfferTap: 
        widget.onMakeOfferTap);
  }
}
