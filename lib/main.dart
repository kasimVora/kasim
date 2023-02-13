import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase__test/Helper/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'Screen/CameraScreen.dart';
import 'Screen/HomeScreen.dart';
import 'Screen/SplashScreen.dart';
import 'firebase_options.dart';


final FirebaseAuth authInst = FirebaseAuth.instance;
FirebaseStorage storageRef = FirebaseStorage.instance;
final userRef = FirebaseFirestore.instance.collection('user');
final chatRef = FirebaseFirestore.instance.collection('chatRoom');
FirebaseMessaging messaging = FirebaseMessaging.instance;
late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  cameras = await availableCameras();
  runApp(const MyApp());
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
          bottomAppBarColor:blackColor,
      ),
      home:  const HomeScreen(),
    );
  }
}



/// > Task :sqflite:signingReport
/// Variant: debugAndroidTest
/// Config: debug
/// Store: C:\Users\Admin\.android\debug.keystore
/// Alias: AndroidDebugKey
/// MD5: 34:82:06:08:62:9F:1F:E2:AF:83:FC:D5:4E:93:96:4D
/// SHA1: 94:73:DF:32:56:C1:CD:3C:F6:C7:58:85:28:7B:6E:8E:DF:B0:37:6E
/// SHA-256: E6:10:50:CF:28:83:02:9E:D5:2C:13:83:CB:4A:70:A8:2A:0C:BE:D8:48:51:85:C0:E1:22:DD:9B:1D:E1:97:36
/// Valid until: Wednesday, 8 January, 2053
/// ----------

