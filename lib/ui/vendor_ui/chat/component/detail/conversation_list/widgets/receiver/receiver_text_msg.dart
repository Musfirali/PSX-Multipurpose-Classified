import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/message.dart';

class ReceiverTextMsg extends StatelessWidget {
  const ReceiverTextMsg({required this.messageObj});
  final Message messageObj;

  @override
  Widget build(BuildContext context) {
    late dynamic _tapPosition;
    return Consumer<GetChatHistoryProvider>(builder: (BuildContext context,
        GetChatHistoryProvider getChatHistoryProvider, Widget? child) {
      if (getChatHistoryProvider.chatHistory.data != null) {
        return Container(
          margin: const EdgeInsets.only(
              left: PsDimens.space16,
              right: PsDimens.space16,
              bottom: PsDimens.space16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(PsDimens.space16),
                      color: PsColors.primary50),
                  padding: const EdgeInsets.all(PsDimens.space12),
                  child: GestureDetector(
                    onLongPress: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final RenderBox overlay = //Overlay.of(context).context
                          context.findRenderObject() as RenderBox;

                      showMenu(
                          context: context,
                          items: <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                                value: '1',
                                // child: Expanded(
                                child: MaterialButton(
                                  height: 50,
                                  minWidth: double.infinity,
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                    Clipboard.setData(ClipboardData(
                                        text: messageObj.message!));
                                    Fluttertoast.showToast(
                                        msg: ' copied.',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: PsColors.accent300,
                                        textColor: PsColors.achromatic700);
                                  },
                                  child: Text(
                                    'message_copy'.tr,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  //)
                                )),
                            PopupMenuItem<String>(
                                value: '3',
                                // child: Expanded(
                                child: MaterialButton(
                                  height: 50,
                                  minWidth: double.infinity,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'message_cancle'.tr,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  //)
                                )),
                          ],
                          position: RelativeRect.fromRect(
                              _tapPosition & const Size(1, 1),
                              Offset.zero &
                                  overlay.size // Bigger rect, the entire screen
                              ));
                    },
                    onTapDown: (TapDownDetails details) {
                      _tapPosition = details.globalPosition;
                    },
                    child: Linkify(
                      onOpen: Utils.linkifyLinkOpen,
                      text: messageObj.message!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: PsColors.text800),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: PsDimens.space8,
              ),
              Text(
                Utils.convertTimeStampToTime(messageObj.addedDateTimeStamp),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
