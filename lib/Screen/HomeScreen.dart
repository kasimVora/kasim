import 'dart:convert';
import 'dart:io';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:firebase__test/Utility/Color.dart';
import 'package:firebase__test/Screen/ChatScreen.dart';
import 'package:firebase__test/Screen/CreatePost.dart';
import 'package:firebase__test/Screen/SearchScreen.dart';
import 'package:firebase__test/Screen/SplashScreen.dart';
import 'package:firebase__test/Screen/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:path_provider/path_provider.dart';import '../Helper/FirebaseHelperFunction.dart';
import '../Model/UserModel.dart';
import '../main.dart';
import 'MediaPicker.dart';


import 'PostScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  Widget currentScreen = const PostScreen();

  @override
  void initState() {
    super.initState();
    if(authInst.currentUser!=null){
      final docRef = userRef.doc(authInst.currentUser!.uid);
      docRef.snapshots().listen((event) {
        loggedInUser = UserModel.fromJson(event.data()!);
        print(jsonEncode(loggedInUser));
      },
        onError: (error) => print("Listen failed: $error"),
      );
    }
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
}


