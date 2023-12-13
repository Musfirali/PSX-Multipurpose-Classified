import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/constant/ps_dimens.dart';
import 'package:psxmpc/core/vendor/constant/ps_provider_const.dart';
import 'package:psxmpc/core/vendor/constant/ps_widget_const.dart';
import 'package:psxmpc/core/vendor/provider/category/category_provider.dart';
import 'package:psxmpc/ui/vendor_ui/sort_widget/ps_dynamic_provider.dart';
import 'package:psxmpc/ui/vendor_ui/sort_widget/ps_dynamic_widget.dart';
import '../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../common/ps_app_bar_widget.dart';

class ProductListWithFilterView extends StatefulWidget {
  const ProductListWithFilterView({
    Key? key,
    required this.productParameterHolder,
    required this.animationController,
    required this.scaffoldKey,
    required this.title,
  }) : super(key: key);

  final ProductParameterHolder productParameterHolder;
  final AnimationController animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;

  @override
  _ProductListWithFilterViewState createState() =>
      _ProductListWithFilterViewState();
}

class _ProductListWithFilterViewState extends State<ProductListWithFilterView>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  SearchProductProvider? _searchProductProvider;

  bool isGrid = true;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _searchProductProvider!.loadNextDataList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        '............................Build UI Again............................');

    return Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(widget.scaffoldKey.currentContext ?? context)
                .viewPadding
                .top),
        child: WillPopScope(
          onWillPop: () async {
            return Future<bool>.value(false);
          },
          child: MultiProvider(
            providers: psDynamicProvider(context, (Function f) {},
                mounted: mounted,
                categoryProvider: (CategoryProvider pro) {},
                providerList: <String>[
                  PsProviderConst.init_search_product_provider,
                  // PsProviderConst.init_category_provider,
                ], searchProductProvider: (SearchProductProvider pro) {
              _searchProductProvider = pro;
            }, productParameterHolder: widget.productParameterHolder),
            child: Scaffold(
              appBar: PsAppbarWidget(
                appBarTitle: widget.title,
                leading: Center(
                    child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () =>
                      widget.scaffoldKey.currentState?.openDrawer(),
                )),
                actionWidgets: <Widget>[
                  if (isGrid)
                    IconButton(
                      icon: const Icon(Icons.grid_view, size: 20),
                      onPressed: () async {
                        setState(() {
                          isGrid = false;
                        });
                      },
                    )
                  else
                    IconButton(
                      icon:
                          const Icon(Icons.list, size: 28),
                      onPressed: () async {
                        setState(() {
                          isGrid = true;
                        });
                      },
                    ),
                ],
              ),
              body: Container(
                margin: const EdgeInsets.only(
                    bottom: PsDimens.space4),
                child: PsDynamicWidget(
                  animationController: widget.animationController,
                  scrollController: scrollController,
                  widgetList: const <String>[
                    PsWidgetConst.filter_nav_items,
                    PsWidgetConst.filter_item_list_view,
                    PsWidgetConst.ps_admob_banner_widget,
                  ],
                  isGrid: isGrid,
                ),
              ),
            ),
          ),
        ));
  }
}
