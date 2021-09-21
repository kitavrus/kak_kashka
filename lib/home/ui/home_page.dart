import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kak_kashka/category/repository/category_repository.dart';

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

  Future _loadCategory() async {
    return await CategoryRepository().getAll();
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
          Text(
            'Category',
            style: TextStyle(fontSize: 30),
          ),
          CategoryList(_loadCategory()),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CategoryList extends StatelessWidget {
  final categoryModelList;

  CategoryList(this.categoryModelList);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: categoryModelList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      snapshot.data[index].name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            );
          }
          // if (snapshot.hasError) {
          return SizedBox.shrink();
          // }
        });
  }
}
