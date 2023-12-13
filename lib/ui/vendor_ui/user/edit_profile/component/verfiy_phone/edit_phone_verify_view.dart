import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/ui/vendor_ui/user/edit_profile/component/verfiy_phone/widgets/resend_code_widget.dart';

import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../custom_ui/user/edit_profile/component/verfiy_phone/widgets/verification_widget.dart';
import '../../../../common/ps_header_icon_and_dynamic_text_widget.dart';

class EditPhoneVerifyView extends StatefulWidget {
  const EditPhoneVerifyView({
    Key? key,
    required this.userName,
    required this.phoneNumber,
    required this.phoneId,
    required this.animationController,
  }) : super(key: key);

  final String userName;
  final String phoneNumber;
  final String? phoneId;
  final AnimationController? animationController;
  @override
  _EditPhoneVerifyViewState createState() => _EditPhoneVerifyViewState();
}

class _EditPhoneVerifyViewState extends State<EditPhoneVerifyView> {
  UserRepository? repo1;
  PsValueHolder? valueHolder;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    widget.animationController!.forward();

    repo1 = Provider.of<UserRepository>(context);
    langProvider = Provider.of<AppLocalization>(context);
    valueHolder = Provider.of<PsValueHolder>(context);

    return ChangeNotifierProvider<UserProvider>(
      lazy: false,
      create: (BuildContext context) {
        final UserProvider provider =
            UserProvider(repo: repo1, psValueHolder: valueHolder);
        provider.getUser(
            valueHolder!.loginUserId, langProvider.currentLocale.languageCode);
        return provider;
      },
      child: Consumer<UserProvider>(builder:
          (BuildContext context, UserProvider provider, Widget? child) {
        return SingleChildScrollView(
          child: Column(children: <Widget>[
            PsHeaderIconAndDynamicTextWidget(
              text: 'phone_signin__otp'.tr,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'phone_signin__otp_request'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 8),
                CustomVerificationWidget(
                  phoneNumber: widget.phoneNumber,
                  phoneId: widget.phoneId!,
                ),
                ResendCodeWidget(
                    userPhone:
                        widget.phoneNumber.replaceFirst(RegExp(r'-'), '')),
              ],
            ),
          ]),
        );
      }),
    );
  }
}
