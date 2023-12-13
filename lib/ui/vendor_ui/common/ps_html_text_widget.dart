import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';

class PsHTMLTextWidget extends StatelessWidget {
  const PsHTMLTextWidget({
    Key? key,
    required this.htmlData,
    this.style,
    this.useSliver = false,
  }) : super(key: key);

  final String htmlData;
  final bool useSliver;
  final Style? style;

  @override
  Widget build(BuildContext context) {
    if (useSliver)
      return SliverToBoxAdapter(
          child: _HTMLTextWidget(
        htmlData: htmlData,
        style: style,
      ));
    else
      return _HTMLTextWidget(htmlData: htmlData, style: style);
  }
}

class _HTMLTextWidget extends StatelessWidget {
  const _HTMLTextWidget({Key? key, required this.htmlData, this.style})
      : super(key: key);

  final String htmlData;
  final Style? style;
  @override
  Widget build(BuildContext context) {
    final Style htmlStyle = style ??
        Style(
          fontWeight: FontWeight.normal,
        );
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(
              top: PsDimens.space6,
              left: PsDimens.space6,
              right: PsDimens.space6,
              bottom: PsDimens.space12),
          child: Html(
            data: htmlData,
            // ignore: always_specify_types
            style: {
              '#': htmlStyle,
              'table': Style(
                backgroundColor: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
                //  width: MediaQuery.of(context).size.width,
              ),
              'tr': Style(
                border: Border(
                  bottom: BorderSide(color: PsColors.achromatic500),
                ),
              ),
              'th': Style(
                padding: HtmlPaddings.all(6),
                backgroundColor: PsColors.achromatic500,
              ),
              'td': Style(
                padding: HtmlPaddings.all(6),
                alignment: Alignment.center,
                width: Width(120),
              ),
            },
            onLinkTap: (String? url, _, __) async {
              if (url != null && await canLaunchUrl(Uri.parse(url)))
                await launchUrl(Uri.parse(url));
              else // can't launch url, there is some error
                throw 'Could not launch $url';
            },
            // ignore: always_specify_types
            // customRender: {
            //   'table': (RenderContext context, Widget child) {
            //     return SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: (context.tree as TableLayoutElement).toWidget(context),
            //     );
            //   },
            //   'bird': (RenderContext context, Widget child) {
            //     return const TextSpan(text: '🐦');
            //   },
            //   'flutter': (RenderContext context, Widget child) {
            //     return FlutterLogo(
            //       style:
            //           (context.tree.element!.attributes['horizontal'] != null)
            //               ? FlutterLogoStyle.horizontal
            //               : FlutterLogoStyle.markOnly,
            //       textColor: context.style.color!,
            //       size: context.style.fontSize!.size! * 5,
            //     );
            //   },
            // },
          )),
    );
  }
}
