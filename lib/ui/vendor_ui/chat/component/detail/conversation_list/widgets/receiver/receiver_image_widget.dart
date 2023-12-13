import 'package:flutter/material.dart';

import '../../../../../../../../config/route/route_paths.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../common/ps_ui_widget.dart';

class ReceiverImageMsg extends StatelessWidget {
  const ReceiverImageMsg({
    Key? key,
    required this.messageObj,
  }) : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
              child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(PsDimens.space4),
              child: PsNetworkImageWithUrl(
                photoKey: '',
                imagePath: messageObj.message,
                width: double.infinity,
                height: PsDimens.space200,
                boxfit: BoxFit.cover,
                imageAspectRation: PsConst.Aspect_Ratio_3x,
                onTap: () {
                  Navigator.pushNamed(context, RoutePaths.chatImageDetailView,
                      arguments: messageObj);
                },
              ),
            ),
          )),
          const SizedBox(
            width: PsDimens.space8,
          ),
          Expanded(
            child: Text(
              Utils.convertTimeStampToTime(messageObj.addedDateTimeStamp),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}