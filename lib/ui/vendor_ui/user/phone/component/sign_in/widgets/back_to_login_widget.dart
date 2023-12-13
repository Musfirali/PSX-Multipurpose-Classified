import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';

class BackToLoginWidget extends StatefulWidget {
  const BackToLoginWidget({this.goToLoginSelected});
  final Function? goToLoginSelected;
  @override
  __TextWidgetState createState() => __TextWidgetState();
}

class __TextWidgetState extends State<BackToLoginWidget> {
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
    return InkWell(
      child: Container(
        height: 40,
        child: Center(
          child: Text(
            'phone_signin__back_login'.tr,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
      onTap: () {
        if (widget.goToLoginSelected != null) {
          widget.goToLoginSelected!();
        } else {
          if (psValueHolder.isForceLogin!) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacementNamed(
              context,
              RoutePaths.login_container,
            );
          }
        }
      },
    );
  }
}
