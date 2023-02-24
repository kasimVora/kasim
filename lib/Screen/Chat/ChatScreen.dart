import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase__test/Helper/FirebaseHelperFunction.dart';
import 'package:firebase__test/Model/ChatModel.dart';
import 'package:firebase__test/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../Utility/Color.dart';
import '../../Utility/Style.dart';
import '../../Utility/Utility.dart';
import '../../main.dart';

class ChatScreen extends StatefulWidget {
  UserModel targetUser;
   ChatScreen({Key? key,required this.targetUser}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final messageCon = TextEditingController();
  final messageFoc = FocusNode();
  String chatId  = '';
  StreamController<List<ChatModel>> streamController = StreamController();

  @override
  void initState() {
    super.initState();
   chatId = getChatId(loggedInUser!.uid,widget.targetUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.targetUser.userName??""),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder(//
            stream: chatRef.doc(chatId).collection(chatId).snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return postList(snapshot);
              } else {
                return const SizedBox();
              }
            },
          ),
          const SizedBox(height: 10,),

          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: messageCon,
                focusNode: messageFoc,
                onFieldSubmitted: (value){
                  sendMessage();
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: false,
                  suffixIcon: TextButton(onPressed: () {
                    sendMessage();
                  }, child: const Text("send"),),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 10.0),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Colors.lightBlueAccent, width: 1.3),

                    //gapPadding: 10,
                  ),
                  isDense: true,
                  hintText: "",
                  counterText: "",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage() {
    ChatModel model = ChatModel(
        userName: widget.targetUser.userName,
        message: messageCon.text.trim(),
        created: DateTime.now(),
        from: loggedInUser!.uid,
        to: widget.targetUser.uid,
        messageId: const Uuid().v1(),
        type: "1", participants: [widget.targetUser,loggedInUser!]);
   
    chatRef.doc(chatId).collection(chatId).add(model.toJson());
    chatRef.doc(chatId).set(model.toJson());

    messageFoc.unfocus();
    messageCon.text = '';
  }


  Widget postList(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<ChatModel> chat = [];
    for(var i in snapshot.data!.docs){
      var object = i.data() as Map<String,dynamic>;
        chat.add(ChatModel.fromJson(object));
    }
    return Expanded(
      child: chat.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        primary: false,
        physics: const BouncingScrollPhysics(),
        itemCount: chat.length,
        itemBuilder: (BuildContext context, int index) {
          return Align(
            alignment: chat[index].from == loggedInUser!.uid ?
            Alignment.topRight : Alignment.topLeft,
            child:  Container(
              padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (chat[index].from == loggedInUser!.uid ?Colors.green.shade200:Colors.blue[200]),
                ),
                padding: const EdgeInsets.all(16),
                child: Text(chat[index].message, style: const TextStyle(fontSize: 15),),
              ),
            ),
          );
        },) :  Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }


  getData(){
    chatRef.doc(chatId).collection(chatId).orderBy('created', descending: true).snapshots().listen((event) {
      List<ChatModel> chats = [];
      for(var i in event.docs){
        chats.add(ChatModel.fromJson(i.data()));
      }
      streamController.sink.add(chats);
    }).onError((error) => print(error.toString()));
  }



}
