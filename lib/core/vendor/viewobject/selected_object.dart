import 'package:flutter/widgets.dart';

class SelectedObject {
  SelectedObject(
      {required this.valueTextController, required this.idTextController});
  TextEditingController idTextController = TextEditingController();

  TextEditingController valueTextController = TextEditingController();
}