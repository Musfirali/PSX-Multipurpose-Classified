import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/product/paid_id_item_provider.dart';
import '../../../../../../core/vendor/repository/paid_ad_item_repository.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../custom_ui/user/paid_item_list/component/vertical/widgets/paid_ad_item_list.dart';
import '../../../../common/ps_ui_widget.dart';

class PaidAdItemListView extends StatefulWidget {
  const PaidAdItemListView({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
  @override
  _PaidAdItemListView createState() => _PaidAdItemListView();
}

class _PaidAdItemListView extends State<PaidAdItemListView>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  PaidAdItemProvider? _paidAdItemProvider;


  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _paidAdItemProvider!.loadNextDataList();
      }
    });

    super.initState();
  }

  PaidAdItemRepository? repo1;
  PsValueHolder? psValueHolder;
  dynamic data;
  @override
  Widget build(BuildContext context) {
    // data = EasyLocalizationProvider.of(context).data;
    repo1 = Provider.of<PaidAdItemRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    print(
        '............................Build UI Again ............................');
    // return EasyLocalizationProvider(
    //     data: data,
    //     child:
    return ChangeNotifierProvider<PaidAdItemProvider?>(
        lazy: false,
        create: (BuildContext context) {
          final PaidAdItemProvider provider =
              PaidAdItemProvider(repo: repo1, psValueHolder: psValueHolder);
          provider.loadDataList(
              requestPathHolder:
                  RequestPathHolder(loginUserId: psValueHolder!.loginUserId, headerToken: psValueHolder!.headerToken));
          _paidAdItemProvider = provider;
          return _paidAdItemProvider;
        },
        child: Consumer<PaidAdItemProvider>(
          builder: (BuildContext context, PaidAdItemProvider provider,
              Widget? child) {
            return Stack(children: <Widget>[
              RefreshIndicator(
                child: CustomScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    slivers: <Widget>[
                      if (provider.hasData || provider.currentStatus == PsStatus.BLOCK_LOADING)
                        CustomPaidAdItemList(
                          animationController: widget.animationController!,
                        )
                    ]),
                onRefresh: () async {
                  return _paidAdItemProvider!.loadDataList(reset: true);
                },
              ),
              PSProgressIndicator(provider.currentStatus)
            ]);
          },
        ));
  }
}
