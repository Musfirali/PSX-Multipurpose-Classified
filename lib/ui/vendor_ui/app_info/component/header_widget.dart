import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/provider/about_us/about_us_provider.dart';
import '../../../../core/vendor/viewobject/default_photo.dart';
import '../../common/ps_ui_widget.dart';

class HeaderImageWidget extends StatelessWidget {
  const HeaderImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AboutUsProvider aboutUsProvider =
        Provider.of<AboutUsProvider>(context);
    return Stack(
      children: <Widget>[
        PsNetworkImage(
          photoKey: '',
          defaultPhoto:
              aboutUsProvider.aboutUs.data!.defaultPhoto ?? '' as DefaultPhoto,
          width: MediaQuery.of(context).size.width,
          height: 200,
          boxfit: BoxFit.cover,
          imageAspectRation: PsConst.Aspect_Ratio_full_image,
          onTap: () {},
        ),
      ],
    );
  }
}
