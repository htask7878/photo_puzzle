// import 'dart:convert';
import 'dart:io';

// import 'dart:ui' as ui;
// import 'dart:typed_data';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  String dr_path = "";
  XFile? img;
  ImagePicker imagePicker = ImagePicker();
  bool b = false;

  folder() async {
    var path = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS) +
        "/photo";
    Directory dr = Directory(path);

    if (await dr.exists()) {
      print("Already create");
    } else {
      dr.create();
    }
    dr_path = dr.path;
  }

  @override
  void initState() {
    super.initState();
    folder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              onPressed: () async {
                img = await imagePicker.pickImage(source: ImageSource.gallery);

                setState(() {
                  b = true;
                });
                print("Gallery");
              },
              child: Text("Gallery")),
          ElevatedButton(
              onPressed: () async {
                img = await imagePicker.pickImage(source: ImageSource.camera);

                setState(() {
                  b = true;
                });
                print("camera");
              },
              child: Text("Camera")),
          ElevatedButton(
              onPressed: () async {
                DateTime datetime = DateTime.now();
                String setin =
                    "${datetime.year.toString() + datetime.month.toString() + datetime.day.toString() + datetime.hour.toString() + datetime.minute.toString() + datetime.second.toString() + datetime.microsecond.toString()}";
                String image1 = "${dr_path}/${setin}.jpg";
                File Createfile = File(image1);

                if (!await Createfile.exists()) {
                  await Createfile.create();
                  await Createfile.writeAsBytes(await img!.readAsBytes());
                }
              },
              child: Text("store photo")),
          Center(
              child: b
                  ? Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(img!.path)),
                            fit: BoxFit.fill),
                      ))
                  : ColoredBox(color: Colors.amber)),
        ],
      ),
    );
  }
}
