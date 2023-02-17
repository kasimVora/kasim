
import 'package:firebase__test/Utility/size_config.dart';
import 'package:flutter/material.dart';

import 'Color.dart';

final ButtonStyle raisedButtonStyle = TextButton.styleFrom(
  primary: Colors.black87,
  backgroundColor: primaryColor,
  padding: const EdgeInsets.all(10),
  minimumSize: const Size(280, 40),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(50)),
  ),
);

final ButtonStyle squareButtonStyle = TextButton.styleFrom(
  primary: Colors.black87,
  backgroundColor: Colors.black87,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle primaryColorButton = TextButton.styleFrom(
  backgroundColor: primaryColor,
  //minimumSize: const Size(88, 36),
  // padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);


final ButtonStyle secondaryPrimaryColorButton = TextButton.styleFrom(
  backgroundColor: secondaryPrimaryColor,
  //minimumSize: const Size(88, 36),
  // padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);


final ButtonStyle  rejectButtonBlueStyle = TextButton.styleFrom(
  backgroundColor: deepOrangeAccentColor,
  padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);


final ButtonStyle deleteButtonBlueStyle = TextButton.styleFrom(
  primary: redColor,
  backgroundColor: redColor,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle previewButtonBlueStyle = TextButton.styleFrom(
  primary: greenColor,
  backgroundColor: greenColor,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);


final ButtonStyle documentButtonBlueStyle = ElevatedButton.styleFrom(
  primary: primaryColor,
);

TextStyle heading = const TextStyle(fontSize: 30, color: blackColor,fontFamily: 'Poppins', fontWeight: FontWeight.bold);

// Black Normal Style
TextStyle blackNormalText10 = const TextStyle(fontSize: 10, color: blackColor);

TextStyle blackNormalText14 = const TextStyle(fontSize: 14, color: blackColor);

TextStyle blackNormalText16 = const TextStyle(fontSize: 16, color: blackColor);

TextStyle blackNormalText18 = const TextStyle(fontSize: 18, color: blackColor);

// Black Bold Style
TextStyle blackBoldText10 = const TextStyle(fontSize: 10, color: blackColor, fontWeight: FontWeight.bold);

TextStyle blackBoldText14 = const TextStyle(fontSize: 14, color: blackColor, fontWeight: FontWeight.bold);

TextStyle blackBoldText16 = const TextStyle(fontSize: 16, color: blackColor, fontWeight: FontWeight.bold);

TextStyle blackBoldText18 = const TextStyle(fontSize: 18, color: blackColor, fontWeight: FontWeight.bold);
TextStyle txtstyle = TextStyle(fontSize: 14, color: const Color(0xFF0D0D0D).withOpacity(0.8));

// White Normal Style
TextStyle whiteNormalText13 = const TextStyle(fontSize: 13, color: whiteColor);
TextStyle whiteNormalText11 = const TextStyle(fontSize: 11, color: whiteColor);
TextStyle whiteNormalText14 = const TextStyle(fontSize: 14, color: whiteColor,fontWeight: FontWeight.normal);

TextStyle whiteNormalText16 = const TextStyle(fontSize: 16, color: whiteColor,fontWeight: FontWeight.normal);

TextStyle whiteNormalText18 = const TextStyle(fontSize: 18, color: whiteColor);

// White Bold Style
TextStyle whiteBoldText14 = const TextStyle(fontSize: 14, color: whiteColor, fontWeight: FontWeight.bold);

TextStyle whiteBoldText16 = const TextStyle(fontSize: 16, color: whiteColor, fontWeight: FontWeight.bold);

TextStyle whiteBoldText18 = const TextStyle(fontSize: 18, color: whiteColor, fontWeight: FontWeight.bold);



// Gray Normal Style
TextStyle grayNormalText12 =  TextStyle(fontSize: 12, color: Colors.grey[600],fontWeight: FontWeight.normal);

TextStyle grayNormalText14 = TextStyle(fontSize: 14, color: Colors.grey[600]);

TextStyle grayNormalText16 = TextStyle(fontSize: 16, color: Colors.grey[600]);

TextStyle grayNormalText18 = TextStyle(fontSize: 18, color: Colors.grey[600]);

TextStyle grayLightNormalText18 = TextStyle(fontSize: 18, color: Colors.grey[600]);
TextStyle grayLightNormalText15 = TextStyle(fontSize: 15, color: Colors.grey[600]);

// Gray Bold Style
TextStyle grayBoldText14 = TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.bold);

TextStyle grayBoldText16 = TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.bold);

TextStyle grayBoldText18 = TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.bold);

// Orange Normal Style
TextStyle orangeNormalText13 = const TextStyle(fontSize: 14, color: orangeColor);
TextStyle orangeNormalText11 = const TextStyle(fontSize: 15, color: orangeColor);
TextStyle orangeNormalText14 = const TextStyle(fontSize: 18, color: orangeColor);


// mainBg Bold Style
TextStyle primaryColorBoldText14 = const TextStyle(fontSize: 14, color: primaryColor, fontWeight: FontWeight.bold);
TextStyle primaryColorBoldText16 = const TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold);
TextStyle primaryColorBoldText18 = const TextStyle(fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold);
TextStyle primaryColorBoldText22 = const TextStyle(fontSize: 22, color: primaryColor, fontWeight: FontWeight.bold);

TextStyle primaryColorNormalText14 = const TextStyle(fontSize: 14, color: primaryColor, fontWeight: FontWeight.normal);

TextStyle primaryColorNormalText16 = const TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.normal);

TextStyle primaryColorNormalText18 = const TextStyle(fontSize: 18, color: primaryColor, fontWeight: FontWeight.normal);

// secondBg Bold Style
TextStyle secondaryPrimaryColorBoldText14 = const TextStyle(fontSize: 14, color: secondaryPrimaryColor, fontWeight: FontWeight.bold);

TextStyle secondaryPrimaryColorBoldText16 = const TextStyle(fontSize: 16, color: secondaryPrimaryColor, fontWeight: FontWeight.bold);

TextStyle secondaryPrimaryColorBoldText18 = const TextStyle(fontSize: 18, color: secondaryPrimaryColor, fontWeight: FontWeight.bold);

TextStyle secondaryPrimaryColorNormalText14 = const TextStyle(fontSize: 14, color: secondaryPrimaryColor, fontWeight: FontWeight.normal);

TextStyle secondaryPrimaryColorNormalText16 = const TextStyle(fontSize: 16, color: secondaryPrimaryColor, fontWeight: FontWeight.normal);

TextStyle secondaryPrimaryColorNormalText18 = const TextStyle(fontSize: 18, color: secondaryPrimaryColor, fontWeight: FontWeight.normal);

//ALPITA START

final ButtonStyle pdfButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  elevation: 80,
  primary: progressColor,

  shape:RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40.0),
  ),

);

final ButtonStyle buttonStyle2 = ElevatedButton.styleFrom(
  onPrimary: whiteColor,
  elevation: 80,
  primary: Colors.orange.withOpacity(0.8),

  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);
final ButtonStyle buttonOrange = ElevatedButton.styleFrom(
  onPrimary: whiteColor,
  elevation: 80,
  primary: Colors.red,

  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),

);
final ButtonStyle buttonGreen = ElevatedButton.styleFrom(
  onPrimary: whiteColor,
  elevation: 80,
  primary: Colors.green,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),

);
final ButtonStyle buttonSuccess = ElevatedButton.styleFrom(
  onPrimary: whiteColor,
  elevation: 8,
  primary: Colors.blue,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),

);

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  onPrimary: whiteColor,
  elevation: 80,
  primary: primaryColor,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);


final ButtonStyle buttonSecondaryPrimary = ElevatedButton.styleFrom(
  onPrimary: whiteColor,
  elevation: 80,
  primary: secondaryPrimaryColor,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

TextStyle formLabelStyle = const TextStyle(fontSize: 16,color: blackColor);
TextStyle formSvExLabelStyle = const TextStyle(fontSize: 16,color: primaryColor,fontWeight: FontWeight.bold);
TextStyle dashboardBoldText14 =const TextStyle(fontSize: 14, color: blackColor, fontWeight: FontWeight.bold);
TextStyle formTitle = const TextStyle(fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold);
TextStyle formLabel = TextStyle(fontSize: 16, color: Colors.grey[600]);
BoxDecoration previewBoxDecoration = BoxDecoration(color: greysecond.withOpacity(0.4), borderRadius: const BorderRadius.all(Radius.circular(20)));
EdgeInsets  previewContainerPadding = const EdgeInsets.all(10);
TextStyle grayPreviewText13 = TextStyle(fontSize: 13, color:Colors.grey[600]);
TextStyle previewBoldText18 = const TextStyle(fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold);
TextStyle secondaryNormal18 = const TextStyle(fontSize: 18, color: secondaryPrimaryColor);

final ButtonStyle imageViewButtonStyle = TextButton.styleFrom(
  primary: grayColor,
  backgroundColor: primaryColor,
  padding: const EdgeInsets.all(3),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
  ),
);


TextStyle primaryLabelText18 = const TextStyle(fontSize: 18, color: blackColor, fontWeight: FontWeight.bold);
TextStyle redNormalText18 = const TextStyle(fontSize: 18, color: Colors.red,fontStyle: FontStyle.italic);
TextStyle redNormalText13 = const TextStyle(fontSize: 13, color: Colors.red,fontWeight: FontWeight.bold);
TextStyle redNormalText14 = const TextStyle(fontSize: 14, color: Colors.red,fontWeight: FontWeight.bold);
TextStyle txtHintStyle = TextStyle(fontSize: 14, color: const Color(0xFF5393E5).withOpacity(0.7));
TextStyle txtHintStyle2 = const TextStyle(fontSize: 14, color: Color(0xFF0D0D0D));

TextStyle txtStyle = TextStyle(fontSize: 14, color: const Color(0xFF0D0D0D).withOpacity(0.8));
TextStyle txtChangeStyle = TextStyle(fontSize: 14, color: const Color(0xFF5393E5).withOpacity(0.7),fontFamily: 'Raleway');

//ALPITA END

//NIL START
BoxDecoration inputContainerBoxDecoration = BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5));
EdgeInsets inputContainerPadding = const EdgeInsets.fromLTRB(15.0, 0, 0, 0);

TextStyle greenNormalText18 = const TextStyle(fontSize: 18, color: Colors.green);
TextStyle greenNormalText14 = const TextStyle(fontSize: 14, color: Colors.green,fontWeight: FontWeight.bold);
//NIL END


//KASIM START


//OTP STYLE

BoxDecoration textBoxDecoration =  BoxDecoration(color: primaryColor.withOpacity(0.2),borderRadius: const BorderRadius.all(Radius.circular(10)));

InputDecoration applTxtDecoration2(String hint){
  return InputDecoration(
    fillColor: primaryColor.withOpacity(0.2),
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
    border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10)),
    isDense: true,
    hintText: hint,
    hintStyle: txtHintStyle2,
    counterText: "",
  );
}
InputDecoration applTxtDecoration(String hint){
  return InputDecoration(
    fillColor: whiteColor,
    filled: true,
    enabledBorder: InputBorder.none,
    disabledBorder: InputBorder.none,

    // contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
    // border: UnderlineInputBorder(
    //     borderSide: BorderSide.none,
    //     borderRadius: BorderRadius.circular(10)),
    // enabledBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(30),
    //   borderSide: const BorderSide(color: primaryColor, width: 1.3),
    //
    //   //gapPadding: 10,
    // ),
    isDense: true,
    hintText: hint,
    hintStyle: txtHintStyle2,
    counterText: "",
  );
}
TextStyle txtHintUpdate = const TextStyle(fontSize: 14, color: Color(0xFFA8A5A5));
InputDecoration applTxtDecorationUpdate(String hint){
  return InputDecoration(
    fillColor:primaryColor.withOpacity(0.2) ,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
    border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10)),
    isDense: false,
    hintText: hint,
    hintStyle: txtHintUpdate,
    counterText: "",

  );
}

InputDecoration applTxtDecorationDisable(String hint){
  return InputDecoration(
    fillColor:lightGray400Color!.withOpacity(0.2) ,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
    border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10)),
    isDense: false,
    hintText: hint,
    hintStyle: txtHintUpdate,
    counterText: "",

  );
}
InputDecoration applTxtDecorationEnable(String hint){
  return InputDecoration(
    fillColor:whiteColor,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
    border: OutlineInputBorder(
        borderSide: const BorderSide(color: primaryColor,width: 2),
        borderRadius: BorderRadius.circular(10)),
    isDense: false,
    hintText: hint,
    hintStyle: txtHintUpdate,
    counterText: "",

  );
}


final otpInputDecoration = InputDecoration(
  fillColor: whiteColor,
  counterStyle: const TextStyle(height: double.minPositive,),
  counterText: "",
  contentPadding: const EdgeInsets.symmetric(
      vertical: 15.0, horizontal: 10.0),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide:  const BorderSide(color: whiteColor,width: 1.2),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide:  const BorderSide(color: whiteColor,width: 1.2),
  ),
  border: UnderlineInputBorder(

      borderRadius: BorderRadius.circular(10.0)
  ),
  isDense: true,
  // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
);

final pincodeDecoration = InputDecoration(
  focusColor:  const Color(0xFF5393E5).withOpacity(0.8),
  hintStyle: TextStyle(color: const Color(0xFF5393E5).withOpacity(0.8)),
  counterText: "",
  contentPadding: const EdgeInsets.symmetric(
      vertical: 15.0, horizontal: 10.0),
  isDense: true,
  // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: const Color(0xFF5393E5).withOpacity(0.8)),
  ),
);
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: Color(0xFF757575)),
  );
}

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const h1Style = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
const h2Style = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

//KASIM END


//ALPITA NEW

TextStyle whiteBoldText22 = const TextStyle(fontSize: 22, color: whiteColor,fontWeight: FontWeight.bold);
TextStyle blackBoldText20 = const TextStyle(fontSize: 20, color:blackColor ,fontWeight: FontWeight.bold);
TextStyle orangeText14 = const TextStyle(fontSize: 14, color: orangeColor);


final ButtonStyle eventAddStyle = TextButton.styleFrom(
  backgroundColor: primaryColor,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle eventCompleteStyle = TextButton.styleFrom(
  backgroundColor: dashYellowColor,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle eventStartStyle = TextButton.styleFrom(
  backgroundColor: greenColor,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle eventPrintStyle = TextButton.styleFrom(
  backgroundColor: deepOrangeAccentColor,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);
final ButtonStyle eventDetailStyle = TextButton.styleFrom(
  backgroundColor: thirdcolor,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);


//ALPITA NEW


InputDecoration textWithOutDec(String hint){
  return InputDecoration(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
    isDense: false,
    hintText: hint,
    hintStyle: txtHintStyle2,
    counterText: "",

  );
}


InputDecoration newInputStyle(){
  return InputDecoration(
    fillColor: Colors.transparent,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: primaryColor, width: 1.3),
      //gapPadding: 10,
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: graysub, width: 1.3)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: graysub, width: 1.3),
      //gapPadding: 10,
    ),
    isDense: true,
    hintText: "",
    hintStyle: txtHintStyle2,
    counterText: "",
  );
}
InputDecoration newInputStyleDiasble(){
  return InputDecoration(
    fillColor:lightGray400Color!.withOpacity(0.5) ,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: primaryColor, width: 1.3),
      //gapPadding: 10,
    ),
    border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: graysub, width: 1.3)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: graysub, width: 1.3),

      //gapPadding: 10,
    ),

    isDense: true,
    hintText: "",
    hintStyle: txtHintStyle2,
    counterText: "",
  );
}
