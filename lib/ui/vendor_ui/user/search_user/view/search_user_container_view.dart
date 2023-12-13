import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/provider/user/search_user_provider.dart';
import '../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../core/vendor/repository/search_user_repository.dart';
import '../../../../../core/vendor/repository/user_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/user/search_user/component/search_user_list_view.dart';
import '../../../common/ps_app_bar_widget.dart';

class SearchUserContainerView extends StatefulWidget {
  const SearchUserContainerView({
    required this.searchKeyword,
  });

  final String searchKeyword;

  @override
  _SearchUserContainerViewState createState() =>
      _SearchUserContainerViewState();
}

class _SearchUserContainerViewState extends State<SearchUserContainerView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  Animation<double>? animation;

  @override
  void dispose() {
    animationController.dispose();
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
    ).animate(animationController);
    super.initState();
  }

  late SearchUserRepository repo;
  late UserRepository userRepo;
  late SearchUserProvider searchUserProvider;
  late UserProvider userProvider;
  late PsValueHolder psValueHolder;
  late AppLocalization langProvider;
  @override
  Widget build(BuildContext context) {
    repo = Provider.of<SearchUserRepository>(context);
    userRepo = Provider.of<UserRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    langProvider = Provider.of<AppLocalization>(context);

    return MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<UserProvider?>(
              lazy: false,
              create: (BuildContext context) {
                userProvider =
                    UserProvider(repo: userRepo, psValueHolder: psValueHolder);
                return userProvider;
              }),
          ChangeNotifierProvider<SearchUserProvider?>(
              lazy: false,
              create: (BuildContext context) {
                searchUserProvider = SearchUserProvider(
                    repo: repo, psValueHolder: psValueHolder);
                searchUserProvider.searchUserParameterHolder.keyword =
                    widget.searchKeyword;

                searchUserProvider.loadDataList(
                    requestBodyHolder:
                        searchUserProvider.searchUserParameterHolder,
                    requestPathHolder: RequestPathHolder(
                        loginUserId: Utils.checkUserLoginId(psValueHolder),
                        languageCode: langProvider.currentLocale.languageCode));
                return searchUserProvider;
              }),
        ],
        child: Consumer2<UserProvider, SearchUserProvider>(builder:
            (BuildContext context, UserProvider userProvider,
                SearchUserProvider searchUserProvider, Widget? child) {
          /**
          * UI SECTION
          */
          return Scaffold(
            body: Column(children: <Widget>[
              PsAppbarWidget(
                appBarTitle: 'Users'.tr,
              ),
              CustomUserSearchListView(
                animationController: animationController,
                animation: animation!,
              )
            ]),
          );
        }));
  }
}
