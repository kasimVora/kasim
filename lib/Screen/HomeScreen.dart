import 'dart:convert';
import 'dart:io';

import 'package:firebase__test/Utility/Color.dart';
import 'package:firebase__test/Screen/Chat/ChatScreen.dart';
import 'package:firebase__test/Screen/CreatePost.dart';
import 'package:firebase__test/Screen/SearchScreen.dart';
import 'package:firebase__test/Screen/Auth/SplashScreen.dart';
import 'package:firebase__test/Screen/Profile/UserProfile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../Helper/FirebaseHelperFunction.dart';
import '../Helper/NotificationService.dart';
import '../Model/UserModel.dart';
import '../main.dart';
import 'MediaPicker.dart';

import 'package:flutter/widgets.dart';
import 'PostScreen/PostScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int selectedIndex = 0;
  Widget currentScreen = const PostScreen();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initServices();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: null,
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "",
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: blueColor,
        unselectedItemColor: grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value){
          setState(() {
            selectedIndex = value;
            selectedIndex == 0 ? currentScreen = const PostScreen() : selectedIndex == 1 ?  openPicker()  :selectedIndex == 2 ? currentScreen = const SearchScreen(): currentScreen =  UserProfile(uid: loggedInUser!.uid);
          });
        },
      ),
    );
  }

  openPicker() {
    InstaAssetPicker.pickAssets(
      context,
      title: 'Select images',
      maxAssets: 1,
      pickerTheme: ThemeData.light(),
      closeOnComplete: true,
      isSquareDefaultCrop: true,
      useRootNavigator: true,
      onCompleted: (cropStream) {
        cropStream.listen((event) async{
          String newPath = '';

            Directory directory = await getApplicationDocumentsDirectory();
            newPath = "${directory.path}/newPost.jpg";


          final file = await event.selectedAssets.first.file;
          await FlutterImageCompress.compressAndGetFile(
              file!.path, newPath,
              quality: 50,
              numberOfRetries: 2).then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  CreatePost(image: value!.path)));
          });

        });
      },
    );
  }

  void initServices() {




    if(authInst.currentUser!=null){


      userRef.doc(loggedInUser!.uid).update({"isOnline": true});
      userRef.doc(authInst.currentUser!.uid).snapshots().listen((event) {
        loggedInUser = UserModel.fromJson(event.data()!);
       // print(jsonEncode(loggedInUser));
      },
      ).onError((error){
        print("Listen failed: $error");
      });


      ///PUSH NOTIFICATION SETUP
      // messaging.getInitialMessage().then((value) {
      //   if(value!=null){
      //     onSelectNotification(jsonEncode(value.data));
      //   }
      // });
      //
      // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //   onSelectNotification(jsonEncode(message.data));
      // });
      //
      // FirebaseMessaging.onMessage.listen((RemoteMessage message){
      //   final notification = message.notification;
      //   notificationService.showNotification(message.hashCode,notification!.title!,notification.body!,jsonEncode(message.data));
      // });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
     if(state == AppLifecycleState.resumed){
       userRef.doc(loggedInUser!.uid).update({"isOnline": true});
     }else {
       userRef.doc(loggedInUser!.uid).update({"isOnline": false});
     }

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}


