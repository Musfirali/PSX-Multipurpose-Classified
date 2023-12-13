import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotiListNoData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotiListDataState();
}

class _NotiListDataState extends State<NotiListNoData> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 245,
              height: 200,
              child: SvgPicture.asset(
                'assets/images/no_notification.svg',
              )),
          const SizedBox(
            height: 20,
          ),
          Text(
            'You currently have no notification.',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
          )
        ],
      ),
    );
  }
}
