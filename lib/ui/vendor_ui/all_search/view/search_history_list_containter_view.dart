import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../custom_ui/all_search/component/search_history/search_history_list_view.dart';
import '../../common/ps_app_bar_widget.dart';

class SearchHistoryListContainerView extends StatefulWidget {
  @override
  _SearchHistoryListContainerViewState createState() =>
      _SearchHistoryListContainerViewState();
}

class _SearchHistoryListContainerViewState
    extends State<SearchHistoryListContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
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

    print(
        '............................Build UI Again ............................');
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: PsAppbarWidget(
          appBarTitle: 'activity_log__search_history'.tr,
        ),
        body: CustomSerchHistoryListView(
          animationController: animationController,
        ),
      ),
    );
  }
}
