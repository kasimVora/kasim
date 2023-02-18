import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase__test/Screen/Chat/ChatScreen.dart';
import 'package:firebase__test/Utility/Color.dart';
import 'package:firebase__test/Helper/FirebaseHelperFunction.dart';
import 'package:firebase__test/Utility/Style.dart';
import 'package:firebase__test/Model/PostModel.dart';
import 'package:firebase__test/Model/UserModel.dart';
import 'package:firebase__test/Screen/Profile/EditProfile.dart';
import 'package:flutter/material.dart';

import '../../CommonWidget/SuggestedUser.dart';
import '../../main.dart';
import 'FollowerFollowingList.dart';
import 'SinglePostScreen.dart';
import '../Auth/SplashScreen.dart';

class UserProfile extends StatefulWidget {
  String uid;
  UserProfile({Key? key,required this.uid}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserModel user;
  bool onTap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  ChatScreen(targetUser: user,)));
              }, icon: Icon(Icons.message)),
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
              SizedBox(height: 10,),
              if(onTap)  suggestedUser(),


              const SizedBox(height: 50,),
              StreamBuilder(
                stream: postRef.snapshots(),
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
      ),
    );
  }

  logout() async{
    await authInst.signOut();
    loggedInUser = null;
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SplashScreen()), (Route<dynamic> route) => false);
  }

  Widget userList(AsyncSnapshot<DocumentSnapshot> snapshot) {

     user = UserModel.fromJson(snapshot.data!.data() as Map<String,dynamic>);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.userName,style: whiteBoldText18),
              ),
            loggedInUser!.uid == widget.uid ?  IconButton(onPressed: () async => logout(), icon: Icon(Icons.logout)) : const SizedBox()
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
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  FollowerFollowingList(path: "followers",uid: user.uid,)));
                },
                child: Column(
                  children: [
                    Text(user.followers.length.toString(),style: whiteBoldText14),
                    Text("followers",style: whiteNormalText13),
                  ],
                ),
              ),
              const SizedBox(width: 10,),
              GestureDetector(
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  FollowerFollowingList(path: "following",uid: user.uid,)));
                },
                child: Column(
                  children: [
                    Text(user.following.length.toString(),style: whiteBoldText14),
                    Text("following",style: whiteNormalText13),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
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

                      await sendPushNotification(user.deviceToken,{
                        "body" : "",
                        "title": "${loggedInUser!.userName} started following you"
                      },{
                        "type": "FOLLOW",
                        "uid": loggedInUser!.uid,
                      });

                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(7)),
                        border: Border.all(color: whiteColor,width: 1.2),
                      color: !loggedInUser!.following.contains(widget.uid) ? blackColor : mainBlue
                    ),
                    child: Text(loggedInUser!.uid == widget.uid ? "Edit profile" :loggedInUser!.following.contains(widget.uid) ? "Unfollow" : "Follow",textAlign: TextAlign.center,style: whiteBoldText14,),
                  ),
                ),
              ),
              IconButton(onPressed: (){
                onTap = !onTap;
                setState(() {});
              }, icon: Icon(Icons.person_add))
            ],
          )
        ],
      ),
    );
  }

  Widget postList(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<PostModel> posts = [];

    for(int i = 0 ;i<snapshot.data!.docs.length;i++){
      var  e = snapshot.data!.docs[i].data() as Map<String,dynamic>;
      if(user.posts.contains(snapshot.data!.docs[i].id)){
        posts.add(PostModel.fromJson(e));
     }
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

            return  GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  SinglePostScreen(post: posts[i].postId,)));
              },
              child: CachedNetworkImage(
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
              ),
            );
          },
          itemCount: posts.length),
    );
  }

  suggestedUser() {
    return  StreamBuilder(
      stream: userRef.snapshots(),
      builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<UserModel> users = [];
        if(snapshot.hasData){
          for(var i in snapshot.data!.docs){
            UserModel obj = UserModel.fromJson(i.data() as Map<String,dynamic>);
            if(loggedInUser!.uid != obj.uid  && !loggedInUser!.following.contains(obj.uid)){
              users.add(obj);
            }
          }
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(users.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Suggested user for you",style: whiteNormalText14,),
              ),
              SuggestedUser(suggestedUser: users,)
            ],
          );
        }else{
          return const SizedBox();
        }
      },
    );
  }

}






// class UserProfile extends StatefulWidget {
//   String uid;
//   UserProfile({Key? key,required this.uid}) : super(key: key);
//
//   @override
//   State<UserProfile> createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<UserProfile> {
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: blackColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             StreamBuilder(
//               stream: userRef.doc(widget.uid).snapshots(),
//               builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot) {
//                 if(snapshot.hasData){
//                   return userList(snapshot);
//                 }else if (snapshot.connectionState == ConnectionState.waiting)
//                   return Center(child: CircularProgressIndicator());
//                 else{
//                   return const SizedBox();
//                 }
//               },
//             ),
//
//             // StreamBuilder(
//             //   stream: userRef.doc(widget.uid).snapshots(),
//             //   builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot) {
//             //     if(snapshot.hasData){
//             //       return postList(snapshot);
//             //     }else{
//             //       return const SizedBox();
//             //     }
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget userList(AsyncSnapshot<DocumentSnapshot> snapshot) {
//     UserModel user = UserModel.fromJson(snapshot.data!.data() as Map<String,dynamic>);
//     List<PostModel> posts = [];
//
//     for(int i = 0;i<user.posts.length;i++){
//       postRef.doc(user.posts[i]).get().then((value) {
//         var map = value.data()!;
//         posts.add(PostModel.fromJson(map));
//       });
//
//       print(jsonEncode(posts.length));
//     }
//
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 5,),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(user.userName,style: whiteBoldText18),
//           ),
//           const SizedBox(height: 5,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               CachedNetworkImage(
//                 height: 100,width: 100,
//                 imageUrl: user.imgUrl,
//                 imageBuilder: (context, imageProvider) => Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: imageProvider,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 placeholder: (context, url) => const CircularProgressIndicator(),
//                 errorWidget: (context, url, error) => const Icon(Icons.person),
//               ),
//               const SizedBox(width: 20,),
//               Column(
//                 children: [
//                   Text(user.posts.length.toString(),style: whiteBoldText14,),
//                   Text("post",style: whiteNormalText13),
//                 ],
//               ),
//               const SizedBox(width: 20,),
//               Column(
//                 children: [
//                   Text(user.followers.length.toString(),style: whiteBoldText14),
//                   Text("followers",style: whiteNormalText13),
//                 ],
//               ),
//               const SizedBox(width: 10,),
//               Column(
//                 children: [
//                   Text(user.following.length.toString(),style: whiteBoldText14),
//                   Text("following",style: whiteNormalText13),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 10,),
//           GestureDetector(
//             onTap: (){
//               if(loggedInUser!.following.contains(widget.uid)){
//                 //unfollow
//
//                 List<String> followers = user.followers;
//                 followers.remove(loggedInUser!.uid);
//                 userRef.doc(widget.uid).update({"followers": followers});
//
//                 List<String> followings = loggedInUser!.following;
//                 followings.remove(user.uid);
//                 userRef.doc(loggedInUser!.uid).update({"following": followings});
//
//               }else if(loggedInUser!.uid == widget.uid){
//                 //edit profile
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
//               }else{
//                 //follow
//                 List<String> followers = user.followers;
//                 followers.add(loggedInUser!.uid);
//                 userRef.doc(widget.uid).update({"followers": followers});
//
//                 List<String> followings = loggedInUser!.following;
//                 followings.add(user.uid);
//                 userRef.doc(loggedInUser!.uid).update({"following": followings});
//
//               }
//             },
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               padding: const EdgeInsets.all(3),
//               decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.all(Radius.circular(7)),
//                   border: Border.all(color: whiteColor,width: 1.2)
//               ),
//               child: Text(loggedInUser!.uid == widget.uid ? "Edit profile" :loggedInUser!.following.contains(widget.uid) ? "Unfollow" : "Follow",textAlign: TextAlign.center,style: whiteBoldText14,),
//             ),
//           ),
//           const SizedBox(height: 50,),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child:  GridView.builder(
//               shrinkWrap: true,
//               itemCount: posts.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
//               itemBuilder: (_, i) {
//                 return  CachedNetworkImage(
//                   height: 200,width: 200,
//                   imageUrl: posts[i].postUrl,
//                   imageBuilder: (context, imageProvider) => Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.rectangle,
//                       image: DecorationImage(
//                         image: imageProvider,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   placeholder: (context, url) =>  Container(
//                     height: 150,width: 150,color: greysecond,
//                   ),
//                   errorWidget: (context, url, error) => const Icon(Icons.person),
//                 );
//               },),
//           )
//         ],
//       ),
//     );
//   }
//
// }
