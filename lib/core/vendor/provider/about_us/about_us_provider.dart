import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/request_path_holder.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/about_us_repository.dart';
import '../../viewobject/about_us.dart';
import '../common/ps_provider.dart';

class AboutUsProvider extends PsProvider<AboutUs> {
  AboutUsProvider({
    required AboutUsRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.SINGLE_OBJECT_SUBSCRIPTION);

  PsResource<AboutUs> get aboutUs => super.data;
}

SingleChildWidget initAboutUsProvider(
  BuildContext context,
  Function function, {
  Widget? widget,
}) {
  final AboutUsRepository repo = Provider.of<AboutUsRepository>(context);
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  return psInitProvider<AboutUsProvider>(
      initProvider: () => AboutUsProvider(
            repo: repo,
          ),
      onProviderReady: (AboutUsProvider provider) {
        provider.loadData(
          requestPathHolder: RequestPathHolder(
              loginUserId: valueHolder.loginUserId,
              languageCode: valueHolder.languageCode),
        );
        function(provider);
      });
}
