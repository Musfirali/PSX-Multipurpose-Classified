import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/blog/blog_provider.dart';
import '../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../core/vendor/repository/blog_repository.dart';
import '../../../../../core/vendor/utils/utils.dart';
import '../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../custom_ui/blog/component/list/widgets/blog_list_data.dart';
import '../../../../custom_ui/blog/component/list/widgets/blog_list_data_empty_box.dart';
import '../../../common/ps_ui_widget.dart';

class BlogListView extends StatefulWidget {
  const BlogListView({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  _BlogListViewState createState() => _BlogListViewState();
}

class _BlogListViewState extends State<BlogListView>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late BlogRepository repo1;
  late PsValueHolder valueHolder;
  late AppLocalization langProvider;
  late BlogProvider blogProvider;


  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        blogProvider.loadNextDataList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);
    langProvider = Provider.of<AppLocalization>(context, listen: false);
    final BlogRepository repo1 = Provider.of<BlogRepository>(context);

    return ChangeNotifierProvider<BlogProvider>(
        lazy: false,
        create: (BuildContext context) {
          blogProvider = BlogProvider(
              repo: repo1, limit: valueHolder.blockItemLoadingLimit!);
          blogProvider.blogParameterHolder.cityId = valueHolder.locationId;
          blogProvider.loadDataList(
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(valueHolder),
                languageCode: langProvider.currentLocale.languageCode),
            requestBodyHolder: blogProvider.blogParameterHolder,
          );
          return blogProvider;
        },
        child: Consumer<BlogProvider>(builder:
            (BuildContext context, BlogProvider provider, Widget? child) {
          return Stack(
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(
                      left: PsDimens.space16,
                      right: PsDimens.space16,
                      top: PsDimens.space8,
                      bottom: PsDimens.space8),
                  child: RefreshIndicator(
                    child: CustomScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: false,
                        slivers: <Widget>[
                          if (blogProvider.hasData)
                            CustomBlogListData(
                                animationController:
                                    widget.animationController!)
                          else
                            CustomBlogListEmptyBox(),
                        ]),
                    onRefresh: () {
                      return blogProvider.loadDataList(reset: true);
                    },
                  )),
              PSProgressIndicator(blogProvider.currentStatus)
            ],
          );
        }));
  }
}
