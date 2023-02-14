

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image/image.dart' as IMG;

import '../Model/UserModel.dart';
import '../main.dart';



UserModel? loggedInUser;

 const serverKey = "AAAAjxXxUcc:APA91bF3kPXfeFZ4pqQt4YsZOAhJ91NpVXb8Z1rpVeuBfVH4r1kl9eG2nDENXhogF49cvknRVblp9vWo_Tg15prAv0E4pCqbbyJCRDV7NS43Xjk-aNFGojJj8ioDic52ZpnTypOZ1haV";
 const firebaseUrl = 'https://fcm.googleapis.com/fcm/send';

Future<UserModel>  getUserFromUid(String id) async{
  UserModel? user;
  try{
    final data = await userRef.doc(id).get();
    user = UserModel.fromJson(data.data()!);
    print(jsonEncode(user));
  }catch(e){
    print(e.toString());
  }
  return user!;
}

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

Future<File> reduceImageQualityAndSize(Uint8List image) async {

  int maxInBytes = 20000;
  // File imag ;
  // imag. readAsBytes()
  Uint8List resizedData = Uint8List.fromList(image);

  IMG.Image? img = IMG.decodeImage(image);
  int size = image.lengthInBytes;
  int quality = 100;

  print("size max: " + maxInBytes.toString());
  print("size before: " + size.toString() + " bytes");

  while (size > maxInBytes && quality > 10) {
    // reduce image size about 10% of image, until the size is less than the maximum limit
    quality = (quality - (quality * 0.1)).toInt();
    int width = img!.width - (img.width * 0.1).toInt();
    IMG.Image resized = IMG.copyResize(img, width: width);
    resizedData = Uint8List.fromList(IMG.encodeJpg(resized, quality: quality));
    size = resizedData.lengthInBytes;
    img = resized;
  }

  print("size after: " + size.toString() + " bytes");

  return File.fromRawPath(resizedData);
}