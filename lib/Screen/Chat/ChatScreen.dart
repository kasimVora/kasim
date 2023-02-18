import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase__test/Helper/FirebaseHelperFunction.dart';
import 'package:firebase__test/Model/UserModel.dart';
import 'package:flutter/material.dart';

import '../../Utility/Color.dart';
import '../../Utility/Style.dart';
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

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(milliseconds: 500), () async{
    //   await getUserFromUid(widget.targetUid);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.targetUser.userName??""),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: messageCon,
                focusNode: messageFoc,
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

  void sendMessage() async{
    chatRef.doc();
  }
}
