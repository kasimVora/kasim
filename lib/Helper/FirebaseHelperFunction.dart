

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';



// UserModel? loggedInUser;
 const serverKey = "AAAAk2K7zo0:APA91bHmdm2evd6BVgI6FfisVJdmRBGCLCeKwHvtT7rxEMue5gBf0WTiFDDk3BCCpV97pf8mT3ySWR_qd-q28Qfe08hTkq9RKr8pbTPUEz7kV4mvIWsGSXrzEMmwUf5ZyYc164QGCHBq";
 const firebaseUrl = 'https://fcm.googleapis.com/fcm/send';

// Future<UserModel>  getUserFromUid(String id) async{
//   UserModel? user;
//   try{
//     final data = await userRef.doc(id).get();
//     user = UserModel.fromJson(data.data()!);
//     print(jsonEncode(user));
//   }catch(e){
//     print(e.toString());
//   }
//   return user!;
// }

Future<void> sendPushNotification(String token,Map<String,dynamic> notification,String chatRoom) async{
  try {
    var url = Uri.parse(firebaseUrl);

    var response = await http.post(url,
        body: jsonEncode({
          "to" : token,
          "data": {
            "type": "MESSAGE",
            "chatRoom": chatRoom,
            "target": "loggedInUser"
          },
          "notification" : notification

        }),
        headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization':"key=$serverKey"
    });

    if (response.statusCode == 200) {
      print("Push Notification Successfully");
    }
    else {
      print("Push Notification not sent");
    }
  }catch(e) {
    print("error in send push notificaction is ${e.toString()}");
  }
}