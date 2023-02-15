import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../CommonWidget/PostItem.dart';
import '../../Helper/FirebaseHelperFunction.dart';
import '../../Model/PostModel.dart';
import '../../Model/UserModel.dart';
import '../../Utility/Color.dart';
import '../../Utility/Style.dart';
import '../../Utility/Utility.dart';
import '../../main.dart';

class SinglePostScreen extends StatefulWidget {
  String post;
   SinglePostScreen({Key? key,required this.post}) : super(key: key);


  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          StreamBuilder(
            stream: postRef.doc(widget.post).snapshots(),
            builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(snapshot.hasData){
                return postList(snapshot);
              }else{
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget postList(AsyncSnapshot<DocumentSnapshot> snapshot) {
     var object = snapshot.data!.data() as Map<String,dynamic>;
     PostModel postData = PostModel.fromJson(object);

    return PostItem(posts: postData);
  }

  Widget postItem( PostModel posts) {
    return Card(
        margin: const EdgeInsets.all(0),
        elevation: 3,
        color: blackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            GestureDetector(
              onDoubleTap: () => likeFunction(posts),
              child: CachedNetworkImage(
                  imageUrl: posts.postUrl,
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: posts.postUrl,
                                errorWidget: (context, url, error) => const Text("error"),
                                imageBuilder: (context, imageProvider) => CircleAvatar(
                                  radius: 15,
                                  backgroundImage: imageProvider,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text(posts.userName,style: whiteNormalText13,)
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
                            IconButton(onPressed: () => likeFunction(posts), icon:  Icon(posts.likeCount.contains(loggedInUser!.uid) ? Icons.favorite : Icons.favorite_border,color: posts.likeCount.contains(loggedInUser!.uid) ? redColor : whiteColor,)),
                            IconButton(onPressed: (){}, icon: const Icon(Icons.chat_bubble_outline,color: whiteColor,)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                  TextSpan(
                                      text: posts.userName,
                                      style:whiteBoldText14,

                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: "  ${posts.caption}",
                                          style: whiteNormalText11,
                                        )
                                      ]
                                  )
                              ),
                              const SizedBox(height: 3,),
                              posts.likeCount.isNotEmpty ? Text( "${posts.likeCount.length} likes" ,style: whiteNormalText13,) : const SizedBox(),
                              const SizedBox(height: 3,),
                              TextFormField(
                                decoration: InputDecoration(
                                    fillColor: blackColor,
                                    prefixIconConstraints: const BoxConstraints(maxHeight: 40),
                                    prefixIcon:   CachedNetworkImage(
                                      imageUrl: posts.postUrl,
                                      errorWidget: (context, url, error) => const Text("error"),
                                      imageBuilder: (context, imageProvider) => CircleAvatar(
                                        radius: 15,
                                        backgroundImage: imageProvider,
                                      ),
                                    ),
                                    filled: true,
                                    enabledBorder: InputBorder.none,
                                    isDense: true,
                                    hintText: "   Add a comment",
                                    counterText: "",
                                    hintStyle: grayNormalText12
                                ),
                              ),
                              const SizedBox(height: 3,),
                              Text("View all${posts.commentsCount} Comments",style: grayNormalText12,),
                              const SizedBox(height: 3,),
                              Text(getTimeDifferenceFromNow(posts.created!),style: grayNormalText12,),
                            ],
                          ),
                        )
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
}
