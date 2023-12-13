import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../vendor/provider/language/app_localization_provider.dart';
import '../../vendor/utils/utils.dart';
import '/config/ps_colors.dart';

class PsProgressDialog {
  PsProgressDialog._();

  static ProgressDialog? _progressDialog;
  // static ProgressDialog _progressDownloadDialog;

  static Future<bool> showDialog(BuildContext context,
      {String? message}) async {
    if (_progressDialog == null) {
      _progressDialog = ProgressDialog(context,
          type: ProgressDialogType.normal,
          isDismissible: false,
          showLogs: true);

      _progressDialog!.style(
          message: message ?? 'loading_dialog__loading'.tr,
          borderRadius: 5.0,
          backgroundColor: Utils.isLightMode(context)
              ? PsColors.achromatic50
              : PsColors.achromatic900,
          progressWidget: Container(
              padding: const EdgeInsets.all(10.0),
              child: const CircularProgressIndicator()),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progress: 0.0,
          maxProgress: 100.0,
          progressTextStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).primaryColor),
          messageTextStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).primaryColor));
    }

    if (message != null) {
      _progressDialog!.update(message: message);
    }

    await _progressDialog!.show();

    return true;
  }

  static void dismissDialog() {
    if (_progressDialog != null) {
      _progressDialog!.hide();
      _progressDialog = null;
    }
  }

  static bool isShowing() {
    if (_progressDialog != null) {
      return _progressDialog!.isShowing();
    } else {
      return false;
    }
  }

  static void showDownloadDialog(BuildContext context, double progress,
      {String? message}) {
    if (_progressDialog == null) {
      _progressDialog = ProgressDialog(context,
          type: ProgressDialogType.download,
          isDismissible: false,
          showLogs: true);

      _progressDialog!.style(
          message: message ?? 'loading_dialog__loading'.tr,
          borderRadius: 5.0,
          backgroundColor: PsColors.achromatic50,
          progressWidget: Container(
              padding: const EdgeInsets.all(10.0),
              child: const CircularProgressIndicator()),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progress: progress,
          maxProgress: 100.0,
          progressTextStyle: Theme.of(context).textTheme.bodyLarge,
          messageTextStyle: Theme.of(context).textTheme.bodyLarge);
    }

    _progressDialog!.update(
        message: message ?? 'loading_dialog__loading'.tr, progress: progress);

    if (!_progressDialog!.isShowing()) {
      _progressDialog!.show();
    }
  }

  static void dismissDownloadDialog() {
    if (_progressDialog != null) {
      _progressDialog!.hide();
      _progressDialog = null;
    }
  }
}
