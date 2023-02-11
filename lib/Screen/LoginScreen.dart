import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../main.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final phone_number = TextEditingController();
  OtpFieldController otpController = OtpFieldController();
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
              decoration: InputDecoration(
                fillColor: Colors.white,
                labelText: "Mobile Number",
                filled: true,
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


      authInst.verifyPhoneNumber(
          phoneNumber: "+91${phone_number.text.trim()}",
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {  },
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
            title: Text("Give the code?"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                OTPTextField(
                    controller: otpController,
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 15,
                    style: TextStyle(fontSize: 17),
                    onChanged: (pin) {
                      print("Changed: " + pin);
                    },
                    onCompleted: (pin) {
                      print("Completed: " + otpController.toString());
                    }),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Confirm"),
                onPressed: () async{
                  final code = otpController.toString();
                  AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);

                  UserCredential result = await authInst.signInWithCredential(credential);

                  print(result.user);

                  if(result.user != null){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => HomeScreen()
                    ));
                  }else{
                    print("Error");
                  }
                },
              )
            ],
          );
        }
    );
  }

}


