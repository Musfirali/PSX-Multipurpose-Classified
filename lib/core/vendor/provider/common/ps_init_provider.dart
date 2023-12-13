import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

SingleChildWidget psInitProvider<T extends ChangeNotifier>(
    {Widget? widget,
    required Function initProvider,
    Function(T)? onProviderReady}) {
  return ChangeNotifierProvider<T>(
    lazy: false,
    create: (BuildContext context) {
      final T providerObj = initProvider();

      if (onProviderReady != null) {
        onProviderReady(providerObj);
      }
      return providerObj;
    },
    child: widget,
  );
}
