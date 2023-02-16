import 'dart:convert';

import 'package:firebase__test/Helper/FirebaseHelperFunction.dart';
import 'package:firebase__test/Model/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../CommonWidget/OTP.dart';
import '../../main.dart';
import '../HomeScreen.dart';
import 'CompleteProfile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final phone_number = TextEditingController(text: "9664818767");

  final con_1 = TextEditingController();
  final con_2 = TextEditingController();
  final con_3 = TextEditingController();
  final con_4 = TextEditingController();
  final con_5 = TextEditingController();
  final con_6 = TextEditingController();

  final phon_focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Login..", style: TextStyle(color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 30),),
            const SizedBox(height: 20,),
            TextFormField(
              controller: phone_number,
              maxLength: 10,
              focusNode: phon_focus,
              decoration: InputDecoration(
                fillColor: Colors.white,
                labelText: "Mobile Number",

                filled: false,
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
            const SizedBox(height: 30,),
            Center(
              child: TextButton(
                  onPressed: () async => await login(),
                  child: const Text("Send Otp")
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {

    phon_focus.unfocus();
    authInst.verifyPhoneNumber(
        phoneNumber: "+91${phone_number.text.trim()}",
        timeout: const Duration(seconds: 3),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          print("phoneAuthCredential");
          print(phoneAuthCredential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {  },
        codeSent: (String verificationId, int? forceResendingToken) {
          print(verificationId);
          if(verificationId.isNotEmpty){
            showOTP(verificationId);
          }

        },
        verificationFailed: (FirebaseAuthException error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message.toString())));
        }
    );



    //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));

  }

  void showOTP(String verificationId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter OTP"),
            insetPadding: EdgeInsets.zero,
            content:  SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OTP(con_1, con_2, con_3, con_4, con_5, con_6,
                          (val1, val2, val3, val4, val5, val6) {
                        setState(() {
                          con_1.text = val1;
                          con_2.text = val2;
                          con_3.text = val3;
                          con_4.text = val4;
                          con_5.text = val5;
                          con_6.text = val6;
                        });
                      }),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () async{
                String pin = con_1.text+con_2.text+con_3.text+con_4.text+con_5.text+con_6.text;
                AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: pin);

                await authInst.signInWithCredential(credential).then((value) async{

                  await userRef.doc(value.user!.uid).get().then((doc) {
                    if(doc.exists){
                      loggedInUser = UserModel.fromJson(doc.data()!);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteProfile(uid: value.user!.uid, phone: value.user!.phoneNumber!,)));
                    }
                  });

                }).catchError((e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
                });

              }, child: Text("Verify"))
            ],
          );
        }
    );
  }

}
