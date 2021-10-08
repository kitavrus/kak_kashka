import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../category/repository/category_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  void initState() {
    super.initState();
    print('initState Home');
  }

  @override
  Widget build(BuildContext context) {
    print('build Home');
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Category',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CategoryList(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  Future _loadCategory() async {
    return await CategoryRepository().getAll();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadCategory(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final category = snapshot.data;
            return SizedBox(
              height: 25,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (context, index) =>
                      _buildItem(category[index], index)),
            );
          }
          // if (snapshot.hasError) {
          return SizedBox.shrink();
          // }
        });
  }

  Widget _buildItem(category, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          category.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight:
                selectedIndex == index ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
