import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_apple_sign_in/apple_sign_in_button.dart' as apple;
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';

class LoginWithAppleIdWidget extends StatelessWidget {
  const LoginWithAppleIdWidget(
      {required this.onAppleIdSignInSelected,
      required this.callBackAfterLoginSuccess});

  final Function? onAppleIdSignInSelected, callBackAfterLoginSuccess;

  @override
  Widget build(BuildContext context) {
    final UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
        final AppLocalization? langProvider = Provider.of<AppLocalization>(context);

    return Container(
        margin: const EdgeInsets.only(
            left: PsDimens.space16,
            top: PsDimens.space16,
            right: PsDimens.space16),
        child: Directionality(
          // add this
          textDirection: TextDirection.ltr,
          child: apple.AppleSignInButton(
            style: apple.ButtonStyle.black, // style as needed
            type: apple.ButtonType.signIn, // style as needed

            onPressed: () async {
              await _userProvider.loginWithAppleId(
                  context, onAppleIdSignInSelected, callBackAfterLoginSuccess,langProvider!.currentLocale.languageCode);
            },
          ),
        ));
  }
}
