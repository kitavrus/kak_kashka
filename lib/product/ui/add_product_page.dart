import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '/category/cubit/category_cubit.dart';
import '/category/cubit/category_state.dart';
import '/category/entity/category_entity.dart';
import '/category/repository/category_repository.dart';
import '/common/widgets/show_empty_widget.dart';
import '/common/widgets/show_error_message_widget.dart';
import '/common/widgets/show_loading_indicator_widget.dart';
import '/product/model/product_model.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameEditingController = TextEditingController();

  final TextEditingController _descriptionEditingController =
      TextEditingController();

  final TextEditingController _barcodeEditingController =
      TextEditingController();

  final TextEditingController _selectCategoryEditingController =
      TextEditingController();

  int _radioValue = 0;
  String appDocPath = '';
  var _image;

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
        title: const Text('Edit Product'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _selectPhoto(context),
                _textFields(context),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: double.infinity),
                  child: ElevatedButton(
                    child: const Text(
                      'Добавить',
                    ),
                    onPressed: () async {
                      // final newImage = await _image.copy(appDocPath+"/");
                      // final newImage =  await _image.copy(appDocPath+"/4491.jpg");
                      //  Future.delayed(Duration(seconds: 1),() async {
                      _image.copy(appDocPath + '/4491.jpg').then((newImage) {
                        //   final newImage =  await _image.copy(appDocPath+"/4491.jpg");
                        //   final newImage =  await _image.copy(appDocPath);
                        //   final newImage =  await _image.copy(appDocPath+"/");

                        // moveFile(_image,appDocPath+"/4491.jpg").then((newImage) {

                        final productModel = ProductModel(
                          id: 4,
                          status: _radioValue,
                          name: _nameEditingController.text.toString(),
                          description:
                              _descriptionEditingController.text.toString(),
                          barcode: _barcodeEditingController.text.toString(),
                          pathToImage: newImage == null
                              ? 'assets/images/banan.jpg'
                              : newImage.path,
                        );

                        print(productModel);
                        Navigator.pop(context, productModel);
                      });
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
        const SizedBox(height: 5),
        TextField(
          onTap: () {
            _showScanBarcode();
            print(' Штрих-код товара ');
          },
          readOnly: true,
          controller: _barcodeEditingController,
          // maxLength: 14,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Штрих-код товара',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(5),
            counterText: '',
          ),
          onChanged: (value) {},
        ),
        // Container(
        //   child: TextField(
        //     controller: _barcodeEditingController,
        //     maxLength: 14,
        //     textAlign: TextAlign.start,
        //     keyboardType: TextInputType.phone,
        //     decoration: InputDecoration(
        //       labelText: "Штрих-код товара",
        //       border: OutlineInputBorder(),
        //       contentPadding: const EdgeInsets.all(5),
        //       counterText: '',
        //     ),
        //     onChanged: (value) {},
        //   ),
        // ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(
                value: 3,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              const Text('покупать'),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Radio(
              value: 2,
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange,
            ),
            const Text('иногда'),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Radio(
              value: 1,
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange,
            ),
            const Text('не покупать'),
          ]),
        ]),
        TextField(
          onTap: () {
            _showSelectCategory(context);
            print(' Выбрать категории ');
          },
          readOnly: true,
          controller: _selectCategoryEditingController,
          // maxLength: 14,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Выбрать категории',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(5),
            counterText: '',
          ),
          onChanged: (value) {},
        ),
        // GestureDetector(
        //   onTap: () {
        //       _showSelectCategory(context);
        //       print(" Выбрать категории ");
        //     },
        //   child: Container(
        //     padding: EdgeInsets.only(left: 5),
        //     width: MediaQuery.of(context).size.width,
        //     height: 50,
        //     decoration: ShapeDecoration(
        //       color: Colors.grey[200],
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.all(Radius.circular(10)),
        //       ),
        //     ),
        //     child: Align(
        //         alignment:Alignment.centerLeft,
        //         child: Text("Выбрать категории"),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _selectPhoto(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 250,
        decoration: ShapeDecoration(
          color: Colors.grey[200],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.camera_alt),
                const SizedBox(
                  width: 5,
                ),
                const Text('Добавить фото товара')
              ],
            ),
            _image == null
                ? const SizedBox()
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Image.file(_image))
          ],
        ),
      ),
    );
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value!;
      print(_radioValue);
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

  void initPath() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    appDocPath = appDocDir.path;
  }

  void _imageFromCamera() async {
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

  void _imageFromGallery() async {
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
                leading: const Icon(Icons.folder),
                title: const Text('Gallery '),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera '),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showScanBarcode() async {
    // FlutterBarcodeScanner.getBarcodeStreamReceiver("#ff6666", "Cancel", false, ScanMode.DEFAULT)?.listen((barcode) {
    // final String scanResult = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.DEFAULT);
    // _barcodeEditingController.text = scanResult;

    String scanResult;

    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', false, ScanMode.BARCODE);
      print(_barcodeEditingController.text);
    } on PlatformException {
      scanResult = 'нет возможности отсканировать';
    }

    if (!mounted) return;

    _barcodeEditingController.text = scanResult == '-1' ? '' : scanResult;
  }

  void _showSelectCategory(context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return const SafeArea(
          child: CategoryPage(),
        );
      },
    ).then((value) {
      print(value);
      if (value != null) {
        _selectCategoryEditingController.text = value;
      }
    });
  }
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build Category');
    return MultiBlocProvider(providers: [
      BlocProvider<CategoryCubit>(
        create: (context) =>
            CategoryCubit(CategoryRepository())..getCategoryList(),
      ),
    ], child: const CategoryPageView());
  }
}

class CategoryPageView extends StatelessWidget {
  const CategoryPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          var categoryList = <CategoryEntity>[];

          print('BlocBuilder: ');
          print(state.status);
          switch (state.status) {
            case CategoryStatus.initial:
              return const ShowLoadingIndicatorWidget();
            // case CategoryStatus.loading:
            //   return const ShowLoadingIndicatorWidget();
            case CategoryStatus.failure:
              return ShowErrorMessageWidget(message: state.message);

            case CategoryStatus.success:
              categoryList = state.categoryList;

              return Stack(
                children: [
                  _showSearchBar(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: CategoryList(categoryList: categoryList),
                  ),
                ],
              );
            default:
              return const ShowEmptyWidget(message: 'NO data');
            // return _showEmpty("NO data");
          }
        },
      ),
    );
  }

  Widget _showSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Поиск ...',
          // filled: true,
        ),
        onChanged: (text) {
          context.read<CategoryCubit>().searchCategory(text);
        },
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<CategoryEntity> categoryList;

  const CategoryList({Key? key, required this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build: CategoryList ');

    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        final category = categoryList[index];
        return CategoryCard(
          categoryModel: category,
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryEntity categoryModel;

  const CategoryCard({Key? key, required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(categoryModel.name),
      subtitle: Text(categoryModel.description),
      onTap: () {
        print('onTap: ' + categoryModel.name);
        Navigator.pop(context, categoryModel.name);
      },
    );
  }
}
