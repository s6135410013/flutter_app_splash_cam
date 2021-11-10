import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Init {
  Init._();
  static final instance = Init._();
  Future initialize() async {
    await Future.delayed(const Duration(seconds: 5));
  }
}

//==========================================================
void main() {
  runApp(const MyApp());
}

//==========================================================
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Minecraft",
      ),
      home: const MyHomePage(),
    );
  }
}

//==========================================================
class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//==========================================================
class _MyHomePageState extends State<MyHomePage> {
  //ตัวแปรเก็บรูปที่เลือกจากกล้องหรือแกลอรี่
  File? selectImage;
  //method เปิดกล้อง
  Future selectImagefromCamera() async {
    //เปิดกล้องเพื่อเลือกรูป
    var img = await ImagePicker().pickImage(source: ImageSource.camera);
    //ตรวจสอบว่าเลือกรูปแล้วหรือยัง ถ้ายังก็ยกเลิก
    if (img == null) {
      return;
    }
    //ในกรณีที่เลือกรูปแล้ว กำหนดให้ค่ากับตัวแปรที่สร้างเอาไว้ข้างบน --> selectImage
    //ทั้งนี้โค้ดนี้จะมีผลต่อการแสดงบนหน้าจอ ต้องโค้ดอยู่ภายใต้คำสั่ง setState
    setState(
      () {
        selectImage = File(img.path);
      },
    );
  }

  //methodเปิดแกลอรี่
  Future selectImagefromGallery() async {
    //เปิดแกลอรี่เพื่อเลือกรูป
    var gallery = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (gallery == null) {
      return;
    }
    setState(
      () {
        selectImage = File(gallery.path);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Splash Cam",
        ),
        centerTitle: true,
        backgroundColor: Colors.red[300],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 60,
              ),
              CircleAvatar(
                backgroundColor: Colors.black87,
                radius: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: selectImage == null
                      ? Image.asset(
                          "assets/images/Poison-Spider-icon.png",
                          width: 100,
                        )
                      : Image.file(
                          File(selectImage!.path),
                          fit: BoxFit.cover,
                          width: 205,
                          height: 205,
                        ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[300],
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 20,
                        right: 20,
                      ),
                    ),
                    onPressed: () {
                      selectImagefromCamera();
                    },
                    icon: Icon(FontAwesomeIcons.camera),
                    label: Text(
                      "Camera",
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[300],
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 20,
                        right: 20,
                      ),
                    ),
                    onPressed: () {
                      selectImagefromGallery();
                    },
                    icon: Icon(FontAwesomeIcons.images),
                    label: Text(
                      "Gallery",
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
