



import 'package:flutter/material.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PickerScreen extends StatefulWidget {
  const PickerScreen({super.key});

  @override
  State<PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  final _instaAssetsPicker = InstaAssetPicker();
  final _provider = DefaultAssetPickerProvider(maxAssets: 10);
  List<AssetEntity> selectedAssets = <AssetEntity>[];
  InstaAssetsExportDetails? exportDetails;

  @override
  void dispose() {
    _provider.dispose();
    _instaAssetsPicker.dispose();
    super.dispose();
  }

  Future<void> callRestorablePicker() async {
    final List<AssetEntity>? result =
    await _instaAssetsPicker.restorableAssetsPicker(
      context,
      title: 'Restorable',
      closeOnComplete: true,
      provider: _provider,
      onCompleted: (cropStream) {
        // example withtout StreamBuilder
        cropStream.listen((event) {
          if (mounted) {
            setState(() {
              exportDetails = event;
            });
          }
        });
      },
    );

    if (result != null) {
      selectedAssets = result;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insta picker')),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            const Material(
              color: Colors.deepPurple,
              child: TabBar(
                tabs: [
                  Tab(text: 'Normal picker'),
                  Tab(text: 'Restorable picker'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Center(
                        child: Text(
                          'The picker will push result in a new screen',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      TextButton(
                        onPressed: () => InstaAssetPicker.pickAssets(
                          context,
                          title: 'Select images',
                          maxAssets: 10,
                          onCompleted: (cropStream) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PickerCropResultScreen(
                                    cropStream: cropStream),
                              ),
                            );
                          },
                        ),
                        child: const Text(
                          'Open the Picker',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Center(
                              child: Text(
                                'The picker will restore the picker state.\n'
                                    'The preview, selected album and scroll position will be the same as before pop\n'
                                    'Using this picker means that you must dispose it manually',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            TextButton(
                              onPressed: callRestorablePicker,
                              child: const Text(
                                'Open the Restorable Picker',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // CropResultView(
                      //   selectedAssets: selectedAssets,
                      //   croppedFiles: exportDetails?.croppedFiles ?? [],
                      //   progress: exportDetails?.progress,
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PickerCropResultScreen extends StatelessWidget {
  const PickerCropResultScreen({super.key, required this.cropStream});

  final Stream<InstaAssetsExportDetails> cropStream;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - kToolbarHeight;

    return Scaffold(
      appBar: AppBar(title: const Text('Insta picker result')),
      // body: StreamBuilder<InstaAssetsExportDetails>(
      //   stream: cropStream,
      //   builder: (context, snapshot) => CropResultView(
      //     selectedAssets: snapshot.data?.selectedAssets ?? [],
      //     croppedFiles: snapshot.data?.croppedFiles ?? [],
      //     progress: snapshot.data?.progress,
      //     heightFiles: height / 2,
      //     heightAssets: height / 4,
      //   ),
      // ),
    );
  }
}


















// import 'dart:convert';
// import 'dart:io';
//
// import 'package:firebase__test/Helper/Color.dart';
// import 'package:firebase__test/Helper/Style.dart';
// import 'package:firebase__test/Helper/Utility.dart';
// import 'package:firebase__test/Screen/CameraScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:storage_path/storage_path.dart';
//
// import '../Helper/DropDownWidget.dart';
// import '../Model/DropDownModel.dart';
// import '../Model/FileModel.dart';
// import 'CreatePost.dart';
//
// class MediaPicker extends StatefulWidget {
//   const MediaPicker({Key? key}) : super(key: key);
//
//   @override
//   State<MediaPicker> createState() => _MediaPickerState();
// }
//
// class _MediaPickerState extends State<MediaPicker> {
//   List<FileModel> files = [];
//   FileModel? selectedModel;
//   List<DropDownModal> reasonList = [];
//   String image = '';
//   String reasonSelect = '';
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(milliseconds: 500), () async{
//       await getImagesPath();
//     });
//
//   }
//
//   getImagesPath() async {
//
//     var imagePath = await StoragePath.imagesPath;
//     var images = jsonDecode(imagePath) as List;
//     files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
//     if (files != null && files.length > 0)
//       setState(() {
//         selectedModel = files[0];
//         reasonSelect = files[0].folder;
//         image = files[0].files[0];
//       });
//
//     if(files.isNotEmpty){
//       for(int i = 0 ;i<files.length;i++){
//         reasonList.add(DropDownModal(id: files[i].folder, title: files[i].folder, titleKn: "", status: ""));
//       }
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//
//              Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                   onPressed: (){
//                     if(image.isNotEmpty){
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CreatePost(image: image),
//                         ),
//                       );
//                     }
//                   },
//                   child: Text("Next") ),
//             ),
//             SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.40,
//                 child: image.isNotEmpty
//                     ? Image.file(File(image),
//                     fit: BoxFit.cover,
//                     height: MediaQuery.of(context).size.height * 0.45,
//                     width: MediaQuery.of(context).size.width)
//                     : Container()),
//             Row(
//               children: [
//                 Expanded(
//                   child: DropDownWidget(
//                       lable: 'Select ',
//                       list: reasonList,
//                       selValue: reasonSelect,
//                       selectValue: (value) {
//                         reasonSelect = value;
//                         selectedModel = files.where((element) => element.folder == value).first;
//                         print(value);
//                         setState(() {});
//                       }),
//                 ),
//                 IconButton(onPressed: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraScreen()));
//                 }, icon: const Icon(Icons.camera_alt_outlined))
//               ],
//             ),
//             selectedModel == null
//                 ? Container()
//                 : Expanded(child: GridView.builder(
//                       shrinkWrap: true,
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 4,
//                           crossAxisSpacing: 4,
//                           mainAxisSpacing: 4),
//                       itemBuilder: (_, i) {
//                         var file = selectedModel!.files[i];
//                         return GestureDetector(
//                           child: Image.file(
//                             File(file),
//                             fit: BoxFit.cover,
//                           ),
//                           onTap: () {
//                             setState(() {
//                               image = file;
//                             });
//                           },
//                         );
//                       },
//                       itemCount: selectedModel!.files.length),)
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }