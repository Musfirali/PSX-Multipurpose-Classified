import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/ui/custom_ui/user/register/component/widgets/register_user_name_text_box.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../custom_ui/user/register/component/widgets/go_to_login_text_widget.dart';
import '../../../../custom_ui/user/register/component/widgets/register_button.dart';
import '../../../../custom_ui/user/register/component/widgets/register_email_text_box.dart';
import '../../../../custom_ui/user/register/component/widgets/register_name_text_box.dart';
import '../../../../custom_ui/user/register/component/widgets/register_password_text_box.dart';
import '../../../../custom_ui/user/register/component/widgets/terms_and_conditions_text.dart';
import '../../../common/ps_header_icon_and_dynamic_text_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView(
      {Key? key,
      this.animationController,
      this.onRegisterSelected,
      this.goToLoginSelected})
      : super(key: key);
  final AnimationController? animationController;
  final Function? onRegisterSelected, goToLoginSelected;
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  UserRepository? repo1;
  PsValueHolder? psValueHolder;
  TextEditingController? nameController;
  TextEditingController? userNameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

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
    const Widget _spacingWidget = SizedBox(
      height: PsDimens.space32,
    );
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

          return provider;
        },
        child: Consumer<UserProvider>(builder:
            (BuildContext context, UserProvider provider, Widget? child) {
          nameController = TextEditingController(
              text: provider.psValueHolder!.userNameToVerify);
          userNameController = TextEditingController(
              text: provider.psValueHolder!.userNameToVerify);
          emailController = TextEditingController(
              text: provider.psValueHolder!.userEmailToVerify);
          passwordController = TextEditingController(
              text: provider.psValueHolder!.userPasswordToVerify);

          return Stack(
            children: <Widget>[
              SingleChildScrollView(
                  child: AnimatedBuilder(
                      animation: animationController,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          PsHeaderIconAndDynamicTextWidget(
                              text: 'login__sign_up'.tr),

                          CustomRegisterNameTextBox(
                              nameController: nameController),
                          CustomRegisterUserNameTextBox(
                             userNameController: userNameController,),
                          CustomRegisterEmailTextBox(
                              emailText: emailController),
                          CustomRegisterPasswordTextBox(
                              passwordText: passwordController),
                          const SizedBox(
                            height: PsDimens.space16,
                          ),
                          CustomRegisterButton(
                            nameTextEditingController: nameController,
                            userNameTextEditingController: userNameController,
                            emailTextEditingController: emailController,
                            passwordTextEditingController: passwordController,
                            onRegisterSelected: widget.onRegisterSelected,
                            callBackAfterLoginSuccess:
                                callBackAfterLoginSuccess,
                          ),
                          CustomTermsAndConditionTextWidget(
                            nameTextEditingController: nameController,
                            emailTextEditingController: emailController,
                            passwordTextEditingController: passwordController,
                          ),
                          _spacingWidget,
                          CustomGoToLoginTextWidget(
                            onSignInSelected: widget.goToLoginSelected,
                          ),
                          _spacingWidget,
                          _spacingWidget
                        ],
                      ),
                      builder: (BuildContext context, Widget? child) {
                        return FadeTransition(
                            opacity: animation,
                            child: Transform(
                                transform: Matrix4.translationValues(
                                    0.0, 100 * (1.0 - animation.value), 0.0),
                                child: child));
                      }))
            ],
          );
        }),
      ),
    );
  }

  void callBackAfterLoginSuccess(User user) {
    if (psValueHolder!.isForceLogin!) {
      if (psValueHolder!.isLanguageConfig! &&
          psValueHolder!.showOnboardLanguage) {
        Navigator.pushReplacementNamed(context, RoutePaths.languagesetting);
      } else {
        if (psValueHolder!.locationId != null) {
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.home,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            RoutePaths.itemLocationFirst,
          );
        }
      }
    } else {
      Navigator.pop(context, user);
    }
  }
}
