import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class RememberMeCheckBoxWidget extends StatefulWidget {
  const RememberMeCheckBoxWidget(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<RememberMeCheckBoxWidget> createState() =>
      _RememberMeCheckBoxWidgetState();
}

class _RememberMeCheckBoxWidgetState extends State<RememberMeCheckBoxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final UserProvider provider = Provider.of<UserProvider>(context);
    return Container(
        padding: const EdgeInsets.only(bottom: PsDimens.space4),
        margin: const EdgeInsets.only(top: PsDimens.space16),
        child: InkWell(
          onTap: () {
            isChecked = !isChecked;

            setState(() {});
            print(isChecked);
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            SizedBox(
                height: 24.0,
                width: 24.0,
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: PsColors.text400),
                  child: Checkbox(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    activeColor: PsColors.achromatic500,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                        provider.isRememberMeChecked = value;
                      });
                      print(value!);
                    },
                  ),
                )),
            const SizedBox(width: 10.0),
            Text('Remember Me'.tr,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Utils.isLightMode(context)
                        ? PsColors.text800
                        : PsColors.achromatic50))
          ]),
        ));
  }
}
