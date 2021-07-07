import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kak_kashka/product/model/product_model.dart';

class AddProductPage extends StatelessWidget {
   // final ProductModel product;

   AddProductPage({Key? key}) : super(key: key);


  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController = TextEditingController();
  final TextEditingController _barcodeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          // color: DefaultCustomTheme.kWelcomePageBackground,
          // width: double.infinity,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

                onPressed: () {
                    final ProductModel productModel = ProductModel(
                        id: 4,
                        status: 4,
                        name: _nameEditingController.text.toString(),
                        description: _descriptionEditingController.text.toString(),
                        barcode: _barcodeEditingController.text.toString(),
                        pathToImage: 'assets/images/banan.jpg',
                    );

                    print(productModel);
                    Navigator.pop(context,productModel);
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
    );
  }
}
