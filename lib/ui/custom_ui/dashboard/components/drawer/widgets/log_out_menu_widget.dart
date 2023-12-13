import 'package:flutter/material.dart';

import '../../../../../../core/vendor/provider/delete_task/delete_task_provider.dart';
import '../../../../../vendor_ui/dashboard/components/drawer/widgets/log_out_menu_widget.dart';

class CustomLogoutMenuWidget extends StatelessWidget {
  const CustomLogoutMenuWidget(
      {required this.callLogout,
      required this.deleteTaskProvider,
      required this.scaffoldKey,
      });
  final Function callLogout;
  final DeleteTaskProvider? deleteTaskProvider;
  final GlobalKey<ScaffoldState> scaffoldKey;
  
  @override
  Widget build(BuildContext context) {
    return LogoutMenuWidget(
      callLogout: callLogout,
      deleteTaskProvider: deleteTaskProvider,
      scaffoldKey: scaffoldKey
    );
  }
}
