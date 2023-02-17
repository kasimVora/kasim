import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase__test/Helper/FirebaseHelperFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Model/UserModel.dart';
import '../Utility/Color.dart';
import '../Utility/Style.dart';
import '../main.dart';

class SuggestedUser extends StatefulWidget {
  List<UserModel> suggestedUser;
   SuggestedUser({Key? key, required this.suggestedUser}) : super(key: key);

  @override
  State<SuggestedUser> createState() => _SuggestedUserState();
}

class _SuggestedUserState extends State<SuggestedUser> {
  @override
  Widget build(BuildContext context) {
    return widget.suggestedUser.isNotEmpty ? SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 190,
      child:  ListView.separated(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.horizontal,
          itemCount: widget.suggestedUser.length,
          itemBuilder: (BuildContext context, int index) {
            return userItem(index);
          }, separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 10,);
      },) ,
    ) : const SizedBox();
  }

  Widget userItem(int index) {
    return Container(
      padding: const EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: whiteColor,width: 1.2),
      ),
      child: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: (){
                widget.suggestedUser.removeAt(index);
                setState(() {});
              }, icon: const Icon(Icons.close,color: whiteColor,size: 20,)),
          CachedNetworkImage(
            height: 100,width: 100,
            imageUrl:widget.suggestedUser[index].imgUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.person),
          ),
          const SizedBox(height: 3,),
          Text(widget.suggestedUser[index].userName,style: whiteNormalText14),
          const SizedBox(height: 5,),
          GestureDetector(
            onTap: () async {
              if(loggedInUser!.following.contains(widget.suggestedUser[index].uid)){
                //unfollow
                List<String> followers = widget.suggestedUser[index].followers;
                followers.remove(loggedInUser!.uid);
                userRef.doc(loggedInUser!.uid).update({"followers": followers});

                List<String> followings = loggedInUser!.following;
                followings.remove(widget.suggestedUser[index].uid);
                userRef.doc(loggedInUser!.uid).update({"following": followings});
              }else{
                //follow
                List<String> followers = widget.suggestedUser[index].followers;
                followers.add(loggedInUser!.uid);
                userRef.doc(widget.suggestedUser[index].uid).update({"followers": followers});

                List<String> followings = loggedInUser!.following;
                followings.add(widget.suggestedUser[index].uid);
                userRef.doc(loggedInUser!.uid).update({"following": followings});
              }
            },
            child: Container(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 3,bottom: 3),
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: whiteColor,width: 1.2),
                  color: loggedInUser!.following.contains(widget.suggestedUser[index].uid) ? blackColor : mainBlue
              ),
              child: Text(loggedInUser!.following.contains(widget.suggestedUser[index].uid) ? "following" : "follow" ,textAlign: TextAlign.center,style: whiteBoldText14,),
            ),
          )
        ],
      )
    );
  }
}
