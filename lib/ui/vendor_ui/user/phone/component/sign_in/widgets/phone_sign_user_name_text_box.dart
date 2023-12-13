import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/utils/utils.dart';

class PhoneSignUserNameTextBox extends StatelessWidget {
  const PhoneSignUserNameTextBox({
    required this.nameController,
  });

  final TextEditingController? nameController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Text(
            'edit_profile__user_name'.tr,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: Utils.isLightMode(context)
                    ? PsColors.text800
                    : PsColors.achromatic50),
          ),
        ),
        SizedBox(
          height: PsDimens.space40,
          child: TextField(
            controller: nameController,
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
      ],
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
