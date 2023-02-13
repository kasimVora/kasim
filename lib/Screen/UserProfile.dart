import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase__test/Helper/Color.dart';
import 'package:firebase__test/Helper/FirebaseHelperFunction.dart';
import 'package:firebase__test/Helper/Style.dart';
import 'package:firebase__test/Model/PostModel.dart';
import 'package:firebase__test/Model/UserModel.dart';
import 'package:firebase__test/Screen/EditProfile.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class UserProfile extends StatefulWidget {
  String uid;
   UserProfile({Key? key,required this.uid}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
              stream: userRef.doc(widget.uid).snapshots(),
              builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if(snapshot.hasData){
                  return userList(snapshot);
                }else{
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(height: 50,),
            StreamBuilder(
              stream: postRef.doc(widget.uid).collection(widget.uid).snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData){
                  return postList(snapshot);
                }else{
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget userList(AsyncSnapshot<DocumentSnapshot> snapshot) {

    UserModel user = UserModel.fromJson(snapshot.data!.data() as Map<String,dynamic>);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5,),
          Row(
            children: [
              IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.arrow_back,color: whiteColor,)),
              Text(user.userName,style: whiteBoldText18),
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CachedNetworkImage(
                height: 100,width: 100,
                imageUrl: user.imgUrl,
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
              const SizedBox(width: 20,),
              Column(
                children: [
                  Text(user.posts.length.toString(),style: whiteBoldText14,),
                  Text("post",style: whiteNormalText13),
                ],
              ),
              const SizedBox(width: 20,),
              Column(
                children: [
                  Text(user.followers.length.toString(),style: whiteBoldText14),
                  Text("followers",style: whiteNormalText13),
                ],
              ),
              const SizedBox(width: 10,),
              Column(
                children: [
                  Text(user.following.length.toString(),style: whiteBoldText14),
                   Text("following",style: whiteNormalText13),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              if(loggedInUser!.following.contains(widget.uid)){
                //unfollow

                List<String> followers = user.followers;
                followers.remove(loggedInUser!.uid);
                userRef.doc(widget.uid).update({"followers": followers});

                List<String> followings = loggedInUser!.following;
                followings.remove(user.uid);
                userRef.doc(loggedInUser!.uid).update({"following": followings});

              }else if(loggedInUser!.uid == widget.uid){
                //edit profile
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
              }else{
                //follow
                List<String> followers = user.followers;
                followers.add(loggedInUser!.uid);
                userRef.doc(widget.uid).update({"followers": followers});

                List<String> followings = loggedInUser!.following;
                followings.add(user.uid);
                userRef.doc(loggedInUser!.uid).update({"following": followings});

              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: whiteColor,width: 1.2)
              ),
              child: Text(loggedInUser!.uid == widget.uid ? "Edit profile" :loggedInUser!.following.contains(widget.uid) ? "Unfollow" : "Follow",textAlign: TextAlign.center,style: whiteBoldText14,),
            ),
          )
        ],
      ),
    );
  }
  
  Widget postList(AsyncSnapshot<QuerySnapshot> snapshot) {
   List<PostModel> posts = [];

   print(snapshot.data!.docs.length);
   for(int i = 0 ;i<snapshot.data!.docs.length;i++){
     var  e = snapshot.data!.docs[i].data() as Map<String,dynamic>;
     print(e);
     posts.add(PostModel.fromJson(e));
   }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4),
        itemBuilder: (_, i) {

          return  CachedNetworkImage(
            height: 200,width: 200,
            imageUrl: posts[i].postUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) =>  Container(
              height: 150,width: 150,color: greysecond,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.person),
          );
        },
        itemCount: posts.length),
    );
  }
}
