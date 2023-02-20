import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase__test/Helper/FirebaseHelperFunction.dart';
import 'package:firebase__test/Model/UserModel.dart';
import 'package:firebase__test/main.dart';
import 'package:flutter/material.dart';

import '../../Model/ChatModel.dart';

class ChatUsers extends StatefulWidget {
  const ChatUsers({Key? key}) : super(key: key);

  @override
  State<ChatUsers> createState() => _ChatUsersState();
}

class _ChatUsersState extends State<ChatUsers> {
  StreamController<List<UserModel>> streamController = StreamController();

  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         StreamBuilder(
           stream: chatRef.where("participants",arrayContains: [loggedInUser!.uid]).snapshots(),
           builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
             List<ChatModel> chat = [];

             snapshot.data!.docs.map((e) {
               chat.add(ChatModel.fromJson(e.data() as Map<String,dynamic>));
             });

             if (snapshot.hasData) {
               return Text("");
             } else {
               return const SizedBox();
             }
           },
         ),
       ],
     ),
    );
  }

  void getData() {
    chatRef.snapshots().listen((event) {
      print("event.docs.length");
      print(event.docs.first.id);

      chatRef.doc(event.docs.first.id).collection(event.docs.first.id).snapshots().listen((event) {

      });

    });
    
  }

}
