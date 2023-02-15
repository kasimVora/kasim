import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../Helper/FirebaseHelperFunction.dart';
import '../../Model/PostModel.dart';
import '../../Utility/Color.dart';
import '../../Utility/Style.dart';
import '../../Utility/Utility.dart';
import '../../main.dart';

class CommentScreen extends StatefulWidget {
  PostModel postModel;
   CommentScreen({Key? key,required this.postModel}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final commentCon = TextEditingController();
  final commentFoc = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back,color: whiteColor,)),
                const Text("Comments")
             
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.postModel.postUrl,
                    errorWidget: (context, url, error) => const Text("error"),
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 22,
                      backgroundImage: imageProvider,
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Flexible(
                    child: Text.rich(
                        TextSpan(
                            text: widget.postModel.userName,
                            style:whiteBoldText14,

                            children: <InlineSpan>[
                              TextSpan(
                                text: "  ${widget.postModel.caption}",
                                style: whiteNormalText16,
                              )
                            ]
                        )
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(getTimeDifferenceFromNow(widget.postModel.created!),style: whiteNormalText11,),
            ),
           const Divider(
             color: whiteColor,
           ),

            StreamBuilder(
              stream: postRef.doc(widget.postModel.postId).snapshots(),
              builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if(snapshot.hasData){
                  return postList(snapshot);
                }else{
                  return const SizedBox();
                }
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: TextFormField(
                controller: commentCon,
                focusNode: commentFoc,
                decoration: InputDecoration(
                    fillColor: blackColor,
                    prefixIconConstraints: const BoxConstraints(maxHeight: 40),
                    contentPadding: const EdgeInsets.only(left: 10,right: 10),
                    prefixIcon:   CachedNetworkImage(
                      imageUrl: loggedInUser!.imgUrl,
                      errorWidget: (context, url, error) => const Text("error"),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 15,
                        backgroundImage: imageProvider,
                      ),
                    ),
                    filled: true,
                    border: InputBorder.none,
                    hintText: "   Add a comment",
                    counterText: "",
                    suffixIcon: TextButton(onPressed: () {
                      postComment();
                    }, child: const Text("Post"),),
                    hintStyle: grayLightNormalText15
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget postList(AsyncSnapshot<DocumentSnapshot> snapshot) {
    List<CommentModel> comments = [];

    var data = snapshot.data!.data() as Map<String,dynamic>;

    if(data["commentsCount"].isNotEmpty){
      for(var i in data["commentsCount"]){
        comments.add(CommentModel.fromJson(i as Map<String,dynamic>));
      }
    }

    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: const BouncingScrollPhysics(),
            itemCount: comments.length,
            itemBuilder: (BuildContext context, int index) {
              return listItem(comments[index]);
            }));
  }

  Widget listItem( CommentModel comment) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: comment.imgUrl,
        errorWidget: (context, url, error) => const Text("error"),
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: 15,
          backgroundImage: imageProvider,
        ),
      ),
      title: Text.rich(
          TextSpan(
              text: comment.userName,
              style:whiteBoldText14,

              children: <InlineSpan>[
                TextSpan(
                  text: "  ${comment.comment}",
                  style: whiteNormalText16,
                )
              ]
          )
      ),
      subtitle: Text(getTimeDifferenceFromNow(comment.posted!),style: whiteNormalText11,),
      trailing: comment.userId == loggedInUser!.uid ? TextButton(
        onPressed: (){
          postRef.doc(widget.postModel.postId).update({"commentsCount": FieldValue.arrayRemove([
            comment.toJson()
          ])});
        },
        child: const Text("remove") ,
      ): const SizedBox(),
    );
  }

  void postComment() {
    CommentModel comment = CommentModel(userName: loggedInUser!.userName, userId: loggedInUser!.uid, comment: commentCon.text.trim(), imgUrl: loggedInUser!.imgUrl, commentId: const Uuid().v1(), posted: DateTime.now());

    postRef.doc(widget.postModel.postId).update({"commentsCount": FieldValue.arrayUnion([
      comment.toJson()
    ])});
    commentFoc.unfocus();
    commentCon.text = '';
  }
}
