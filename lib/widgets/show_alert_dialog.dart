import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String title, String content,
    [Function? onPressOK, Function? onPressCancel, bool noCancel = true]) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          textStyle: TextStyle(color: Colors.blue),
          onPressed: () {
            onPressOK != null ? onPressOK() : null;
            Navigator.pop(context);
          },
          child: const Text("OK"),
        ),
        if (!noCancel) ...[
          CupertinoDialogAction(
            textStyle: TextStyle(color: Colors.red),
            onPressed: () {
              onPressCancel != null ? onPressCancel() : null;
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
        ]
      ],
    ),
  );
}
