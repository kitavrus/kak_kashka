import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kak_kashka/product/model/product_model.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      /// prefer using rename as it is probably faster
      /// if same directory path
      return await sourceFile.rename(newPath);
    } catch (e) {
      /// if rename fails, copy the source file
      final newFile = await sourceFile.copy(newPath);
      return newFile;
    }
  }


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
                  leading: Icon(Icons.photo_library),
                  title: Text("Gallery "),
                  onTap: () {
                    _imageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
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
            // color: DefaultCustomTheme.kWelcomePageBackground,
            // width: double.infinity,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _showPicker(context);
                    // _imageFromCamera();
                    // _imageFromGallery();
                  },
                  icon: Icon(Icons.camera_alt),
                  // label: Text("label"),
                ),
                Container(
                  width: 160,
                  height: 160,
                  child: _image == null ?  SizedBox() : Image.file(_image),
                ),
                Container(
                  // width:250,
                  child: TextField(
                    controller: _nameEditingController,
                    // maxLength: 10,
                    // autofocus: true,
                    textAlign: TextAlign.start,
                    // keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      // prefix: Text("+7 "),
                      // labelText: "Номер телефона",
                      hintText: "Название ",
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(5),
                      counterText: '',
                    ),
                    // inputFormatters:[ PhoneNumberTextInputFormatter()],
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  // width:250,
                  child: TextField(
                    controller: _descriptionEditingController,
                    // maxLength: 10,
                    // autofocus: true,
                    maxLines: 5,
                    textAlign: TextAlign.start,
                    // keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      // prefix: Text("+7 "),
                      // labelText: "Номер телефона",
                      hintText: "Описание",
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(5),
                      // counterText: '',
                    ),
                    // inputFormatters:[ PhoneNumberTextInputFormatter()],
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  // width:250,
                  child: TextField(
                    controller: _barcodeEditingController,
                    maxLength: 14,
                    // autofocus: true,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      // prefix: Text("+7 "),
                      // labelText: "Номер телефона",
                      hintText: "Штрих-код товара",
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(5),
                      counterText: '',
                    ),
                    // inputFormatters:[ PhoneNumberTextInputFormatter()],
                    onChanged: (value) {},
                  ),
                ),
                ElevatedButton(
                  // style: ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.all(
                  //       DefaultCustomTheme.kGiftCapColor),
                  // ),

                  onPressed: () async {

                    // final newImage = await _image.copy(appDocPath+"/");
                    // final newImage =  await _image.copy(appDocPath+"/4491.jpg");

                    final ProductModel productModel = ProductModel(
                      id: 4,
                      status: 4,
                      name: _nameEditingController.text.toString(),
                      description: _descriptionEditingController.text.toString(),
                      barcode: _barcodeEditingController.text.toString(),
                      // pathToImage: newImage == null ?  'assets/images/banan.jpg' : newImage.path,
                      pathToImage: _image == null ?  'assets/images/banan.jpg' : _image.path,
                      // pathToImage: ,
                    );

                    print(productModel);
                    Navigator.pop(context, productModel);
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
