import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class TermsAndConCheckbox extends StatefulWidget {
  const TermsAndConCheckbox({
    required this.nameTextEditingController,
    required this.emailTextEditingController,
    required this.passwordTextEditingController,
  });

  final TextEditingController? nameTextEditingController,
      emailTextEditingController,
      passwordTextEditingController;
  @override
  __TermsAndConCheckboxState createState() => __TermsAndConCheckboxState();
}

class __TermsAndConCheckboxState extends State<TermsAndConCheckbox> {
  late UserProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, bottom: 12),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: PsDimens.space20,
          ),
          Checkbox(
            side: BorderSide(color: PsColors.primary500),
            checkColor: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
            activeColor: Theme.of(context).primaryColor,
            value: provider.isCheckBoxSelect,
            onChanged: (bool? value) {
              setState(() {
                updateCheckBox(
                    provider.isCheckBoxSelect,
                    context,
                    widget.nameTextEditingController,
                    widget.emailTextEditingController,
                    widget.passwordTextEditingController);
              });
            },
          ),
          Expanded(
            child: InkWell(
              child: Text(
                'login__agree_privacy'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                setState(() {
                  updateCheckBox(
                      provider.isCheckBoxSelect,
                      context,
                      widget.nameTextEditingController,
                      widget.emailTextEditingController,
                      widget.passwordTextEditingController);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void updateCheckBox(
      bool isCheckBoxSelect,
      BuildContext context,
      TextEditingController? nameTextEditingController,
      TextEditingController? emailTextEditingController,
      TextEditingController? passwordTextEditingController) {
    if (isCheckBoxSelect) {
      provider.isCheckBoxSelect = false;
    } else {
      provider.isCheckBoxSelect = true;
      //it is for holder
      provider.psValueHolder!.userNameToVerify =
          nameTextEditingController!.text;
      provider.psValueHolder!.userEmailToVerify =
          emailTextEditingController!.text;
      provider.psValueHolder!.userPasswordToVerify =
          passwordTextEditingController!.text;
      Navigator.pushNamed(context, RoutePaths.privacyPolicy);
    }
  }
}
