import 'colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';

abstract class Dialogs {
  static Future<void>? alert(
    BuildContext context, {
    required String description,
    title,
    bool dismissible = true,
    String okText = 'OK',
    Key? key,
  }) {
    // assert(context != null);
    return showCupertinoDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (_) => WillPopScope(
        onWillPop: () async => dismissible,
        child: CupertinoAlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text(okText),
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool> confirm(
    BuildContext context, {
    String okText = "OK",
    String? description,
    title,
  }) async {
    final result = await showCupertinoModalPopup<bool>(
      context: context,
      builder: (_) => WillPopScope(
        child: CupertinoActionSheet(
          title: title != null ? Text(title) : null,
          message: description != null ? Text(description) : null,
          actions: [
            CupertinoActionSheetAction(
              child: Text(okText),
              onPressed: () {
                Navigator.pop(_, true);
              },
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(_, false);
              },
              isDestructiveAction: true,
              child: const Text("CANCEL"),
            )
          ],
        ),
        onWillPop: () async => false,
      ),
    );
    return result ?? false;
  }
}

abstract class ProgressDialog {
  static Future<void> show(BuildContext context) {
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Container(
          width: wp,
          height: hp,
          alignment: Alignment.center,
          child: const CupertinoActivityIndicator(
            color: primColor,
            radius: 15,
          ),
        ),
      ),
    );
  }
}
