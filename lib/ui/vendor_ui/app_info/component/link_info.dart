import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/vendor/utils/utils.dart';

class LinkInfo extends StatelessWidget {
  const LinkInfo({
    Key? key,
    this.icon,
    this.imageName,
    required this.title,
    required this.link,
  }) : super(key: key);

  final IconData? icon;
  final String? imageName;
  final String title;
  final String? link;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: InkWell(
        onTap: () async {
          if (link != null && await canLaunchUrl(Uri.parse(link!))) {
            await launchUrl(Uri.parse(link ?? ''));
          } else {
            throw 'Could not launch $link';
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: Utils.isLightMode(context) ? PsColors.text300 : PsColors.text50),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (icon != null)
                Icon(
                  icon,
                  size: 20,
                )
              else if (imageName != null)
                SizedBox(
                  width: 20,
                  height: 19,
                  child: SvgPicture.asset(
                    imageName!,
                    colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn)
                  ),
                ),
              const SizedBox(
                width: 10,
              ),
              Text(
                link ?? '',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Utils.isLightMode(context)
                        ? PsColors.achromatic800
                        : PsColors.achromatic50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
