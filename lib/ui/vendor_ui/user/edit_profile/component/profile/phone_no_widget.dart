import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../common/ps_button_widget_with_round_corner.dart';

class PhoneNoWidget extends StatefulWidget {
  const PhoneNoWidget({required this.phoneController});
  final TextEditingController phoneController;

  @override
  State<StatefulWidget> createState() => _PhoneNoWidgetState();
}

class _PhoneNoWidgetState extends State<PhoneNoWidget> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space16,
          top: PsDimens.space12,
          bottom: PsDimens.space12,
          right: PsDimens.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Mobile'.tr,
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: PsDimens.space12,
          ),
          PSButtonWidgetWithIconRoundCorner2(
            hasShadow: false,
            icon: Icons.edit,
            iconColor: Theme.of(context).primaryColor, //PsColors.primary500,
            colorData: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
            titleText: widget.phoneController.text,
            onPressed: () async {
              dynamic returnEditPhone = await Navigator.pushNamed(
                  context, RoutePaths.edit_phone_signin_container,
                  arguments: userProvider.user.data!.userPhone);

              if (returnEditPhone != null && returnEditPhone is String) {
                userProvider.user.data!.userPhone = returnEditPhone;
                returnEditPhone =
                    returnEditPhone.replaceFirst(RegExp(r'-'), ')');
                setState(() {
                  widget.phoneController.text = '(' + returnEditPhone;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
