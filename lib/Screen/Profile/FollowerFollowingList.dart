import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase__test/Model/UserModel.dart';
import 'package:firebase__test/main.dart';
import 'package:flutter/material.dart';

import '../../Helper/FirebaseHelperFunction.dart';
import '../../Utility/Color.dart';
import '../../Utility/Style.dart';
import 'UserProfile.dart';

class FollowerFollowingList extends StatefulWidget {
  String path , uid;
   FollowerFollowingList({Key? key,required this.path,required this.uid}) : super(key: key);

  @override
  State<FollowerFollowingList> createState() => _FollowerFollowingListState();
}

class _FollowerFollowingListState extends State<FollowerFollowingList> {

  StreamController<List<UserModel>> streamController = StreamController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
     streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close,color: whiteColor,)),
                      const SizedBox(width: 10,),
                      Text(widget.path,style: whiteBoldText16,),
                    ],
                  ),
                  ]
            ),

            SizedBox(height: 20,),
            StreamBuilder(
              stream: streamController.stream,
              builder: (_, AsyncSnapshot<List<UserModel>> snapshot) {
                if(snapshot.hasData){
                  return userList(snapshot);
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

  Widget userList(AsyncSnapshot<List<UserModel>> snapshot) {
    List<UserModel> users = snapshot.data!;
    return ListView.separated(
        shrinkWrap: true,
        primary: false,
        physics: const BouncingScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserProfile(uid: users[index].uid)));
            },
            title: Text(users[index].userName),
            subtitle:Text(users[index].userName),
            leading:  CachedNetworkImage(
              height: 40,width: 40,
              imageUrl: users[index].imgUrl,
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
            trailing: users[index].uid != loggedInUser!.uid ?  GestureDetector(
              onTap: () async {
                if(loggedInUser!.following.contains(users[index].uid)){
                  //unfollow
                  List<String> followers = users[index].followers;
                  followers.remove(loggedInUser!.uid);
                  userRef.doc(users[index].uid).update({"followers": followers});

                  List<String> followings = loggedInUser!.following;
                  followings.remove(users[index].uid);
                  userRef.doc(loggedInUser!.uid).update({"following": followings});

                }else{
                  //follow

                  List<String> followers = users[index].followers;
                  followers.add(loggedInUser!.uid);
                  userRef.doc(users[index].uid).update({"followers": followers});

                  List<String> followings = loggedInUser!.following;
                  followings.add(users[index].uid);
                  userRef.doc(loggedInUser!.uid).update({"following": followings});

                  // await sendPushNotification(users[index].deviceToken,{
                  //   "body" : "",
                  //   "title": "${loggedInUser!.userName} started following you"
                  // },{
                  //   "type": "FOLLOW",
                  //   "uid": loggedInUser!.uid,
                  // });

                }
                getData();
              },
              child: Container(
                // width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    border:loggedInUser!.following.contains(users[index].uid) ?
                    Border.all(color: whiteColor,width: 1.2) : Border.all(),
                    color: loggedInUser!.following.contains(users[index].uid) ? blackColor : mainBlue
                ),
                child: Text(loggedInUser!.following.contains(users[index].uid) ? "following" : "follow",textAlign: TextAlign.center,style: whiteBoldText14,),
              ),
            ) : const SizedBox(),
          );
        }, separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: grayColor,
          );
    },);
  }


    getData() async{
     //var snap = await userRef.doc(widget.uid).get();
       userRef.doc(widget.uid).snapshots().listen((event) async {
         List<UserModel> list = [];
        var data = event.data()!;
        if(data[widget.path].isNotEmpty){
          for(int i = 0; i<data[widget.path].length;i++){
            String path = data[widget.path][i];
            var res = await userRef.doc(path).get();
            list.add(UserModel.fromJson(res.data()!));
          }
        }
        if(!streamController.isClosed){
          streamController.sink.add(list);
        }
      }).onError((error) => print(error.toString()));

  }
}
