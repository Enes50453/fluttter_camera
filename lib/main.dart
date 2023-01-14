import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  double get height => MediaQuery.of(context).size.height;
  File? image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar,
      body: buildBody,
      floatingActionButton: buildFloatingActionButtons,
    );
  }

  AppBar get buildAppBar => AppBar(title: Text('Image Picker Example'));

  Center get buildBody {
    return Center(
      child: image == null ? Text('Fotoğraf seçilmedi.') : Image.file(image!),
    );
  }

  Widget get buildFloatingActionButtons {
    return Column(
      children: [
        Spacer(),
        buildAppIconButtonNewPhoto,
        SizedBox(height: height * 0.01),
        buildAppIconButtonPickImageFromGallery,
      ],
    );
  }

  FloatingActionButton get buildAppIconButtonNewPhoto {
    return FloatingActionButton.extended(
      label: Text("Fotoğraf Çek"),
      icon: Icon(Icons.photo_camera),
      onPressed: () => onImageButtonPressed(ImageSource.camera),
    );
  }

  FloatingActionButton get buildAppIconButtonPickImageFromGallery {
    return FloatingActionButton.extended(
      label: Text("Galeriden Seç"),
      icon: Icon(Icons.photo_library),
      onPressed: () => onImageButtonPressed(ImageSource.gallery),
    );
  }

  /////////////////////////////////////
  ///
  onImageButtonPressed(ImageSource source) async {
    try {
      await getImage(source);
    } catch (e) {
      print(e);
    }
  }

  Future getImage(ImageSource source) async {
    final PickedFile = await picker.pickImage(source: source);
    setState(() {
      image = File(PickedFile!.path);
    });
  }

  ///
  //////////////////////////////////////////
}
