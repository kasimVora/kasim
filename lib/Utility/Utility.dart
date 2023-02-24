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

String getTimeDifferenceFromNow(DateTime dateTime) {
  Duration difference = DateTime.now().difference(dateTime);
  if (difference.inSeconds < 5) {
    return "Just now";
  } else if (difference.inMinutes < 1) {
    return "${difference.inSeconds}s ago";
  } else if (difference.inHours < 1) {
    return "${difference.inMinutes}m ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours}h ago";
  } else {
    return "${difference.inDays}d ago";
  }
}

String getChatId(String uid, String uid2) {
  String ids = "";
  List<String> id = "${uid}_$uid2".split("_")..sort();
  ids = id.join("_");
  return ids;
}