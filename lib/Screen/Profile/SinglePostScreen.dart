import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../CommonWidget/PostItem.dart';
import '../../Helper/FirebaseHelperFunction.dart';
import '../../Model/PostModel.dart';
import '../../Model/UserModel.dart';
import '../../Utility/Color.dart';
import '../../Utility/Style.dart';
import '../../Utility/Utility.dart';
import '../../main.dart';

class SinglePostScreen extends StatefulWidget {
  String post;
   SinglePostScreen({Key? key,required this.post}) : super(key: key);


  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          StreamBuilder(
            stream: postRef.doc(widget.post).snapshots(),
            builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(snapshot.hasData){
                return postList(snapshot);
              }else{
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget postList(AsyncSnapshot<DocumentSnapshot> snapshot) {
     var object = snapshot.data!.data() as Map<String,dynamic>;
     PostModel postData = PostModel.fromJson(object);

    return PostItem(posts: postData);
  }

}
