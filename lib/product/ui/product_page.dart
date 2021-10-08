import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kak_kashka/generated/l10n.dart';

import '../../common/widgets/show_error_message_widget.dart';
import '../../common/widgets/show_loading_indicator_widget.dart';
import '../../product/cubit/product_cubit.dart';
import '../../product/cubit/product_state.dart';
import '../../product/entity/product_entity.dart';
import '../../product/repository/product_repository.dart';
import '../../product/ui/add_product_page.dart';
import '../../product/ui/widgets/product_list.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build Product');
    return MultiBlocProvider(providers: [
      BlocProvider<ProductCubit>(
        create: (context) =>
            ProductCubit(ProductRepository())..getProductList(),
      ),
    ], child: const ProductPageView());
  }
}

class ProductPageView extends StatelessWidget {
  const ProductPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            print(' Floating action button press');
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProductPage()),
            );
            print('FloatingActionButton: $result');
            if (result != null) {
              BlocProvider.of<ProductCubit>(context).addProduct(result);
            }
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            var productList = <ProductEntity>[];

            print('BlocBuilder: ');
            print(state.status);
            switch (state.status) {
              case ProductStatus.initial:
                return const ShowLoadingIndicatorWidget();
              case ProductStatus.failure:
                return ShowErrorMessageWidget(message: state.message);

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
                return ShowErrorMessageWidget(message: S.of(context).no_data);
            }
          },
        ),
      ),
    );
  }

  Widget _showSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Поиск ...',
          // filled: true,
        ),
        onChanged: (text) {
          context.read<ProductCubit>().searchProduct(text);
        },
      ),
    );
  }
}
