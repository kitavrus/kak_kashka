import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart';
import '../../category/model/category_model.dart';
import '../../generated/l10n.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController _nameEditingController = TextEditingController();

  final TextEditingController _descriptionEditingController =
      TextEditingController();

  // final TextEditingController _barcodeEditingController =
  //     TextEditingController();

  // int _radioValue = 0;
  // String appDocPath = '';
  // var _image;

  @override
  void initState() {
    initPath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(_image);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Category'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // _selectPhoto(context),
                _textFields(context),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: double.infinity),
                  child: ElevatedButton(
                    child: Text(
                      S.of(context).button_add,
                      // 'Добавить',
                    ),
                    onPressed: () async {
                      // final newImage = await _image.copy(appDocPath+"/");
                      // final newImage =  await _image.copy(appDocPath+"/4491.jpg");
                      //  Future.delayed(Duration(seconds: 1),() async {
                      // _image.copy(appDocPath + "/4491.jpg").then((newImage) {
                      //   final newImage =  await _image.copy(appDocPath+"/4491.jpg");
                      //   final newImage =  await _image.copy(appDocPath);
                      //   final newImage =  await _image.copy(appDocPath+"/");

                      // moveFile(_image,appDocPath+"/4491.jpg").then((newImage) {

                      final categoryModel = CategoryModel(
                        id: 4,
                        status: 1,
                        name: _nameEditingController.text.toString(),
                        description:
                            _descriptionEditingController.text.toString(),
                        pathToImage: 'assets/images/banan.jpg',
                      );

                      print(categoryModel);
                      Navigator.pop(context, categoryModel);
                      // });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFields(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _nameEditingController,
          textAlign: TextAlign.start,
          decoration: const InputDecoration(
            labelText: 'Название ',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(5),
            counterText: '',
          ),
          onChanged: (value) {},
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _descriptionEditingController,
          maxLines: 5,
          textAlign: TextAlign.start,
          decoration: const InputDecoration(
            labelText: 'Описание',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(5),
            // counterText: '',
          ),
          onChanged: (value) {},
        ),
      ],
    );
  }

  // Widget _selectPhoto(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {_showPicker(context); },
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       height: 250,
  //       decoration: ShapeDecoration(
  //         color: Colors.grey[200],
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(10)),
  //         ),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Icon(Icons.camera_alt),
  //               SizedBox(width: 5,),
  //               Text("Добавить фото товара")
  //             ],
  //           ),
  //           _image == null
  //               ? SizedBox()
  //               : SizedBox(
  //                   width: MediaQuery.of(context).size.width,
  //                   height: 200,
  //                   child: Image.file(_image))
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // void _handleRadioValueChange(int? value) {
  //   setState(() {
  //     _radioValue = value!;
  //     print(_radioValue);
  //   });
  // }

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

  void initPath() async {
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // appDocPath = appDocDir.path;
  }

// _imageFromCamera() async {
//   final image = await ImagePicker()
//       .getImage(source: ImageSource.camera, imageQuality: 50);
//
//   if (image != null) {
//     setState(() {
//       _image = File(image.path);
//
//       // File tmp = File(image.path);
//       // _image = await tmp.copy(appDocPath+"/_x.jpg");
//     });
//   }
// }

// _imageFromGallery() async {
//   final image = await ImagePicker()
//       .getImage(source: ImageSource.gallery, imageQuality: 50);
//   if (image != null) {
//     setState(() {
//       _image = File(image.path);
//     });
//   }
// }

// void _showPicker(context) {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return SafeArea(
//         child: Wrap(
//           children: [
//             ListTile(
//               leading: Icon(Icons.folder),
//               title: Text("Gallery "),
//               onTap: () {
//                 _imageFromGallery();
//                 Navigator.of(context).pop();
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.camera_alt),
//               title: Text("Camera "),
//               onTap: () {
//                 _imageFromCamera();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
}
