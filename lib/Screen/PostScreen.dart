import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase__test/Helper/Color.dart';
import 'package:firebase__test/Helper/FirebaseHelperFunction.dart';
import 'package:firebase__test/Helper/Style.dart';
import 'package:firebase__test/Model/UserModel.dart';
import 'package:flutter/material.dart';

import '../Model/PostModel.dart';
import '../main.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Column(
          children: [

            SizedBox(height: 20,),
            StreamBuilder(
              stream: postRef.snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData){
                  return postList(snapshot);
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

  Widget listItem( PostModel posts) {
    return Card(
        margin: const EdgeInsets.all(7),
        elevation: 3,
        color: blackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            CachedNetworkImage(
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
                      // decoration: BoxDecoration(
                      //   border: Border.all(width: 5),
                      //   borderRadius: BorderRadius.circular(2), //<-- SEE HERE
                      // ),
                      child: Image(
                          image: image,
                        fit: BoxFit.cover,

                      ),
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: (){}, icon: const Icon(Icons.favorite,color: redColor,)),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.chat_bubble,color: whiteColor,)),
                      ],
                    ),
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
                    Text("${posts.likeCount} likes",style: whiteNormalText13,),
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
                    Text("${posts.created}es ago ",style: grayNormalText12,),
                  ],
                );
              }
            ),
          ],
        ));
  }


  Widget postList(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<PostModel> posts = [];

    for(var i  in snapshot.data!.docs){
      if(loggedInUser!.following.contains(i.id)){
        postRef.doc(i.id).collection(i.id).get().then((QuerySnapshot snap) {
          for(int i = 0 ;i<snap.docs.length;i++){
            var  e = snap.docs[i].data() as Map<String,dynamic>;
            print(e);
            posts.add(PostModel.fromJson(e));
          }
        });
      }
    }
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: const BouncingScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return listItem(posts[index]);
            }));
  }

}
