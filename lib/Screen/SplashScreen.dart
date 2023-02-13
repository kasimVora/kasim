import 'dart:async';

import 'package:flutter/material.dart';

import '../Helper/FirebaseHelperFunction.dart';
import '../main.dart';
import 'MediaPicker.dart';
import 'HomeScreen.dart';
import 'LoginScreen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async{
      if(authInst.currentUser!= null) {
       loggedInUser =  await getUserFromUid(authInst.currentUser!.uid);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: Center(
        child: Text("Splash Screen",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 30),),
      ),
    );
  }
}
