import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase__test/Utility/Color.dart';
import 'package:firebase__test/Model/UserModel.dart';
import 'package:firebase__test/Screen/UserProfile.dart';
import 'package:firebase__test/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController(text: "");
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: CupertinoSearchTextField(
              controller: controller,
              onChanged: (value) {
                setState(() {});
              },
              onSubmitted: (value) {},
              autocorrect: true,
            ),
          ),
          StreamBuilder(
            stream: userRef.where('user_name', isEqualTo: controller.text).snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
             if(snapshot.hasData){
               return userList(snapshot);
             }else{
               return const SizedBox();
             }
            },
          )
        ],
      ),
    );
  }

  Widget userList(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    List<UserModel> users = [];
    for(int i = 0 ;i<snapshot.data!.docs.length;i++){
      var  e = snapshot.data!.docs[i].data() as Map<String,dynamic>;
      print(e);
       users.add(UserModel.fromJson(e));
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemCount: users.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return  ListTile(
                leading: CachedNetworkImage(
                  height: 40,width: 40,
                  imageUrl: users[index].imgUrl,
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
                title: Text(users[index].userName),
                  tileColor: grey,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserProfile(uid: users[index].uid)));
                },
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

              );
            },
          separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 5,);
          },
        ),
      ),
    );
  }
}
