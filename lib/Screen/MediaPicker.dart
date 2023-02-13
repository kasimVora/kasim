import 'dart:convert';
import 'dart:io';

import 'package:firebase__test/Helper/Color.dart';
import 'package:firebase__test/Helper/Style.dart';
import 'package:firebase__test/Helper/Utility.dart';
import 'package:firebase__test/Screen/CameraScreen.dart';
import 'package:flutter/material.dart';
import 'package:storage_path/storage_path.dart';

import '../Helper/DropDownWidget.dart';
import '../Model/DropDownModel.dart';
import '../Model/FileModel.dart';
import 'CreatePost.dart';

class MediaPicker extends StatefulWidget {
  const MediaPicker({Key? key}) : super(key: key);

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  List<FileModel> files = [];
  FileModel? selectedModel;
  List<DropDownModal> reasonList = [];
  String image = '';
  String reasonSelect = '';
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async{
      await getImagesPath();
    });

  }

  getImagesPath() async {

    var imagePath = await StoragePath.imagesPath;
    var images = jsonDecode(imagePath) as List;
    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    if (files != null && files.length > 0)
      setState(() {
        selectedModel = files[0];
        reasonSelect = files[0].folder;
        image = files[0].files[0];
      });

    if(files.isNotEmpty){
      for(int i = 0 ;i<files.length;i++){
        reasonList.add(DropDownModal(id: files[i].folder, title: files[i].folder, titleKn: "", status: ""));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[

             Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: (){
                    if(image.isNotEmpty){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreatePost(image: image),
                        ),
                      );
                    }
                  },
                  child: Text("Next") ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
                child: image.isNotEmpty
                    ? Image.file(File(image),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width)
                    : Container()),
            Row(
              children: [
                Expanded(
                  child: DropDownWidget(
                      lable: 'Select ',
                      list: reasonList,
                      selValue: reasonSelect,
                      selectValue: (value) {
                        reasonSelect = value;
                        selectedModel = files.where((element) => element.folder == value).first;
                        print(value);
                        setState(() {});
                      }),
                ),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraScreen()));
                }, icon: const Icon(Icons.camera_alt_outlined))
              ],
            ),
            selectedModel == null
                ? Container()
                : Expanded(child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4),
                      itemBuilder: (_, i) {
                        var file = selectedModel!.files[i];
                        return GestureDetector(
                          child: Image.file(
                            File(file),
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            setState(() {
                              image = file;
                            });
                          },
                        );
                      },
                      itemCount: selectedModel!.files.length),)
          ],
        ),
      ),
    );
  }


}