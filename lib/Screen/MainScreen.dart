import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase__test/Helper/Color.dart';
import 'package:firebase__test/Helper/Style.dart';
import 'package:flutter/material.dart';

import '../Model/PostModel.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<PostModel> posts = [
    PostModel(
        postId: "1",
        userId: "1",
        userName: "test1",
        postUrl: "https://images.unsplash.com/photo-1675935122676-b916c1cc6cc1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80",
        postType: "1",
        created: "now", commentsCount: '50', likeCount: '100', caption: 'Demo Image Caption'),
    PostModel(
        postId: "1",
        userId: "1",
        userName: "test2",
        postUrl: "https://plus.unsplash.com/premium_photo-1674069719051-4292e67620dd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=2000&q=60",
        postType: "1",
        created: "now", commentsCount: '50', likeCount: '100', caption: 'Demo Image Caption'),
    PostModel(
        postId: "1",
        userId: "1",
        userName: "test3",
        postUrl: "https://images.unsplash.com/photo-1675916137835-a4e122108f94?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
        postType: "1",
        created: "now", commentsCount: '50', likeCount: '100', caption: 'Demo Image Caption'),
    PostModel(
        postId: "1",
        userId: "1",
        userName: "test4",
        postUrl: "https://plus.unsplash.com/premium_photo-1666265087946-cd9f58758a3b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
        postType: "1",
        created: "now", commentsCount: '50', likeCount: '100', caption: 'Demo Image Caption'),
    PostModel(
        postId: "1",
        userId: "1",
        userName: "test5",
        postUrl: "https://images.unsplash.com/photo-1661956601031-4cf09efadfce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1176&q=80",
        postType: "1",
        created: "now", commentsCount: '50', likeCount: '100', caption: 'Demo Image Caption'),
    PostModel(
        postId: "1",
        userId: "1",
        userName: "test6",
        postUrl: "https://images.unsplash.com/photo-1675751330486-2bc3475cf7a3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
        postType: "1",
        created: "now", commentsCount: '50', likeCount: '100', caption: 'Demo Image Caption'),
    PostModel(
        postId: "1",
        userId: "1",
        userName: "test7",
        postUrl: "https://images.unsplash.com/photo-1661956602139-ec64991b8b16?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=665&q=80",
        postType: "1",
        created: "now", commentsCount: '50', likeCount: '100', caption: 'Demo Image Caption'),
    PostModel(
        postId: "1",
        userId: "1",
        userName: "test8",
        postUrl: "https://images.unsplash.com/photo-1675880004057-9215c54267e9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
        postType: "1",
        created: "now", commentsCount: '50', likeCount: '100', caption: 'Demo Image Caption'),
    PostModel(
        postId: "1",
        userId: "1",
        userName: "test9",
        postUrl: "https://images.unsplash.com/photo-1675789652972-ee2040d2cc9a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
        postType: "1",
        created: "now", commentsCount: '50', likeCount: '100', caption: 'Demo Image Caption'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
        shrinkWrap: true,
            primary: false,
            physics: const BouncingScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return listItem(index);
            })
           )
          ],
        ),
      ),
    );
  }

  Widget listItem( int index) {
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
              imageUrl: posts[index].postUrl,
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
                            imageUrl: posts[index].postUrl,
                            errorWidget: (context, url, error) => const Text("error"),
                            imageBuilder: (context, imageProvider) => CircleAvatar(
                              radius: 15,
                              backgroundImage: imageProvider,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Text(posts[index].userName,style: whiteNormalText13,)
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
                            text: posts[index].userName,
                            style:whiteBoldText14,

                            children: <InlineSpan>[
                              TextSpan(
                                text: "  ${posts[index].caption}",
                                  style: whiteNormalText11,
                              )
                            ]
                        )
                    ),
                    const SizedBox(height: 3,),
                    Text("${posts[index].likeCount} likes",style: whiteNormalText13,),
                    const SizedBox(height: 3,),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: blackColor,
                        prefixIconConstraints: const BoxConstraints(maxHeight: 40),
                        prefixIcon:   CachedNetworkImage(
                          imageUrl: posts[index].postUrl,
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
                    Text("View all${posts[index].commentsCount} Comments",style: grayNormalText12,),
                    const SizedBox(height: 3,),
                    Text("${posts[index].created} minutes ago ",style: grayNormalText12,),
                  ],
                );
              }
            ),
          ],
        ));
  }

}
