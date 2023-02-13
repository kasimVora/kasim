import 'dart:io';
import 'package:image/image.dart' as imageLib;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';

class CreatePost extends StatefulWidget {
  String image;
   CreatePost({Key? key,required this.image}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  List<Filter> filters = presetFiltersList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: null,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(20), // Image radius
                    child:  Image.file(File(widget.image),fit: BoxFit.fill),
                  ),
                ),
                Expanded(
                    child: TextFormField(

                    )
                ),
                SizedBox(width: 10,),
                SizedBox(
                  height: 70,
                  child: Image.file(
                    File(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10,)
              ],
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
