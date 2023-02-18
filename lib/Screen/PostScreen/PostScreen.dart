import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase__test/Model/UserModel.dart';
import 'package:firebase__test/Screen/Chat/ChatUsers.dart';
import 'package:firebase__test/Screen/PostScreen/CommentScreen.dart';
import 'package:firebase__test/Utility/Color.dart';
import 'package:firebase__test/Helper/FirebaseHelperFunction.dart';
import 'package:firebase__test/Utility/Style.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../CommonWidget/PostItem.dart';
import '../../Utility/Utility.dart';
import '../../Model/PostModel.dart';
import '../../main.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 20,
            ),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatUsers()));
            }, icon: Icon(Icons.chat)),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: postRef.snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return postList(snapshot);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget postList(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<PostModel> posts = [];

    for (var i in snapshot.data!.docs) {
      var user = i.data() as Map<String, dynamic>;
      if (loggedInUser!.following.contains(user["user_id"])) {
        posts.add(PostModel.fromJson(user));
      }
    }
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: const BouncingScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return PostItem(
                posts: posts[index],
              );
            }));
  }
}
