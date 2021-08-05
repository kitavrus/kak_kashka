import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kak_kashka/product/cubit/product_cubit.dart';
import 'package:kak_kashka/product/cubit/product_state.dart';
import 'package:kak_kashka/product/entity/product_entity.dart';
import 'package:kak_kashka/product/model/product_model.dart';
import 'package:kak_kashka/product/repository/product_repository.dart';
import 'package:kak_kashka/product/ui/product_detail_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class AddProductPage extends StatefulWidget {
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

  final TextEditingController _selectCategoryEditingController = TextEditingController();

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
        title: Text('Edit Product'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                _selectPhoto(context),
                _textFields(context),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: double.infinity),
                  child: ElevatedButton(
                    child: Text(
                      "Добавить",
                    ),
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

  Container _textFields(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            // width:250,
            child: TextField(
              controller: _nameEditingController,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                labelText: "Название ",
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
                labelText: "Описание",
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
                labelText: "Штрих-код товара",
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(5),
                counterText: '',
              ),
              onChanged: (value) {},
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: 3,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                Text("покупать"),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Radio(
                value: 2,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              Text("иногда"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Radio(
                value: 1,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              Text("не покупать"),
            ]),
          ]),
          Container(
            child: TextField(
              onTap: () {
                _showSelectCategory(context);
                print(" Выбрать категории ");
              },
              readOnly: true,
              controller: _selectCategoryEditingController,
              // maxLength: 14,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Выбрать категории",
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(5),
                counterText: '',
              ),
              onChanged: (value) {},
            ),
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
      ),
    );
  }

  Widget _selectPhoto(BuildContext context) {
    return GestureDetector(
      onTap: () {_showPicker(context); },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 250,
        decoration: ShapeDecoration(
          color: Colors.grey[200],
          shape: RoundedRectangleBorder(
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
                Icon(Icons.camera_alt),
                SizedBox(width: 5,),
                Text("Добавить фото товара")
              ],
            ),
            _image == null
                ? SizedBox()
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
    Directory appDocDir = await getApplicationDocumentsDirectory();
    appDocPath = appDocDir.path;
  }

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
      },
    );
  }

  void _showSelectCategory(context)  {
   // Future answer = showModalBottomSheet(
   showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SafeArea(
          child: ProductCategoryPage(),
        );
      },
    ).then((value) {
        print(value);
       if(value != null) {
         _selectCategoryEditingController.text = value;
       }
     });
     // answer.then((value) {
     //   // print(value);
     //   if(value != null) {
     //     _selectCategoryEditingController.text = value;
     //   }
     // },
     // );


   }

}

class ProductCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Product');
    return MultiBlocProvider(providers: [
      BlocProvider<ProductCubit>(
        create: (context) =>
        ProductCubit(ProductRepository())..getProductList(),
      ),
    ], child: ProductPageView());
  }
}

class ProductPageView extends StatelessWidget {
  const ProductPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        List<ProductEntity> productList = [];

        print("BlocBuilder: ");
        print(state.status);
        switch (state.status) {
          case ProductStatus.initial:
            return _loadingIndicator();
          case ProductStatus.loading:
            return _loadingIndicator();
          case ProductStatus.failure:
            return _showError(state.message);

          case ProductStatus.success:
            productList = state.productList;

            return Stack(
              children: [
                _showSearchBar(context),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: ProductList(productList: productList),
                ),
              ],
            );
          default:
            return _showEmpty("NO data");
        }
      },
    );
  }

  Widget _showSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Поиск ...",
          // filled: true,
        ),
        onChanged: (text) {
          context.read<ProductCubit>().searchProduct(text);
        },
      ),
    );
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _showError(message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          message,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
    );
  }

  Widget _showEmpty(message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          message,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<ProductEntity> productList;

  const ProductList({Key? key, required this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build: ProductList ");

    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return ProductCard(
          productModel: product,
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductEntity productModel;

  const ProductCard({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, _colorByStatus(productModel)],
          )),
      child: ListTile(
        leading: _getImage(productModel),
        title: Text(productModel.name),
        subtitle: Text(productModel.description),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          print("onTap: " + productModel.name);
          Navigator.pop(context,productModel.name);
          // Navigator.pop(context,productModel.id);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ProductDetail(productModel: productModel),
          //   ),
          // );
        },
      ),
    );
  }

  Color _colorByStatus(ProductEntity productModel) {
    final _color;

    switch (productModel.status) {
      case 0:
        _color = Colors.white;
        break;
      case 1:
        _color = Colors.red[200];
        break;
      case 2:
        _color = Colors.yellow[200];
        break;
      case 3:
        _color = Colors.green[200];
        break;
      default:
        _color = Colors.white;
    }
    return _color;
  }

  Widget _getImage(ProductEntity productModel) {
    return SizedBox(
      child: _imagePathType(productModel.pathToImage) == "assets"
          ? Image.asset(productModel.pathToImage)
          : Image.file(File(productModel.pathToImage)),
      width: 50,
      height: 50,
    );
  }

  String _imagePathType(String pathToImage) {
    String pathToImage = productModel.pathToImage;
    List<String> splitPath = path.split(pathToImage);
    if (splitPath.first == "assets") {
      return 'assets';
    }
    return 'file';
  }
}
