import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../custom_ui/user/forgot_password/component/widgets/verify_forgot_password/verify_forgot_password_back_widget.dart';
import '../../../../custom_ui/user/forgot_password/component/widgets/verify_forgot_password/verify_forgot_password_widget.dart';
import '../../../common/ps_header_icon_and_dynamic_text_widget.dart';

class VerifyForgotPasswordView extends StatefulWidget {
  const VerifyForgotPasswordView(
      {Key? key,
      this.animationController,
      this.userEmail,
      this.onToForgotPasswordSelected,
      this.onUpdateForgotChangeSelected})
      : super(key: key);

  final AnimationController? animationController;
  final String? userEmail;
  final Function? onToForgotPasswordSelected;
  final Function? onUpdateForgotChangeSelected;

  @override
  _VerifyForgotPasswordViewState createState() =>
      _VerifyForgotPasswordViewState();
}

class _VerifyForgotPasswordViewState extends State<VerifyForgotPasswordView> {
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
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: PsDimens.space16),
                  child: Text(
                    'email_verification_code_from_mail'.tr,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const SizedBox(height: 16),
                CustomVerifyForgotPasswordWidget(
                  userEmail: widget.userEmail,
                  onUpdateForgotChangeSelected:
                      widget.onUpdateForgotChangeSelected,
                ),
                CustomVerifyForgotPasswordBackWidget(
                  onToForgotPasswordSelected: widget.onToForgotPasswordSelected,
                ),
              ]),
        );
      }),
    );
  }
}
