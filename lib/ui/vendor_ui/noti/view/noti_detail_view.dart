import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/noti/noti_provider.dart';
import '../../../../core/vendor/repository/noti_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/noti.dart';
import '../../../custom_ui/noti/component/detail/noti_photo.dart';
import '../../common/base/ps_widget_with_appbar.dart';

class NotiView extends StatefulWidget {
  const NotiView({this.noti});
  final Noti? noti;

  @override
  _NotiViewState createState() => _NotiViewState();
}

class _NotiViewState extends State<NotiView>
    with SingleTickerProviderStateMixin {
  NotiRepository? notiRepository;
  NotiProvider? notiProvider;
  PsValueHolder? _psValueHolder;
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    notiRepository = Provider.of<NotiRepository>(context);
    _psValueHolder = Provider.of<PsValueHolder>(context);

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

    print(
        '............................Build UI Again ............................');
    return WillPopScope(
        onWillPop: _requestPop,
        child: PsWidgetWithAppBar<NotiProvider>(
            appBarTitle: '',
            initProvider: () {
              return NotiProvider(
                  repo: notiRepository, psValueHolder: _psValueHolder);
            },
            onProviderReady: (NotiProvider provider) {
              // if (!Utils.isLoginUserEmpty(provider.psValueHolder) &&
              //     provider.psValueHolder!.deviceToken != null &&
              //     provider.psValueHolder!.deviceToken != '') {
              //   final NotiPostParameterHolder notiPostParameterHolder =
              //       NotiPostParameterHolder(
              //           notiId: widget.noti!.id,
              //           notiType: widget.noti!.type,
              //           userId: provider.psValueHolder!.loginUserId,
              //           deviceToken: provider.psValueHolder!.deviceToken);
              //   provider.postNoti(notiPostParameterHolder.toMap(),
              //       provider.psValueHolder!.loginUserId);
              // }
              notiProvider = provider;
            },
            builder:
                (BuildContext context, NotiProvider provider, Widget? child) {
              if (widget.noti != null) {
                return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: <Widget>[
                      CustomNotiPhoto(defaultPhoto: widget.noti!.defaultPhoto!),
                      Padding(
                        padding: const EdgeInsets.only(right: PsDimens.space16),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.noti!.addedDate == ''
                                ? ''
                                : Utils.getDateFormat(widget.noti!.addedDate!,
                                    _psValueHolder!.dateFormat!),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: PsDimens.space16),
                        child: Text(widget.noti!.message!,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: PsDimens.space16),
                        child: Text(
                          widget.noti!.description ?? '',
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(height: 1.5),
                        ),
                      ),
                    ]));
              } else {
                return const SizedBox();
              }
            }));
  }
}
