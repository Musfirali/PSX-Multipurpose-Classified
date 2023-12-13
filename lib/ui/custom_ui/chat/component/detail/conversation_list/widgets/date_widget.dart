import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/date_widget.dart';

class CustomDateWidget extends StatelessWidget {
  const CustomDateWidget({required this.lastTimeStamp});
  final String lastTimeStamp;
  @override
  Widget build(BuildContext context) {
    return DateWidget(lastTimeStamp: lastTimeStamp);
  }
}
