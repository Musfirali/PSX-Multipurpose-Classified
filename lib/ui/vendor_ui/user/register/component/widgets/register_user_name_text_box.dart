import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class RegisterUserNameTextBox extends StatelessWidget {
  const RegisterUserNameTextBox({
    required this.userNameController,
  });

  final TextEditingController? userNameController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space16, right: PsDimens.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'User Name'.tr,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Utils.isLightMode(context)
                      ? PsColors.text800
                      : PsColors.achromatic50),
            ),
          ),
          SizedBox(
            height: 40,
            child: TextField(
              controller: userNameController,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.0, color: PsColors.text400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.0, color: PsColors.text400),
                ),
                hintText: 'register__user_name'.tr,
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: PsColors.text400),
              ),
            ),
          ),
           Padding(
                    padding: const EdgeInsets.only(
                      left: PsDimens.space4,
                       top: PsDimens.space4,
                      right: PsDimens.space16,
                    ),
                    child: Text(
                      'register_username__desc'.tr,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Utils.isLightMode(context)
                              ? PsColors.text400
                              : PsColors.achromatic50),
                    ),
                  ),
        ],
      ),
    );
    // return Container(
    //   margin: const EdgeInsets.only(
    //       left: PsDimens.space28, right: PsDimens.space28),
    //   child: TextField(
    //     controller: nameController,
    //     style: Theme.of(context).textTheme.button!.copyWith(),
    //     decoration: InputDecoration(
    //         border: const OutlineInputBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
    //           borderSide: BorderSide.none,
    //         ),
    //         filled: true,
    //         fillColor: PsColors.cardBackgroundColor,
    //         hintText: 'register__user_name'.tr,
    //         hintStyle: Theme.of(context).textTheme.button!.copyWith(
    //             color: Utils.isLightMode(context)
    //                 ? PsColors.txtPrimaryLightColor
    //                 : PsColors.primaryDarkGrey),
    //         prefixIcon:
    //             Icon(Icons.people, color: Theme.of(context).iconTheme.color)),
    //   ),
    // );
  }
}
