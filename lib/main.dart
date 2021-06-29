import 'package:flutter/material.dart';
import 'package:kak_kashka/repository/product_repository.dart';
import 'package:kak_kashka/ui/page/category/category_page.dart';
import 'package:kak_kashka/ui/page/home/home_page.dart';
import 'package:kak_kashka/ui/page/product/product_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Как кашка?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabBottomContainer(),
    );
  }
}
class TabBottomContainer extends StatefulWidget {
  const TabBottomContainer({Key? key}) : super(key: key);

  @override
  _TabBottomContainerState createState() => _TabBottomContainerState();
}

class _TabBottomContainerState extends State<TabBottomContainer> {
  int _tabIndex = 0;
  List<Widget> listPages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listPages = [
      HomePage(),
      ProductPage(),
      CategoryPage(),
      // Container(child: Text("Home"),),
      // Container(child: Text("Product"),),
      // Container(child: Text("Category"),),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPages[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.green[400],
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _tabIndex,
        onTap: (int index) {
          setState(() {
            _tabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home", ),
          BottomNavigationBarItem(icon: Icon(Icons.fmd_good_sharp),label:"Product",),
          BottomNavigationBarItem(icon: Icon(Icons.category),label:"Category",),
        ],
      ),
    );
  }
}
