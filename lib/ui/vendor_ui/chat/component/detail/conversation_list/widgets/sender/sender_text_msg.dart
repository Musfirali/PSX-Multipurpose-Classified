import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../common/dialog/confirm_dialog_view.dart';

class SenderTextMsg extends StatelessWidget {
  const SenderTextMsg({
    Key? key,
    required this.deleteDataToFireBase,
    required this.messageObj,
  }) : super(key: key);

  final Function deleteDataToFireBase;
  final Message messageObj;

  @override
  Widget build(BuildContext context) {
    late dynamic _tapPosition;
    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space16,
          right: PsDimens.space16,
          bottom: PsDimens.space16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            Utils.convertTimeStampToTime(messageObj.addedDateTimeStamp),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            width: PsDimens.space8,
          ),
          Flexible(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(PsDimens.space16),
                color: PsColors.success600),
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
                          //child: Expanded(
                          child: MaterialButton(
                            height: 50,
                            minWidth: double.infinity,
                            onPressed: () {
                              Navigator.of(context).pop();

                              Clipboard.setData(
                                  ClipboardData(text: messageObj.message!));
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
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            //)
                          )),
                      PopupMenuItem<String>(
                          value: '2',
                          //child: Expanded(
                          child: MaterialButton(
                            height: 50,
                            minWidth: double.infinity,
                            onPressed: () {
                              Navigator.of(context).pop();
                              showDialog<dynamic>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmDialogView(
                                      description: 'chat_message_delete'.tr,
                                      leftButtonText: 'dialog__cancel'.tr,
                                      rightButtonText: 'dialog__ok'.tr,
                                      onAgreeTap: () async {
                                        Navigator.pop(context);
                                        await deleteDataToFireBase(
                                          messageObj.id,
                                          false,
                                          messageObj.itemId,
                                          messageObj.message,
                                          messageObj.sendByUserId,
                                          messageObj.sessionId,
                                        );
                                      },
                                    );
                                  });
                            },
                            child: Text(
                              'message_delete'.tr,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),

                            //)
                          )),
                      PopupMenuItem<String>(
                          value: '3',
                          //child: Expanded(
                          child: MaterialButton(
                            height: 50,
                            minWidth: double.infinity,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'message_cancle'.tr,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),

                            /// )
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
                    ?.copyWith(color: PsColors.achromatic50),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
