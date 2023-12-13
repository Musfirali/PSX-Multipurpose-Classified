// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:psxmpc/ui/vendor_ui/common/ps_button_widget.dart';
// import 'package:psxmpc/ui/vendor_ui/common/ps_textfield_widget.dart';

// import '../../../../../../core/vendor/constant/ps_dimens.dart';
// import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
// import '../../../../../../core/vendor/provider/user/user_provider.dart';
// import '../../../../../../core/vendor/repository/user_repository.dart';
// import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
// import '../../../../../config/route/route_paths.dart';
// import '../../../common/ps_header_icon_and_dynamic_text_widget.dart';

// class VerifyUsernameView extends StatefulWidget {
//   const VerifyUsernameView(
//       {Key? key,
//       this.animationController,
//       this.onProfileSelected,
//       this.userId})
//       : super(key: key);

//   final AnimationController? animationController;
//   final Function? onProfileSelected;
//   final String? userId;
//   @override
//   _VerifyUsernameViewState createState() => _VerifyUsernameViewState();
// }

// class _VerifyUsernameViewState extends State<VerifyUsernameView> {
//   UserRepository? repo1;
//   PsValueHolder? psValueHolder;
//   final TextEditingController userNameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     widget.animationController!.forward();

//     repo1 = Provider.of<UserRepository>(context);
//     psValueHolder = Provider.of<PsValueHolder>(context);

//     return ChangeNotifierProvider<UserProvider>(
//       lazy: false,
//       create: (BuildContext context) {
//         final UserProvider provider =
//             UserProvider(repo: repo1, psValueHolder: psValueHolder);
//         provider.getUser(widget.userId, psValueHolder!.languageCode!);
//         return provider;
//       },
//       child: Consumer<UserProvider>(builder:
//           (BuildContext context, UserProvider provider, Widget? child) {
//         return SingleChildScrollView(
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 PsHeaderIconAndDynamicTextWidget(
//                     text: 'Username and Password'.tr),
//                 PsTextFieldWidget(
//                   titleText: 'Username',
//                   hintText: 'Enter your Username',
//                   textEditingController: userNameController,
//                 ),
//                 PsTextFieldWidget(
//                   titleText: 'Password',
//                   hintText: 'Enter your Password',
//                   textEditingController: passwordController,
//                 ),
//                 if (provider.hasData)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: PsDimens.space16,
//                         vertical: PsDimens.space20),
//                     child: PSButtonWidget(
//                       titleText: 'Comfirm',
//                       onPressed: () {
//                         if (widget.onProfileSelected != null) {
//                           widget.onProfileSelected!(provider.data.data!.userId);   
//                         } else {
//                           if (psValueHolder!.isForceLogin!) {
//                           if (psValueHolder!.isLanguageConfig! &&
//                               psValueHolder!.showOnboardLanguage) {
//                             Navigator.pushReplacementNamed(
//                                 context, RoutePaths.languagesetting);
//                           } else {
//                             if (psValueHolder!.locationId != null) {
//                               Navigator.pushReplacementNamed(
//                                 context,
//                                 RoutePaths.home,
//                               );
//                             } else {
//                               Navigator.pushReplacementNamed(
//                                 context,
//                                 RoutePaths.itemLocationList,
//                               );
//                             }
//                           }
//                         } else {
//                           Navigator.pop(context, provider.data.data);
//                         }
//                         }
//                       },
//                     ),
//                   )
//                 else
//                   const SizedBox()
//               ]),
//         );
//       }),
//     );
//   }
// }
