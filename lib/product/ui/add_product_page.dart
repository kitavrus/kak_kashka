import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kak_kashka/product/model/product_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class AddProductPage extends StatefulWidget {
  // final ProductModel product;

  AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameEditingController = TextEditingController();

  final TextEditingController _descriptionEditingController =
      TextEditingController();

  final TextEditingController _barcodeEditingController =
      TextEditingController();

  int _radioValue = 0;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value!;
      print(_radioValue);
      // switch (value) {
      //   case 0:
      //     // _result = ...
      // break;
      // case 1:
      // // _result = ...
      // break;
      // case 2:
      // // _result = ...
      // break;
      // }
    });
  }

  // Future<File> moveFile(File sourceFile, String newPath) async {
  //   try {
  //     var basNameWithExtension = path.basename(sourceFile.path);
  //     final newFile = await sourceFile.copy("$newPath/$basNameWithExtension");
  //     return newFile;
  //   } catch (e) {
  //     throw Exception("PIPEC");
  //     /// if rename fails, copy the source file
  //     final newFile = await sourceFile.copy(newPath);
  //     return newFile;
  //   }
  // }

  String appDocPath = '';

  void initPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    appDocPath = appDocDir.path;
  }

  var _image;

  _imageFromCamera() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = File(image.path);

        // File tmp = File(image.path);
        // _image = await tmp.copy(appDocPath+"/_x.jpg");
      });
    }
  }

  _imageFromGallery() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.folder),
                  title: Text("Gallery "),
                  onTap: () {
                    _imageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Camera "),
                  onTap: () {
                    _imageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    initPath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_image);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _showPicker(context);
                      },
                      icon: Icon(Icons.camera_alt),
                    ),
                    Text("Добавить фото товара")
                  ],
                ),
                Container(
                  width: 300,
                  height: 250,
                  child: _image == null ? SizedBox() : Image.file(_image),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // width:250,
                  child: TextField(
                    controller: _nameEditingController,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: "Название ",
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(5),
                      counterText: '',
                    ),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  child: TextField(
                    controller: _descriptionEditingController,
                    maxLines: 5,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: "Описание",
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(5),
                      // counterText: '',
                    ),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  child: TextField(
                    controller: _barcodeEditingController,
                    maxLength: 14,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Штрих-код товара",
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(5),
                      counterText: '',
                    ),
                    onChanged: (value) {},
                  ),
                ),

                Row(children: [
                  Radio(
                    value: 3,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                  Text("покупать"),
                  Radio(
                    value: 2,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                  Text("иногда"),
                  Radio(
                    value: 1,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                  Text("не покупать"),
                ]),

                ElevatedButton(
                  onPressed: () async {
                    // final newImage = await _image.copy(appDocPath+"/");
                    // final newImage =  await _image.copy(appDocPath+"/4491.jpg");
                    //  Future.delayed(Duration(seconds: 1),() async {
                    _image.copy(appDocPath + "/4491.jpg").then((newImage) {
                      //   final newImage =  await _image.copy(appDocPath+"/4491.jpg");
                      //   final newImage =  await _image.copy(appDocPath);
                      //   final newImage =  await _image.copy(appDocPath+"/");

                      // moveFile(_image,appDocPath+"/4491.jpg").then((newImage) {

                      final ProductModel productModel = ProductModel(
                        id: 4,
                        status: _radioValue,
                        name: _nameEditingController.text.toString(),
                        description:
                            _descriptionEditingController.text.toString(),
                        barcode: _barcodeEditingController.text.toString(),
                        pathToImage: newImage == null
                            ? 'assets/images/banan.jpg'
                            : newImage.path,
                        // pathToImage: _image == null ?  'assets/images/banan.jpg' : _image.path,
                        // pathToImage: ,
                      );

                      print(productModel);
                      Navigator.pop(context, productModel);
                    });

                    // });

                    // Navigator.pushReplacementNamed(context,FlyerPage.routeName,arguments: _textEditingController.text);
                    // Navigator.pop(
                    //   context,
                    //   MaterialPageRoute(builder: (context) {
                    //     return CardPage(phoneNumber:_textEditingController.text);
                    //   }),
                    // );
                  },
                  child: Text(
                    "Добавить",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}