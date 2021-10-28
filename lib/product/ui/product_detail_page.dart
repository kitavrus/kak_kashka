import 'package:flutter/material.dart';

import '/product/entity/product_entity.dart';

class ProductDetail extends StatelessWidget {
  final ProductEntity productModel;

  const ProductDetail({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: Hero(
                        tag: 'prod-image' + productModel.id.toString(),
                        child: GestureDetector(
                          onTap: () {
                            print('GestureDetector onTap');
                            _displayDialog(context, productModel);
                          },
                          child: Image.asset(
                            productModel.pathToImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // child:
                    ),
                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.5,
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       begin: Alignment.topCenter,
                    //       end: Alignment.bottomCenter,
                    //       stops: [0.0, 0.4],
                    //       colors: [
                    //         Colors.black.withOpacity(0.9),
                    //         Colors.black.withOpacity(0.0),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.46,
                        ),
                        Container(
                          height: 500,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: Colors.white,
                          ),

                          // decoration: ShapeDecoration(
                          //   color: Colors.white,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.only(
                          //       topLeft: Radius.circular(40),
                          //       topRight: Radius.circular(40),
                          //     ),
                          //   ),
                          // ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  productModel.name,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  productModel.description,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _displayDialog(
      BuildContext context, ProductEntity productModel) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(5),
                color: Colors.black45,
                child: Image.asset(
                  productModel.pathToImage,
                  // fit: BoxFit.cover,
                ),
              ),
              GestureDetector(
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
