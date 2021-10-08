import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../product/cubit/product_cubit.dart';
import '../../../product/entity/product_entity.dart';
import '../../../product/ui/widgets/product_card.dart';

class ProductList extends StatelessWidget {
  final List<ProductEntity> productList;

  const ProductList({Key? key, required this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build: ProductList ');

    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      // не работает как я хочу (
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return Slidable(
          key: Key(product.id.toString()),
          actionPane: SlidableDrawerActionPane(),
          child: ProductCard(
            productModel: product,
          ),
          secondaryActions: [
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                _showDialog(context, onCancel: () {
                  Navigator.pop(context, 'Cancel');
                }, onOk: () {
                  context.read<ProductCubit>().deleteProduct(product);
                  _showSnackBar(context, 'DELETED: ${product.name}');
                  Navigator.pop(context, 'OK');
                });
              },
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _showDialog(BuildContext context,
      {required VoidCallback? onCancel, required VoidCallback? onOk}) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Удалить товар?'),
        actions: [
          TextButton(
            onPressed: onCancel,
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: onOk,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
