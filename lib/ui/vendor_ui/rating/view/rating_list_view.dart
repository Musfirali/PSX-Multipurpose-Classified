import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/provider/rating/rating_list_provider.dart';
import '../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../core/vendor/repository/rating_repository.dart';
import '../../../../core/vendor/repository/user_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/rating_list_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/rating/component/list/rating_detail_widget.dart';
import '../../../custom_ui/rating/component/list/rating_list_data.dart';
import '../../common/base/ps_widget_with_appbar_with_two_provider.dart';
import '../../common/ps_admob_banner_widget.dart';
import '../../common/ps_ui_widget.dart';

class RatingListView extends StatefulWidget {
  const RatingListView({Key? key, required this.itemUserId}) : super(key: key);
  final String itemUserId;

  @override
  _RatingListViewState createState() => _RatingListViewState();
}

class _RatingListViewState extends State<RatingListView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  RatingRepository? ratingRepo;
  RatingListProvider? ratingProvider;
  UserProvider? userProvider;
  UserRepository? userRepository;
  PsValueHolder? psValueHolder;
  final ScrollController _scrollController = ScrollController();
  String? loginUserId;
  late RatingListHolder ratingListHolder;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ratingProvider!.loadNextDataList();
      }
    });
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  bool isConnectedToInternet = false;
  bool isSuccessfullyLoaded = true;

  void checkConnection() {
    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
      if (isConnectedToInternet && valueHolder.isShowAdmob!) {
        setState(() {});
      }
    });
  }

  late PsValueHolder valueHolder;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);
    if (!isConnectedToInternet && valueHolder.isShowAdmob!) {
      print('loading ads....');
      checkConnection();
    }
    Future<bool> _requestPop() {
      animationController.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    ratingRepo = Provider.of<RatingRepository>(context);
    userRepository = Provider.of<UserRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    loginUserId = psValueHolder!.loginUserId;
    return WillPopScope(
        onWillPop: _requestPop,
        child:
            PsWidgetWithAppBarWithTwoProvider<RatingListProvider, UserProvider>(
                appBarTitle: 'rating_list__title'.tr,
                initProvider1: () {
                  ratingProvider = RatingListProvider(repo: ratingRepo);
                  return ratingProvider;
                },
                onProviderReady1: (RatingListProvider? provider) async {
                  ratingListHolder = RatingListHolder(
                      userId: widget.itemUserId,
                      type: PsConst.RATING_TYPE_USER);
                  await provider!.loadDataList(
                      requestBodyHolder: ratingListHolder,
                      requestPathHolder: RequestPathHolder(
                          loginUserId: Utils.checkUserLoginId(psValueHolder),
                          headerToken: psValueHolder!.headerToken,
                          languageCode:
                              langProvider.currentLocale.languageCode));
                },
                initProvider2: () {
                  userProvider = UserProvider(
                      repo: userRepository, psValueHolder: psValueHolder);
                  return userProvider;
                },
                onProviderReady2: (UserProvider? userProvider) {
                  userProvider!.userParameterHolder.loginUserId =
                      userProvider.psValueHolder!.loginUserId;
                  // userProvider.userParameterHolder.id = widget.itemUserId;
                  userProvider.userParameterHolder.id = widget.itemUserId;
                  userProvider.getOtherUserData(
                      userProvider.userParameterHolder.toMap(),
                      widget.itemUserId,
                      langProvider.currentLocale.languageCode);
                },
                child: Consumer<RatingListProvider>(builder:
                    (BuildContext context, RatingListProvider ratingProvider,
                        Widget? child) {
                  /**
                           * UI SECTION
                           */
                  return Stack(
                    children: <Widget>[
                      RefreshIndicator(
                        child: CustomScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          slivers: <Widget>[
                            const SliverToBoxAdapter(
                              child: PsAdMobBannerWidget(),
                            ),
                            const CustomUserRatingDetailWidget(),
                            if (ratingProvider.hasData) CustomRatingListData()
                          ],
                        ),
                        onRefresh: () {
                          return ratingProvider.loadDataList(
                            reset: true,
                          );
                        },
                      ),
                      PSProgressIndicator(ratingProvider.currentStatus)
                    ],
                  );
                })));
  }
}
