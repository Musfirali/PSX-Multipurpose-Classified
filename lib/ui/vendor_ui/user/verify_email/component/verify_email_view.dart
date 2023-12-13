import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../custom_ui/user/verify_email/component/widgets/email_verfication_widget.dart';
import '../../../../custom_ui/user/verify_email/component/widgets/email_verify_back_widget.dart';
import '../../../common/ps_header_icon_and_dynamic_text_widget.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView(
      {Key? key,
      this.animationController,
      this.onProfileSelected,
      this.onSignInSelected,
      this.userId})
      : super(key: key);

  final AnimationController? animationController;
  final Function? onProfileSelected, onSignInSelected;
  final String? userId;
  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  UserRepository? repo1;
  PsValueHolder? valueHolder;

  @override
  Widget build(BuildContext context) {
    widget.animationController!.forward();

    repo1 = Provider.of<UserRepository>(context);
    valueHolder = Provider.of<PsValueHolder>(context);

    return ChangeNotifierProvider<UserProvider>(
      lazy: false,
      create: (BuildContext context) {
        final UserProvider provider =
            UserProvider(repo: repo1, psValueHolder: valueHolder);
        return provider;
      },
      child: Consumer<UserProvider>(builder:
          (BuildContext context, UserProvider provider, Widget? child) {
        return SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PsHeaderIconAndDynamicTextWidget(
                    text: 'email_verificatiion_title'.tr),
                Padding(
                  padding: const EdgeInsets.only(
                      left: PsDimens.space16,
                      right: PsDimens.space16,
                      bottom: PsDimens.space16),
                  child: Text(
                    'Please enter the verification code from your email.'.tr,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Utils.isLightMode(context)
                            ? PsColors.text800
                            : PsColors.achromatic50,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                CustomEmailVerificationWidget(
                  onProfileSelected: widget.onProfileSelected,
                  userId: widget.userId,
                ),
                CustomEmailVerifyBackWidget(
                    onSignInSelected: widget.onSignInSelected),
              ]),
        );
      }),
    );
  }
}
