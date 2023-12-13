import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';

class LoginWithGoogleWidget extends StatelessWidget {
  const LoginWithGoogleWidget(
      {required this.onGoogleSignInSelected,
      required this.callBackAfterLoginSuccess});

  final Function? onGoogleSignInSelected, callBackAfterLoginSuccess;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space16,
          top: PsDimens.space16,
          right: PsDimens.space16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(4.0),
          ),
          // border: Border.all(
          //   color: PsColors.text400,
          //   width: 1.0,
          // ),
          color: PsColors.googleColor,
        ),
        child: Material(
          color: Colors.transparent,
          type: MaterialType.card,
          clipBehavior: Clip.antiAlias,
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(PsDimens.space8))),
          child: InkWell(
            onTap: () async {
              await userProvider.loginWithGoogleId(
                context,
                onGoogleSignInSelected,
                callBackAfterLoginSuccess,
                langProvider!.currentLocale.languageCode
              );
            },
            highlightColor: PsColors.primary900,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    'assets/images/google_logo.png',
                  ),
                ),
                const SizedBox(
                  width: PsDimens.space12,
                ),
                Text(
                  'login__google_signin'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color:  PsColors.achromatic50),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
