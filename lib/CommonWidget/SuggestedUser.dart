import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Model/UserModel.dart';
import '../Utility/Color.dart';
import '../Utility/Style.dart';

class SuggestedUser extends StatefulWidget {
  List<UserModel> suggestedUser;
   SuggestedUser({Key? key, required this.suggestedUser}) : super(key: key);

  @override
  State<SuggestedUser> createState() => _SuggestedUserState();
}

class _SuggestedUserState extends State<SuggestedUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.suggestedUser.length,
          itemBuilder: (BuildContext context, int index) {
            return userItem(userModel: widget.suggestedUser[index],);
          }),
    );
  }

  Widget userItem({required UserModel userModel}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: whiteColor,width: 1.2),
      ),
      child: Column(
        children: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.close,color: whiteColor,)),
          const SizedBox(height: 5,),
          CachedNetworkImage(
            height: 100,width: 100,
            imageUrl: userModel.imgUrl,
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
          const SizedBox(height: 10,),
          Text("",style: whiteBoldText14),
          const SizedBox(height: 10,),
          GestureDetector(
            onTap: () async {},
            child: Container(
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: whiteColor,width: 1.2),
                  color: mainBlue
              ),
              child: Text("follow",textAlign: TextAlign.center,style: whiteBoldText14,),
            ),
          )
        ],
      )
    );
  }
}
