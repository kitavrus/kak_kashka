import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatelessWidget{
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(child: Text("Add new product"),),
      ),
    );
  }
}
