import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Helper/FirebaseHelperFunction.dart';
import '../Model/PostModel.dart';
import '../Model/UserModel.dart';
import '../Screen/PostScreen/CommentScreen.dart';
import '../Utility/Color.dart';
import '../Utility/Style.dart';
import '../Utility/Utility.dart';
import '../main.dart';

class PostItem extends StatefulWidget {
  PostModel posts;
   PostItem({Key? key,required this.posts}) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return  Card(
        margin: const EdgeInsets.all(7),
        elevation: 3,
        color: blackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            GestureDetector(
              onDoubleTap: () => likeFunction(widget.posts),
              child: CachedNetworkImage(
                  imageUrl: widget.posts.postUrl,
                  placeholder: (context, url) =>  Container(
                    height: 300,
                    color: grayColor,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: whiteColor,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  imageBuilder: (context, image) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: widget.posts.postUrl,
                                errorWidget: (context, url, error) => const Text("error"),
                                imageBuilder: (context, imageProvider) => CircleAvatar(
                                  radius: 15,
                                  backgroundImage: imageProvider,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text(widget.posts.userName,style: whiteNormalText16,)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: Image(
                            image: image,
                            fit: BoxFit.cover,

                          ),
                        ),
                        Row(
                          children: [
                            IconButton(onPressed: () => likeFunction(widget.posts), icon:  Icon(widget.posts.likeCount.contains(loggedInUser!.uid) ? Icons.favorite : Icons.favorite_border,color: widget.posts.likeCount.contains(loggedInUser!.uid) ? redColor : whiteColor,)),
                            IconButton(onPressed: () => savePost(widget.posts), icon:  Icon(loggedInUser!.savedPosts.contains(widget.posts.postId) ? Icons.bookmark :Icons.bookmark_border,color: whiteColor,)),
                          ],
                        ),
                        Text.rich(
                            TextSpan(
                                text: widget.posts.userName,
                                style:whiteBoldText14,

                                children: <InlineSpan>[
                                  TextSpan(
                                    text: "  ${widget.posts.caption}",
                                    style: whiteNormalText11,
                                  )
                                ]
                            )
                        ),
                        const SizedBox(height: 3,),
                        widget.posts.likeCount.isNotEmpty ? Text( "${widget.posts.likeCount.length} likes" ,style: whiteNormalText13,) : const SizedBox(),
                        const SizedBox(height: 3,),
                        TextFormField(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  CommentScreen(postModel: widget.posts,)));
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                              fillColor: blackColor,
                              prefixIconConstraints: const BoxConstraints(maxHeight: 40),
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
                              isDense: true,
                              hintText: "   Add a comment",
                              counterText: "",
                              hintStyle: grayNormalText12
                          ),
                        ),
                        const SizedBox(height: 3,),
                        if(widget.posts.commentsCount.isNotEmpty)
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  CommentScreen(postModel: widget.posts,)));
                            },
                            child: Text("View all ${ widget.posts.commentsCount.length} Comments",style: grayNormalText12,)),
                        const SizedBox(height: 3,),
                        Text(getTimeDifferenceFromNow(widget.posts.created!),style: grayNormalText12,),
                      ],
                    );
                  }
              ),
            ),
          ],
        ));
  }

  likeFunction(PostModel postModel) {
    postRef.doc(postModel.postId).get().then((value) {
      List likes = value.data()!["likeCount"];
      if(likes.contains(loggedInUser!.uid)){
        likes.remove(loggedInUser!.uid);
        postRef.doc(postModel.postId).update({"likeCount":likes}).whenComplete(() async{
          UserModel model = await getUserFromUid(postModel.userId);
          // if(loggedInUser!.uid != model.uid){
          //    await sendPushNotification(model.deviceToken,{
          //      "body" : "",
          //      "title": "${loggedInUser!.userName} like your post"
          //    },{
          //      "type": "LIKE",
          //      "uid": loggedInUser!.uid,
          //    });
          // }
        });
      }else{
        likes.add(loggedInUser!.uid);
        postRef.doc(postModel.postId).update({"likeCount":likes});
      }

    });
  }

  savePost(PostModel posts) {
    userRef.doc(loggedInUser!.uid).get().then((value) {
      UserModel user = UserModel.fromJson(value.data()!);
      List saved = user.savedPosts;
      if(saved.contains(posts.postId)){
        saved.remove(posts.postId);
      }else{
        saved.add(posts.postId);
      }
      userRef.doc(loggedInUser!.uid).update({"savedPosts":saved}).whenComplete(() {

      });

    });
    setState(() {});
  }
}
