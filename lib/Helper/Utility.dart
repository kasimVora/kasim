import 'package:flutter/material.dart';

showDialogWithLoad(context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          insetPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: const [
                      SizedBox(
                        height: 20,width: 20,
                          child: CircularProgressIndicator()
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}