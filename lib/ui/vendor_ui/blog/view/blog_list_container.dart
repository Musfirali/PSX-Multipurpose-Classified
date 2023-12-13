import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../custom_ui/blog/component/list/blog_list_view.dart';
import '../../common/ps_app_bar_widget.dart';

class BlogListContainerView extends StatefulWidget {
  @override
  _BlogListContainerViewState createState() => _BlogListContainerViewState();
}

class _BlogListContainerViewState extends State<BlogListContainerView>
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
        '............................Build UI Again ............................');
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: const PsAppbarWidget(), // 'blog_list__app_bar_name'.tr,
        body: CustomBlogListView(animationController: animationController),
      ),
    );
  }
}
