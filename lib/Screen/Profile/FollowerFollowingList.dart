import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase__test/Model/UserModel.dart';
import 'package:firebase__test/main.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement dispose
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: StreamBuilder(
            stream: streamController.stream,
            builder: (_, AsyncSnapshot<List<UserModel>> snapshot) {
              if(snapshot.hasData){
                return userList(snapshot);
              }else{
                return const SizedBox();
              }
            },
          )

          //widget.type == "Follower" ? followersList() : followingList() ,
        ),
      ),
    );
  }

  Widget userList(AsyncSnapshot<List<UserModel>> snapshot) {
    List<UserModel> users = snapshot.data!;
    //
    // var data = snapshot.data!.data() as Map<String,dynamic>;
    // if(data["following"].isNotEmpty){
    //   for(int i = 0; i<data["following"].length;i++){
    //     String path = data["following"][i];
    //     DocumentSnapshot userdata = userRef.doc(path).get();
    //     users.add(UserModel.fromJson(userdata.));
    //   }
    // }
    print(users);
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const BouncingScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(users[index].userName),
          );
        });
  }


    getData() async{
    List<UserModel> list = [];
     var snap = await userRef.doc(widget.uid).get();
    var data = snap.data()!;
    if(data[widget.path].isNotEmpty){
      for(int i = 0; i<data[widget.path].length;i++){
        String path = data[widget.path][i];
        var res = await userRef.doc(path).get();
        list.add(UserModel.fromJson(res.data()!));
      }
    }
      print(jsonEncode(list));
    streamController.add(list);
    setState(() {});
  }
}
