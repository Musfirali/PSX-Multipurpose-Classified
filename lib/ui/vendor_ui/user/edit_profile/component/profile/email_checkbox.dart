import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';

class EmailCheckboxWidget extends StatefulWidget {
  @override
  _EmailCheckboxState createState() => _EmailCheckboxState();
}

class _EmailCheckboxState extends State<EmailCheckboxWidget> {
  void toggleCheckbox(UserProvider userProvider, bool value) {
    if (value) {
      userProvider.user.data!.isShowEmail = '1';
    } else {
      userProvider.user.data!.isShowEmail = '0';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    bool isChecked = false;

    if (userProvider.user.data != null) {
      isChecked = userProvider.user.data!.isShowEmail == '1';
    }
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
              left: PsDimens.space16, right: PsDimens.space8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'edit_profile__show_email'.tr,
                ),
              ),
              SizedBox(
                width: 60,
                height: 30,
                child: Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    value: isChecked,
                    onChanged: (bool? value) {
                      toggleCheckbox(userProvider, value!);
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
