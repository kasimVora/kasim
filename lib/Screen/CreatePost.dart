import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase__test/Helper/Color.dart';
import 'package:firebase__test/Helper/FirebaseHelperFunction.dart';
import 'package:firebase__test/Helper/Style.dart';
import 'package:firebase__test/Helper/Utility.dart';
import 'package:firebase__test/Model/PostModel.dart';
import 'package:firebase__test/Screen/HomeScreen.dart';
import 'package:firebase__test/Screen/PostScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'package:image/image.dart' as imageLib;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';

class CreatePost extends StatefulWidget {
  String image;
   CreatePost({Key? key,required this.image}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  final captionCon = TextEditingController(text: "test image caption");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("New Post"),actions: [
        IconButton(onPressed: () async => await addImageToFirebase(), icon: const Icon(Icons.done,size: 30,))
      ],),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Row(
              children: [
                CachedNetworkImage(
                  height: 40,width: 40,
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
                Expanded(
                    child: TextFormField(
                      controller: captionCon,
                      decoration: InputDecoration(
                        fillColor: blackColor,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: InputBorder.none,
                        isDense: true,
                        hintText: "Add first caption",
                        hintStyle: grayNormalText12,
                        counterText: "",
                      ),
                    )
                ),
                const SizedBox(width: 10,),
                SizedBox(
                  height: 70,
                  child: Image.file(
                    File(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10,)
              ],
            ),
            const SizedBox(height: 3,),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            const SizedBox(height: 3,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Add Location",style: whiteBoldText14,),
            ),
            const SizedBox(height: 3,),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            const SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }


  Future<void> addImageToFirebase() async {
    String url = "";
    var postID = const Uuid().v1();
  //  File image = await reduceImageQualityAndSize(File(widget.image).readAsBytesSync());



    final storageRef = FirebaseStorage.instance.ref()
        .child("Post")
        .child(loggedInUser!.uid).child(postID).child(postID)
        .putFile(File(widget.image));
    showDialogWithLoad(context);

    storageRef.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.canceled:
          Navigator.pop(context);
          print("Upload was canceled");
          break;
        case TaskState.error:
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(TaskState.error.toString())));
          break;
        case TaskState.success:
          url = await taskSnapshot.ref.getDownloadURL();
          createPost(postID,url);
          break;
        case TaskState.paused:
          break;
      }
    });
  }

  createPost(id,url) {
    PostModel postModel = PostModel(
        postId: id,
        userId: loggedInUser?.uid??"",
        userName: loggedInUser?.userName??"",
        postUrl: url,
        postType: "1",
        likeCount: [],
        commentsCount: [],
        location: "India",
        caption: captionCon.text.trim(),
        created: DateTime.now());

    postRef.doc(loggedInUser!.uid).collection(loggedInUser!.uid).add(postModel.toJson()).
    then((value) {
      List posts = loggedInUser!.posts;
      posts.add(value.id);
      userRef.doc(loggedInUser!.uid).update({"posts": posts}).whenComplete(()  {
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }).catchError((e) => print(e));
    }).catchError((onError){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(onError.toString())));
    });
  }
}
