// import 'package:flutter/material.dart';
// import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
// import '../../../../../../core/vendor/constant/ps_constants.dart';
// import '../../../../../custom_ui/user/verify_username/component/verify_username_view.dart';

// class CallVerifyUserNameWidget extends StatelessWidget {
//   const CallVerifyUserNameWidget(
//       {required this.animationController,
//       required this.updateUserCurrentIndex,
//       required this.currentIndex,
//       required this.userId});
//   final Function updateUserCurrentIndex;
//   final AnimationController? animationController;
//   final int? currentIndex;
//   final String? userId;
//   @override
//   Widget build(BuildContext context) {
//     return CustomVerifyUsernameView(
//       userId: userId,
//       animationController: animationController,
//       onProfileSelected: (String userId) {
//         if (currentIndex == PsConst.REQUEST_CODE__MENU_LOGIN_FRAGMENT) {
//           updateUserCurrentIndex('home__menu_drawer_profile'.tr,
//               PsConst.REQUEST_CODE__MENU_USER_PROFILE_FRAGMENT, userId);
//         } else {
//           updateUserCurrentIndex('home__menu_drawer_profile'.tr,
//               PsConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT, userId);
//         }
//       },
//     );
//   }
// }
