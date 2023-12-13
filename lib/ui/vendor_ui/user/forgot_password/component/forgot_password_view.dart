import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../custom_ui/user/forgot_password/component/widgets/forgot_pwd_email_text_box.dart';
import '../../../../custom_ui/user/forgot_password/component/widgets/forgot_pwd_send_button.dart';
import '../../../../custom_ui/user/phone/component/sign_in/widgets/back_to_login_widget.dart';
import '../../../common/ps_header_icon_and_dynamic_text_widget.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({
    Key? key,
    this.animationController,
    this.goToLoginSelected,
    this.onVerifyForgotPasswordSelected,
  }) : super(key: key);
  final AnimationController? animationController;
  final Function? goToLoginSelected;
  final Function? onVerifyForgotPasswordSelected;

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView>
    with SingleTickerProviderStateMixin {
  final TextEditingController userEmailController = TextEditingController();
  UserRepository? repo1;
  PsValueHolder? psValueHolder;
  late AnimationController animationController;
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.5 * 1, 1.0, curve: Curves.fastOutSlowIn)));

    animationController.forward();
    repo1 = Provider.of<UserRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return SliverToBoxAdapter(
      child: ChangeNotifierProvider<UserProvider>(
        lazy: false,
        create: (BuildContext context) {
          final UserProvider provider =
              UserProvider(repo: repo1, psValueHolder: psValueHolder);
          // provider.postUserRegister(userRegisterParameterHolder.toMap());
          return provider;
        },
        child: Consumer<UserProvider>(builder:
            (BuildContext context, UserProvider provider, Widget? child) {
          return Stack(
            children: <Widget>[
              SingleChildScrollView(
                  child: AnimatedBuilder(
                      animation: animationController,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            PsHeaderIconAndDynamicTextWidget(
                                text: 'Forgot Password?'.tr),
                            Text(
                              'forgot_psw_desc'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Utils.isLightMode(context) ? PsColors.text900: PsColors.text50,
                                      fontSize: 16),
                            ),
                            const SizedBox(height: PsDimens.space16),
                            Text(
                              'forgot_psw__email'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: Utils.isLightMode(context) ? PsColors.text900: PsColors.text50,
                                      fontSize: 14),
                            ),
                            const SizedBox(height: PsDimens.space8),
                            CustomForgotPwdEmailTextBox(
                              userEmailController: userEmailController,
                            ),
                            const SizedBox(height: PsDimens.space16),
                            CustomForgotPwdSendButton(
                              userEmailController: userEmailController,
                              goToLoginSelected: widget.goToLoginSelected,
                              onVerifyForgotPasswordSelected:
                                  widget.onVerifyForgotPasswordSelected,
                            ),
                            CustomBackToLoginWidget(
                                goToLoginSelected: widget.goToLoginSelected),
                          ],
                        ),
                      ),
                      builder: (BuildContext context, Widget? child) {
                        return FadeTransition(
                          opacity: animation,
                          child: Transform(
                              transform: Matrix4.translationValues(
                                  0.0, 100 * (1.0 - animation.value), 0.0),
                              child: child),
                        );
                      }))
            ],
          );
        }),
      ),
    );
  }
}
