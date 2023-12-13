import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../../config/route/route_paths.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../common/dialog/confirm_dialog_view.dart';
import '../../../../../../common/ps_ui_widget.dart';

class SenderImageWidget extends StatelessWidget {
  const SenderImageWidget({
    Key? key,
    required this.deleteDataToFireBase,
    required this.messageObj,
  }) : super(key: key);

  final Function deleteDataToFireBase;
  final Message messageObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: PsDimens.space16,
        right: PsDimens.space16,
        bottom: PsDimens.space16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            child: Text(
              Utils.convertTimeStampToTime(messageObj.addedDateTimeStamp),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(
            width: PsDimens.space8,
          ),
          Flexible(
            child: GestureDetector(
              onLongPress: () {
                FocusScope.of(context).requestFocus(FocusNode());
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(PsDimens.space4),
                child: PsNetworkImageWithUrl(
                  photoKey: '',
                  imagePath: messageObj.message,
                  width: double.infinity,
                  height: PsDimens.space200,
                  imageAspectRation: PsConst.Aspect_Ratio_3x,
                  boxfit: BoxFit.cover,
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.chatImageDetailView,
                        arguments: messageObj);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
