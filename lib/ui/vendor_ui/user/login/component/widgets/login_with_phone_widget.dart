import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../common/dialog/warning_dialog_view.dart';

class LoginWithPhoneWidget extends StatefulWidget {
  const LoginWithPhoneWidget({required this.onPhoneSignInSelected});
  final Function? onPhoneSignInSelected;

  @override
  __LoginWithPhoneWidgetState createState() => __LoginWithPhoneWidgetState();
}

class __LoginWithPhoneWidgetState extends State<LoginWithPhoneWidget> {
  late UserProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);
    return Container(
      height: 40,
      margin: const EdgeInsets.only(
          top: PsDimens.space16,
          left: PsDimens.space16,
          right: PsDimens.space16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(4.0),
          ),
          color: PsColors.phoneColor,
        ),
        child: Material(
          color: PsColors.phoneColor,
          type: MaterialType.card,
          clipBehavior: Clip.antiAlias,
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(PsDimens.space8))),
          child: InkWell(
            onTap: () async {
              if (provider.isCheckBoxSelect) {
                if (widget.onPhoneSignInSelected != null) {
                  widget.onPhoneSignInSelected!();
                } else {
                  Navigator.pushNamed(
                    context,
                    RoutePaths.user_phone_signin_container,
                  );
                }
              } else {
                showDialog<dynamic>(
                    context: context,
                    builder: (BuildContext context) {
                      return WarningDialog(
                        message: 'login__warning_agree_privacy'.tr,
                        onPressed: () {},
                      );
                    });
              }
            },
            highlightColor: PsColors.primary900,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.phone, color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800),
                const SizedBox(
                  width: PsDimens.space12,
                ),
                Text(
                  'login__phone_signin'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
