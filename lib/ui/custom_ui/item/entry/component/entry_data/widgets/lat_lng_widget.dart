// import 'package:flutter/material.dart';
// import 'package:psxmpc/vendor/constant/ps_dimens.dart';
// import 'package:psxmpc/vendor/provider/language/app_localization_provider.dart';

// class LatLngWidget extends StatelessWidget {
//   const LatLngWidget(
//       {required this.latitudeController, required this.longitudeController});
//   final TextEditingController latitudeController;
//   final TextEditingController longitudeController;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Row(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//               child: Text('item_entry__latitude'.tr,
//                   style: Theme.of(context).textTheme.caption),
//             ),
//             Container(
//               padding: const EdgeInsets.only(right: PsDimens.space120),
//               child: Text(latitudeController.text,
//                   textAlign: TextAlign.start,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                   style: Theme.of(context).textTheme.caption),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//               child: Text('item_entry__longitude'.tr,
//                   style: Theme.of(context).textTheme.caption),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Text(longitudeController.text,
//                   textAlign: TextAlign.start,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                   style: Theme.of(context).textTheme.caption),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
