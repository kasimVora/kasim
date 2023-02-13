import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase__test/Screen/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../Helper/FirebaseHelperFunction.dart';
import '../Model/UserModel.dart';
import '../Helper/Utility.dart';
import '../main.dart';
import 'LoginScreen.dart';

class CompleteProfile extends StatefulWidget {
  String uid,phone;
   CompleteProfile({Key? key,required this.uid,required this.phone}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final userName = TextEditingController();

  File? image;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text("Complete Profile",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 30),),

                const SizedBox(height: 20,),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(50), // Image radius
                          child: image!=null ? Image.file(image!,fit: BoxFit.fill,) :  Image.asset('assets/logo.jpg',fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: MediaQuery.of(context).size.width/3.5,
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: Colors.white
                          ),
                          child: IconButton(onPressed: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile? file = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 55);
                            image = File(file!.path);
                            setState(() {});
                          }, icon: const Icon(Icons.camera_alt,size: 35,color: Colors.blue,)
                          ),
                        )
                    )
                  ],
                ),

                const SizedBox(height: 20,),
                TextFormField(
                  controller: userName,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 1.3),

                      //gapPadding: 10,
                    ),
                    isDense: true,
                    hintText: "User Name",
                    counterText: "",
                  ),
                ),
                const SizedBox(height: 30,),
                Center(
                  child: TextButton(
                      onPressed: () async => await addImageToFirebase(),
                      child: const Text("Complete")
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addImageToFirebase() async {
    showDialogWithLoad(context);
    String url = "";
    final storageRef = FirebaseStorage.instance.ref()
        .child("profilePics")
        .child(widget.uid)
        .putFile(image!);

    storageRef.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(TaskState.error.toString())));
          break;
        case TaskState.success:
          url = await taskSnapshot.ref.getDownloadURL();
          saveUser(url);
          break;
      }
    });
  }

  void saveUser(String url) {
    messaging.getToken().then((value) {
      UserModel user = UserModel(userName: userName.text, phoneNumber: widget.phone, uid: widget.uid, imgUrl: url, deviceToken: value!, followers: [], following: [], posts: []);
      print(jsonEncode(user));
      userRef.doc(user.uid).set(user.toJson()).
      whenComplete(() async{
        Navigator.pop(context);
        loggedInUser =  await getUserFromUid(authInst.currentUser!.uid);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }).
      catchError((e){
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
    });
  }
}

