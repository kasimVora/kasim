import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase__test/Helper/FirebaseHelperFunction.dart';
import 'package:firebase__test/Model/UserModel.dart';
import 'package:firebase__test/Utility/Color.dart';
import 'package:firebase__test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../Model/ChatModel.dart';
import '../../Utility/Utility.dart';
import 'ChatScreen.dart';

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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            StreamBuilder(
              stream: chatRef.where("participants",arrayContainsAny: [loggedInUser!.toJson()] ).orderBy("created",descending: true).snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {

                if (snapshot.hasData) {
                  List<ChatModel> chat = [];

                  for(var i in snapshot.data!.docs){
                      chat.add(ChatModel.fromJson(i.data() as Map<String,dynamic>));
                  }
                  return Expanded(
                    child: chat .isNotEmpty ? ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      physics: const BouncingScrollPhysics(),
                      itemCount: chat.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            chat[index].participants.remove(loggedInUser!);
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  ChatScreen(targetUser: chat[index].participants.first,)));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: chat[index].participants.where((element) => element != loggedInUser).first.imgUrl,
                                      errorWidget: (context, url, error) => const Text("error"),
                                      imageBuilder: (context, imageProvider) => CircleAvatar(
                                        radius:25,
                                        backgroundImage: imageProvider,
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(chat[index].userName.toString()),
                                        Text(chat[index].message.toString())
                                      ],
                                    ),
                                  ],
                                ),
                                Text(getTimeDifferenceFromNow(chat[index].created!))
                              ],
                            ),
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                      return const Divider(color: whiteColor,);
                    },) : const SizedBox(),
                  );
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
}


