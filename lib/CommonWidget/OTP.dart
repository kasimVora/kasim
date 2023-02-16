
import 'package:firebase__test/Utility/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Utility/Style.dart';


class OTP extends StatefulWidget {

  TextEditingController con_1_=TextEditingController();
  TextEditingController con_2_=TextEditingController();
  TextEditingController con_3_=TextEditingController();
  TextEditingController con_4_=TextEditingController();
  TextEditingController con_5_=TextEditingController();
  TextEditingController con_6_=TextEditingController();

  Function selectValue;

  OTP(this.con_1_, this.con_2_, this.con_3_, this.con_4_, this.con_5_,
      this.con_6_, this.selectValue );

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {

  final pin2FocusNode = FocusNode();
  final pin1FocusNode = FocusNode();
  final pin3FocusNode = FocusNode();
  final pin4FocusNode = FocusNode();
  final pin5FocusNode = FocusNode();
  final pin6FocusNode = FocusNode();

  bool flag = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RawKeyboardListener(
                onKey: (RawKeyEvent event) {
                  print(event.logicalKey.keyId);
                  if (event.runtimeType == RawKeyDownEvent &&
                      (event.logicalKey.keyId ==
                          4294967304)) //Enter Key ID from keyboard
                      {
                    pin1FocusNode.unfocus();
                    widget.con_2_.text = '';
                    widget.con_3_.text = '';
                    widget.con_4_.text = '';
                    widget.con_5_.text = '';
                    widget.con_6_.text = '';
                    setState(() {});
                  }
                },
                focusNode: FocusNode(),
                child: SizedBox(
                  width: getProportionateScreenWidth(30),
                  child: TextFormField(
                    controller: widget.con_1_,
                    focusNode: pin1FocusNode,
                    maxLength: 1,style: blackNormalText14,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      if (value.length == 1) {
                        setState(() {
                          widget.con_1_.text = value;
                          flag = true;
                        });
                        pin1FocusNode.unfocus();
                        pin2FocusNode.requestFocus();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              RawKeyboardListener(
                onKey: (RawKeyEvent event) {
                  if (event.runtimeType == RawKeyDownEvent &&
                      (event.logicalKey.keyId ==
                          4294967304)) //Enter Key ID from keyboard
                      {
                    pin1FocusNode.requestFocus();

                    widget.con_3_.text = '';
                    widget.con_4_.text = '';
                    widget.con_5_.text = '';
                    widget.con_6_.text = '';
                    setState(() {});
                  }
                },
                focusNode: FocusNode(),
                child: SizedBox(
                  width: getProportionateScreenWidth(30),
                  child: TextFormField(
                    controller: widget.con_2_,
                    focusNode: pin2FocusNode,
                    maxLength: 1,style: blackNormalText14,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      if (value.length == 1) {
                        setState(() {
                          widget.con_2_.text = value;
                        });

                        pin2FocusNode.unfocus();
                        pin3FocusNode.requestFocus();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (RawKeyEvent event) {
                  if (event.runtimeType == RawKeyDownEvent &&
                      (event.logicalKey.keyId ==
                          4294967304)) //Enter Key ID from keyboard
                      {
                    pin2FocusNode.requestFocus();

                    widget.con_4_.text = '';
                    widget.con_5_.text = '';
                    widget.con_6_.text = '';
                    setState(() {});
                  }
                },
                child: SizedBox(
                  width: getProportionateScreenWidth(30),
                  child: TextFormField(
                    controller: widget.con_3_,
                    keyboardType: TextInputType.number,
                    maxLength: 1,style: blackNormalText14,
                    focusNode: pin3FocusNode,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      if (value.length == 1) {
                        setState(() {
                          widget.con_3_.text = value;
                        });
                        pin3FocusNode.unfocus();
                        pin4FocusNode.requestFocus();
                      }
                    },
                    decoration: otpInputDecoration,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (RawKeyEvent event) {
                  if (event.runtimeType == RawKeyDownEvent &&
                      (event.logicalKey.keyId ==
                          4294967304)) //Enter Key ID from keyboard
                      {
                    pin3FocusNode.requestFocus();

                    widget.con_5_.text = '';
                    widget.con_6_.text = '';
                    setState(() {});
                  }
                },
                child: SizedBox(
                  width: getProportionateScreenWidth(30),
                  child: TextFormField(
                      controller: widget.con_4_,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      focusNode: pin4FocusNode,
                      textAlign: TextAlign.center,
                      style: blackNormalText14,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        if (value.length == 1) {
                          setState(() {
                            widget.con_4_.text = value;
                          });
                          pin4FocusNode.unfocus();
                          pin5FocusNode.requestFocus();
                        }
                      }),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (RawKeyEvent event) {
                  if (event.runtimeType == RawKeyDownEvent &&
                      (event.logicalKey.keyId ==
                          4294967304)) //Enter Key ID from keyboard
                      {
                    pin4FocusNode.requestFocus();

                    widget.con_6_.text = '';
                    setState(() {  });
                  }
                },
                child: SizedBox(
                  width: getProportionateScreenWidth(30),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: widget.con_5_,
                    maxLength: 1,
                    focusNode: pin5FocusNode,style: blackNormalText14,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      if (value.length == 1) {
                        setState(() {
                          widget.con_5_.text = value;
                        });

                        pin5FocusNode.unfocus();
                        pin6FocusNode.requestFocus();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (RawKeyEvent event) {
                  if (event.runtimeType == RawKeyDownEvent &&
                      (event.logicalKey.keyId ==
                          4294967304)) //Enter Key ID from keyboard
                      {
                    widget.con_6_.text = '';
                    setState(() {

                    });
                    pin5FocusNode.requestFocus();
                  }
                },
                child: SizedBox(
                  width: getProportionateScreenWidth(30),
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: widget.con_6_,
                      style: blackNormalText14,
                      focusNode: pin6FocusNode,
                      maxLength: 1,
                      onChanged: (value) {
                        if (value.length == 1) {
                          setState(() {
                            widget.con_6_.text = value;
                          });
                          widget.selectValue(
                            widget.con_1_.text,
                            widget.con_2_.text,
                            widget.con_3_.text,
                            widget.con_4_.text,
                            widget.con_5_.text,
                            widget.con_6_.text,);

                          pin6FocusNode.unfocus();
                        }
                      },
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration),
                ),
              ),
            ],
          )
        ],

      ),
    );
  }
}
