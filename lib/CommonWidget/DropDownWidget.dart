import 'package:flutter/material.dart';

import '../Model/DropDownModel.dart';
import '../Utility/Style.dart';

class DropDownWidget extends StatelessWidget {
  String? selValue;
  Function selectValue;
  List<DropDownModal> list = [];
  String lable;

  DropDownWidget(
      {Key? key, required this.lable,
      required this.list,
      this.selValue,
      required this.selectValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text(lable),
      isDense: true,
      value: selValue != null && selValue!.isNotEmpty ? selValue : null,
      decoration:  applTxtDecoration(lable),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => value == null ? 'Please $lable' : null,
      onChanged: (String? value) async {
        if (selValue == '' || (value! != selValue)) {
          selectValue(value);
        }
      },
      isExpanded: true,
      menuMaxHeight: 400,
      items: list.map((DropDownModal user) {
        return DropdownMenuItem<String>(
            value: user.id,
            child: Text(
              user.title,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ));
      }).toList(),
    );
  }
}
