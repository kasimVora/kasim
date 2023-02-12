import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';
import 'package:image/image.dart' as imageLib;

import '../main.dart';
import 'PhotoPrev.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  List<Filter> filters = presetFiltersList;
  int camIndex = 0, mode = 0, camMode = 0;
  bool isStart = false;
  double scale = 0.0,max = 0.0,min = 0.0;

  initCamera(CameraDescription camera) {
    controller = CameraController(camera, ResolutionPreset.ultraHigh);
    controller.initialize().then((_) async{
      if (!mounted) {
        return;
      }
       max = await controller.getMaxZoomLevel();
       min = await controller.getMinZoomLevel();
       scale = min;
       print("object");
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initCamera(cameras[camIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: null,
      body: SafeArea(
          child: Column(
        children: [
          if (!controller.value.isInitialized) ...[
            Container()
          ] else ...[
            Stack(
              children: [
                GestureDetector(

                  // onScaleUpdate: (details) async{
                  //   var maxZoomLevel = await controller.getMaxZoomLevel();
                  //   // just calling it dragIntensity for now, you can call it whatever you like.
                  //   var dragIntensity = details.scale;
                  //   if (dragIntensity < 1) {
                  //     // 1 is the minimum zoom level required by the camController's method, hence setting 1 if the user zooms out (less than one is given to details when you zoom-out/pinch-in).
                  //     controller.setZoomLevel(1);
                  //   } else if (dragIntensity > 1 && dragIntensity < maxZoomLevel) {
                  //     // self-explanatory, that if the maxZoomLevel exceeds, you will get an error (greater than one is given to details when you zoom-in/pinch-out).
                  //     controller.setZoomLevel(dragIntensity);
                  //   } else {
                  //     // if it does exceed, you can provide the maxZoomLevel instead of dragIntensity (this block is executed whenever you zoom-in/pinch-out more than the max zoom level).
                  //     controller.setZoomLevel(maxZoomLevel);
                  //   }
                  // },

                  child: CameraPreview(controller),
                ),
                !isStart
                    ? IconButton(
                        onPressed: () {
                          camMode == 0 ? camMode = 1 : camMode = 0;
                          setState(() {});
                        },
                        icon: Icon(camMode != 0
                            ? Icons.camera_alt
                            : Icons.videocam_sharp),
                        color: Colors.white,
                        iconSize: 35,
                      )
                    : const SizedBox(),
                Positioned(
                  bottom: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Slider(thumbColor: Colors.transparent,

                  min: min,
                  max: max,
                  value: scale,
                  onChanged: (value) {
                      setState(() {
                        scale = value;
                        controller.setZoomLevel(scale);
                      });
                  },
                ),
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => toggleFlash(),
                  icon: Icon(mode == 0
                      ? Icons.flash_on
                      : mode == 1
                          ? Icons.flash_auto
                          : Icons.flash_off),
                  color: Colors.white,
                  iconSize: 35,
                ),
                camMode != 0
                    ? isStart
                        ? stopVideoButton()
                        : startVideoButton()
                    : imageButton(),
                IconButton(
                  onPressed: () {
                    toggleCam();
                  },
                  icon: const Icon(Icons.cameraswitch_sharp),
                  color: Colors.white,
                  iconSize: 35,
                ),
              ],
            )
          ]
        ],
      )),
    );
  }

  imageButton() {
    return GestureDetector(
      onTap: () async => await takePic(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              color: Colors.white),
        ),
      ),
    );
  }

  startVideoButton() {
    return GestureDetector(
      onTap: () async => await recordVideo(),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            color: Colors.red),
      ),
    );
  }

  videoButtons() {
    isStart ? stopVideoButton() : startVideoButton();
  }

  stopVideoButton() {
    return GestureDetector(
      onTap: () async => await recordVideo(),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 4),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          color: Colors.white,
        ),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 5),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: Colors.black),
            child: const Icon(
              Icons.square,
              color: Colors.red,
              size: 30,
            )),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  toggleCam() {
    camIndex == 0 ? camIndex = 1 : camIndex = 0;
    initCamera(cameras[camIndex]);
  }

  toggleFlash() {
    mode == 0
        ? mode = 1
        : mode == 1
            ? mode = 2
            : mode = 0;
    if (mode == 0) {
      controller.setFlashMode(FlashMode.always);
    } else if (mode == 1) {
      controller.setFlashMode(FlashMode.auto);
    } else {
      controller.setFlashMode(FlashMode.off);
    }
    setState(() {});
  }

  takePic() async {
    try {
      final image = await controller.takePicture();
      await getImage(image);
    } catch (e) {
      print(e);
    }
  }

  Future getImage(XFile photo) async {
    var image = imageLib.decodeImage(await photo.readAsBytes());
    image = imageLib.copyResize(image!, width: 600);
    Map imagefile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: photo.path.split('/').last,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.cover,
        ),
      ),
    );

    if (imagefile.containsKey('image_filtered')) {
      var imageFile;
      print(imagefile);
      setState(() {
        imageFile = imagefile['image_filtered'];
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoPrev(image: imageFile.path),
        ),
      );
      print(imageFile.path);
    }
  }

  recordVideo() async {
    if (isStart) {
      final file = await controller.stopVideoRecording();
      print(file.path);
      setState(() => isStart = false);
      // final route = MaterialPageRoute(
      //   fullscreenDialog: true,
      //   builder: (_) => VideoPage(filePath: file.path),
      // );
      //Navigator.push(context, route);
    } else {
      await controller.prepareForVideoRecording();
      await controller.startVideoRecording();
      setState(() => isStart = true);
    }
  }
}
