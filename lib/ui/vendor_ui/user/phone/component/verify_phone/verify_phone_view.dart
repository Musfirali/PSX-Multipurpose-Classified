import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/ui/vendor_ui/user/phone/component/verify_phone/widgets/verify_phone_header_widget.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../custom_ui/user/phone/component/verify_phone/widgets/back_to_login_in_verify_widget.dart';
import '../../../../../custom_ui/user/phone/component/verify_phone/widgets/verification_in_verify_phone_widget.dart';

class VerifyPhoneView extends StatefulWidget {
  const VerifyPhoneView(
      {Key? key,
      required this.userName,
      required this.phoneNumber,
      required this.phoneId,
      required this.animationController,
      this.onProfileSelected,
      this.onSignInSelected})
      : super(key: key);

  final String? userName;
  final String? phoneNumber;
  final String? phoneId;
  final AnimationController? animationController;
  final Function? onProfileSelected, onSignInSelected;
  @override
  _VerifyPhoneViewState createState() => _VerifyPhoneViewState();
}

class _VerifyPhoneViewState extends State<VerifyPhoneView> {
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
          child: Column(children: <Widget>[
            VerifyPhoneHeaderWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: PsDimens.space16,
                      left: PsDimens.space16,
                      right: PsDimens.space16,
                      bottom: PsDimens.space16),
                  child: Text(
                    'phone_signin__otp_request'.tr,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Utils.isLightMode(context)
                            ? PsColors.text800
                            : PsColors.achromatic50),
                  ),
                ),
                CustomVerificationInPhoneVerifyWidget(
                  userName: widget.userName,
                  phoneNumber: widget.phoneNumber,
                  phoneId: widget.phoneId!,
                  onSignInSelected: widget.onSignInSelected,
                  onProfileSelected: widget.onProfileSelected,
                ),
              ],
            ),
            CustomBackToLoginInVerifyWidget(
                onSignInSelected: widget.onSignInSelected),
          ]),
        );
      }),
    );
  }
}
