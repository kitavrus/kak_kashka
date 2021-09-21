import 'package:flutter/material.dart';
import 'package:kak_kashka/category/ui/category_page.dart';
import 'package:kak_kashka/home/ui/home_page.dart';
import 'package:kak_kashka/product/ui/product_page.dart';

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
      theme: ThemeData.light().copyWith(
          // primarySwatch: Colors.blue,
          ),
      darkTheme: ThemeData.dark(),
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
    listPages = [
      HomePage(),
      ProductPage(),
      CategoryPage(),
    ];
    super.initState();
  }

  void _onTap(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPages.elementAt(_tabIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.green[400],
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _tabIndex,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fmd_good_sharp),
            label: "Product",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
          ),
        ],
      ),
    );
  }
}
