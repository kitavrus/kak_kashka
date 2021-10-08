import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kak_kashka/category/cubit/category_cubit.dart';
import 'package:kak_kashka/category/cubit/category_state.dart';
import 'package:kak_kashka/category/entity/category_entity.dart';
import 'package:kak_kashka/category/repository/category_repository.dart';
import 'package:kak_kashka/category/ui/add_category_page.dart';
import 'package:kak_kashka/category/ui/category_detail_page.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build Category');
    return MultiBlocProvider(providers: [
      BlocProvider<CategoryCubit>(
        create: (context) =>
            CategoryCubit(CategoryRepository())..getCategoryList(),
      ),
    ], child: CategoryPageView());
  }
}

class CategoryPageView extends StatelessWidget {
  const CategoryPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Category'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            print(' Floating action button press');
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddCategoryPage()),
            );
            print('FloatingActionButton: $result');
            if (result != null) {
              BlocProvider.of<CategoryCubit>(context).addCategory(result);
            }
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            var categoryList = <CategoryEntity>[];

            print('BlocBuilder: ');
            print(state.status);
            switch (state.status) {
              case CategoryStatus.initial:
                return _loadingIndicator();
              case CategoryStatus.loading:
                return _loadingIndicator();
              case CategoryStatus.failure:
                return _showError(state.message);

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
                return _showEmpty('NO data');
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
          context.read<CategoryCubit>().searchCategory(text);
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

class CategoryList extends StatelessWidget {
  final List<CategoryEntity> categoryList;

  const CategoryList({Key? key, required this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build: CategoryList ');

    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      // не работает как я хочу (
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        final category = categoryList[index];
        return Slidable(
          key: Key(category.id.toString()),
          actionPane: const SlidableDrawerActionPane(),
          child: CategoryCard(
            categoryModel: category,
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
                  context.read<CategoryCubit>().deleteCategory(category);
                  _showSnackBar(context, 'DELETED: ${category.name}');
                  Navigator.pop(context, 'OK');
                });
              },
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const Divider(),
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

class CategoryCard extends StatelessWidget {
  final CategoryEntity categoryModel;

  const CategoryCard({Key? key, required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Hero(
      //   tag: 'prod-image' + categoryModel.id.toString(),
      //   child: _getImage(categoryModel),
      // ),
      title: Text(categoryModel.name),
      subtitle: Text(categoryModel.description),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        print('onTap: ' + categoryModel.name);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetail(categoryModel: categoryModel),
          ),
        );
      },
    );
  }

// Widget _getImage(CategoryEntity categoryModel) {
//   return SizedBox(
//     child: _imagePathType(categoryModel.pathToImage) == "assets"
//         ? Image.asset(categoryModel.pathToImage)
//         : Image.file(File(categoryModel.pathToImage)),
//     width: 50,
//     height: 50,
//   );
// }

// String _imagePathType(String pathToImage) {
//   String pathToImage = categoryModel.pathToImage;
//   List<String> splitPath = path.split(pathToImage);
//   if (splitPath.first == "assets") {
//     return 'assets';
//   }
//   return 'file';
// }
}
