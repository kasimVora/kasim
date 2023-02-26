import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase__test/Helper/FirebaseHelperFunction.dart';
import 'package:firebase__test/Utility/Color.dart';
import 'package:firebase__test/Utility/Style.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final bioCon = TextEditingController();
  final userNameCon = TextEditingController(text: loggedInUser!.userName);
  final nameCon = TextEditingController();

  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                   children: [
                     IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close,color: whiteColor,)),
                     const SizedBox(width: 10,),
                     Text("Edit Profile",style: whiteBoldText16,),
                   ],
                 ),
                  IconButton(onPressed: (){
                    userRef.doc(loggedInUser!.uid).update(
                        {
                          "user_name":userNameCon.text.trim(),
                          "name":nameCon.text.trim(),
                          "bio":bioCon.text.trim()
                        }).whenComplete(() {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile updated successfully")));});
                  }, icon: const Icon(Icons.check,color: blueColor,size: 30,)),
                ]
              ),
              const SizedBox(height: 50,),
              Center(
                child: Column(
                  children: [
                  image !=null ? ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(50), // Image radius
                              child: Image.file(
                                image!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : CachedNetworkImage(
                    height: 100,width: 100,
                    imageUrl: loggedInUser!.imgUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.person),
                  ),
                    const SizedBox(height: 10,),
                    TextButton(onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? file = await picker.pickImage(source: ImageSource.gallery,imageQuality: 55);
                      if(file!=null){
                        image = File(file.path);
                        setState(() {});
                        final storageRef = FirebaseStorage.instance.ref().child("profilePics").child(loggedInUser!.uid);
                        storageRef.delete();

                        storageRef.putFile(File(image!.path)).snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
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
                               taskSnapshot.ref.getDownloadURL().then((value) {
                                 userRef.doc(loggedInUser!.uid).update({"img_url":value}).whenComplete(() {
                                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile photo updated successfully")));
                                 });
                               });
                              break;
                          }
                        });


                      }
                    }, child: const Text("Change profile photo"))
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              TextFormField(
                controller: userNameCon,
                maxLength: 20,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: "User Name",
                  filled: false,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
                  border: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                  isDense: true,
                  hintText: "",
                  counterText: "",
                ),
              ),
              const SizedBox(height: 25,),
              TextFormField(
                controller: nameCon,
                maxLength: 20,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: "Name",
                  filled: false,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
                  border: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                  isDense: true,
                  hintText: "",
                  hintStyle: grayNormalText12,
                  counterText: "",
                ),
              ),
              const SizedBox(height: 25,),
              TextFormField(
                controller: bioCon,
                maxLength: 20,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: "Bio",
                  filled: false,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
                  border: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                  isDense: true,
                  hintText: "",
                  counterText: "",
                ),
              ),
              const SizedBox(height: 25,)
            ],
          ),
        ),
      ),
    );
  }
}
