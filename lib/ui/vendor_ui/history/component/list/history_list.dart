import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/history/history_provider.dart';
import '../../../../../core/vendor/repository/history_repsitory.dart';
import '../../../../../core/vendor/viewobject/selection.dart';
import '../../../../custom_ui/history/component/list/widgets/history_list_data.dart';
import '../../../common/dialog/confirm_dialog_view.dart';
import '../../../common/ps_admob_banner_widget.dart';
import '../../../common/ps_app_bar_widget.dart';

class HistoryListView extends StatefulWidget {
  const HistoryListView({
    Key? key,
    required this.animationController,
  }) : super(key: key);
  final AnimationController? animationController;

  @override
  _HistoryListViewState createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView>
    with SingleTickerProviderStateMixin {
  late HistoryRepository historyRepo;
  dynamic data;
  bool isChecked = false;
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
  }

  bool isConnectedToInternet = false;
  bool isSuccessfullyLoaded = true;
  List<Selection> productSelection = <Selection>[];

  @override
  Widget build(BuildContext context) {
    historyRepo = Provider.of<HistoryRepository>(context);

    return ChangeNotifierProvider<HistoryProvider>(
        lazy: false,
        create: (BuildContext context) {
          final HistoryProvider provider = HistoryProvider(
            repo: historyRepo,
          );
          provider.loadDataListFromDatabase();
          return provider;
        },
        child: Consumer<HistoryProvider>(
          builder:
              (BuildContext context, HistoryProvider provider, Widget? child) {
            /**
               * UI SECTION
               */
            return Column(
              children: <Widget>[
                // const PsAdMobBannerWidget(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: PsDimens.space10),
                    child: RefreshIndicator(
                      child: CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: <Widget>[
                            PsAppbarWidget(
                              useSliver: true,
                              appBarTitle: 'activity_log__browse_history'.tr,
                              actionWidgets: <Widget>[
                                if (isSelected)
                                  InkWell(
                                    onTap: () {
                                      showDialog<dynamic>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ConfirmDialogView(
                                                title:
                                                    'browse_history__delete_dialog_title'
                                                        .tr,
                                                description:
                                                    'history_list__delete_dialog_message'
                                                        .tr,
                                                leftButtonText:
                                                    'dialog__cancel'.tr,
                                                rightButtonText:
                                                    'logout_dialog__confirm'.tr,
                                                onAgreeTap: () async {
                                                  Navigator.pop(context);
                                                  for (Selection e
                                                      in productSelection) {
                                                    if (e.isSelected) {
                                                      productSelection
                                                          .remove(e);
                                                      provider
                                                          .deleteFromDatabase(
                                                              e.product);
                                                    }
                                                  }
                                                });
                                          });
                                    },
                                    child: const Icon(
                                      Icons.delete_rounded,
                                    ),
                                  ),
                                if (isSelected)
                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    value: isChecked,
                                    checkColor: PsColors.achromatic50,
                                    activeColor: Theme.of(context).primaryColor,
                                    onChanged: (bool? value) {
                                      for (Selection e in productSelection) {
                                        e.isSelected = value!;
                                      }
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                              ],
                            ),
                            const PsAdMobBannerWidget(
                              useSliver: true,
                            ),
                            if (provider.hasData)
                              CustomHistoryListData(
                                  animationController:
                                      widget.animationController!,
                                  isSelected: isSelected,
                                  onTap: () {
                                    setState(() {
                                      isSelected = !isSelected;
                                    });
                                  },
                                  onLongPrass: () {
                                    setState(() {
                                      isSelected = true;
                                    });
                                  },
                                  productSelection: productSelection),
                          ]),
                      onRefresh: () {
                        return provider.loadDataListFromDatabase();
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        )
        // )
        );
  }
}
