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
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.direction <= 0) {
            Navigator.pop(context);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
              stream: chatRef.where("participants",arrayContainsAny: [loggedInUser] ).orderBy("created",descending: true).snapshots(),
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
                          onTap: () async{
                            chat[index].participants.remove(loggedInUser!.uid);
                            UserModel target = await getUserFromUid(chat[index].participants.first);
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  ChatScreen(targetUser: target,)));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: chat[index].messageId,
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
