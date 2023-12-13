import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class OtherUserJoinDateTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return Text(
      userProvider.user.data!.addedDateTimeStamp != null &&
              userProvider.user.data!.addedDateTimeStamp != ''
          ? '${'user_detail__joined'.tr} - ${Utils.changeTimeStampToStandardDateTimeFormat(userProvider.user.data!.addedDateTimeStamp)}'
          : '${'user_detail__joined'.tr} - ${Utils.getDateFormat(userProvider.user.data!.addedDate!, psValueHolder.dateFormat!)}',
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.7),
    );
  }
}
