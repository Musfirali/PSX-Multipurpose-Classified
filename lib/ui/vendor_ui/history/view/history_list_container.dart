import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_config.dart';
import '../../../custom_ui/history/component/list/history_list.dart';

class HistoryListContainerView extends StatefulWidget {
  @override
  _HistoryListContainerViewState createState() =>
      _HistoryListContainerViewState();
}

class _HistoryListContainerViewState extends State<HistoryListContainerView>
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
        '............................Build HistoryList UI Again ............................');
    return WillPopScope(
      onWillPop: _requestPop,
      /**
       * UI SECTION
       */
      child: Scaffold(
        body: CustomHistoryListView(
          animationController: animationController,
        ),
      ),
    );
  }
}
