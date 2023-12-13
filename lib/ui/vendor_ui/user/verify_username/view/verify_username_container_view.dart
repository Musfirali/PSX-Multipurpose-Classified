// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:psxmpc/config/ps_config.dart';

// import '../../../../../../core/vendor/provider/user/user_provider.dart';
// import '../../../../../../core/vendor/repository/user_repository.dart';
// import '../../../../custom_ui/user/verify_username/component/verify_username_view.dart';
// import '../../../common/ps_app_bar_widget.dart';

// class VerifyUsernameContainerView extends StatefulWidget {
//   const VerifyUsernameContainerView({required this.userId});
//   final String userId;
//   @override
//   _CityVerifyUsernameContainerViewState createState() =>
//       _CityVerifyUsernameContainerViewState();
// }

// class _CityVerifyUsernameContainerViewState extends State<VerifyUsernameContainerView>
//     with SingleTickerProviderStateMixin {
//   AnimationController? animationController;
//   @override
//   void initState() {
//     animationController =
//         AnimationController(duration: PsConfig.animation_duration, vsync: this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     animationController!.dispose();
//     super.dispose();
//   }

//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   UserProvider? userProvider;
//   UserRepository? userRepo;

//   @override
//   Widget build(BuildContext context) {
//     Future<bool> _requestPop() {
//       animationController!.reverse().then<dynamic>(
//         (void data) {
//           if (!mounted) {
//             return Future<bool>.value(false);
//           }
//           Navigator.pop(context, true);
//           return Future<bool>.value(true);
//         },
//       );
//       return Future<bool>.value(false);
//     }

//     print(
//         '............................Build UI Again ............................');
//     userRepo = Provider.of<UserRepository>(context);

//     return WillPopScope(
//         onWillPop: _requestPop,
//         child: Scaffold(
//             appBar: const PsAppbarWidget(appBarTitle: 'Username Verify'),
//             body: CustomVerifyUsernameView(
//               animationController: animationController,
//               userId: widget.userId,
//             ),
//             ));
//   }
// }
