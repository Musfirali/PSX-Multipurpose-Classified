import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/category/category_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/blog.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/widget_provider_dyanmic.dart';
import 'package:psxmpc/ui/vendor_ui/sort_widget/ps_dynamic_provider.dart';
import 'package:psxmpc/ui/vendor_ui/sort_widget/ps_dynamic_widget.dart';

// import '../../../core/vendor/provider/product/search_product_provider.dart';
// import '../../../core/vendor/viewobject/holder/product_parameter_holder.dart';

class PSDynamicOptionWidget extends StatefulWidget {
  const PSDynamicOptionWidget({
    required this.animationController,
    required this.widgetList,
    required this.scrollController,
    this.blog,
    this.heroTagImage = '',
  });

  final AnimationController animationController;
  final WidgetProviderDynamic widgetList;
  final ScrollController scrollController;
  final Blog? blog;
  final String? heroTagImage;
  @override
  _HomeDashboardViewWidgetState createState() =>
      _HomeDashboardViewWidgetState();
}

class _HomeDashboardViewWidgetState extends State<PSDynamicOptionWidget> {
  Function? onrefresh;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: psDynamicProvider(context, (Function fn) {
          onrefresh = fn;
        },
            categoryProvider: (CategoryProvider pro) {},
            providerList: widget.widgetList.providerList!,
            // searchProductProvider: (SearchProductProvider pro){},
            // productParameterHolder: ProductParameterHolder().getRecentParameterHolder(),
            mounted: mounted),
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () {
              return onrefresh!();
            },
            child: PsDynamicWidget(
              animationController: widget.animationController,
              scrollController: widget.scrollController,
              widgetList: widget.widgetList.widgetList,
              blog: widget.blog ?? Blog(),
              heroTagImage: widget.heroTagImage ?? '',
              //isGrid: true,
            ),
          ),
        ));
  }
}