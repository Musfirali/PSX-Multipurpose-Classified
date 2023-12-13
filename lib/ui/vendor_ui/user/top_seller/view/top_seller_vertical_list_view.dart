import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/user/top_seller_provider.dart';
import 'package:psxmpc/core/vendor/repository/top_seller_repository.dart';
import 'package:psxmpc/core/vendor/repository/user_repository.dart';

import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/user/top_seller/component/top_seller_vertical_list_widget.dart';
import '../../../common/ps_app_bar_widget.dart';

class TopSellerVerticalListViewContainer extends StatefulWidget {
  const TopSellerVerticalListViewContainer();
  @override
  State<StatefulWidget> createState() {
    return _TopSellerVerticalListViewContainer();
  }
}

class _TopSellerVerticalListViewContainer
    extends State<TopSellerVerticalListViewContainer>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  TopSellerRepository? repo1;
  UserRepository? userRepo;
  TopSellerProvider? provider;
  late PsValueHolder valueHolder;
  late AppLocalization langProvider;
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    animationController!.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(animationController!);

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        provider!.loadNextDataList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    repo1 = Provider.of<TopSellerRepository>(context);
    userRepo = Provider.of<UserRepository>(context);
    valueHolder = Provider.of<PsValueHolder>(context);

    print(
        '............................Build UI Again ............................');

    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<UserProvider?>(
              lazy: false,
              create: (BuildContext context) {
                return UserProvider(repo: userRepo, psValueHolder: valueHolder);
              }),
          ChangeNotifierProvider<TopSellerProvider?>(
              lazy: false,
              create: (BuildContext context) {
                provider =
                    TopSellerProvider(repo: repo1, psValueHolder: valueHolder,);

                provider!.loadDataList(
                    requestPathHolder: RequestPathHolder(
                        headerToken: valueHolder.headerToken,
                        loginUserId: Utils.checkUserLoginId(valueHolder),
                        languageCode: langProvider.currentLocale.languageCode));
                return provider;
              }),
        ],
        child: Consumer<UserProvider>(builder:
            (BuildContext context, UserProvider userProvider,
                Widget? child) {
          /**
          * UI SECTION
          */
          return Scaffold(
              appBar: PsAppbarWidget(
              appBarTitle: 'top_rated_seller_list'.tr,
                ),
            body: CustomScrollView(
                controller: _controller,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
              slivers: <Widget>[ 
                CustomTopSellerVerticalListWidget(
                  animationController: animationController!,
                  controller: _controller,),
            ] )
          );
        }));
  }
}
