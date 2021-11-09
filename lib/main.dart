import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '/category/ui/category_page.dart';
import '/home/ui/home_page.dart';
import '/product/ui/product_page.dart';
import 'app_dependencies.dart';
import 'generated/l10n.dart';

void main() {
  runApp(
    const AppDependencies(app: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      // title: 'Want is eat?', //S.of(context).main_app_bar_title, (так не работает не может найти S)
      onGenerateTitle: (context) => S.of(context).main_app_bar_title,
      theme: ThemeData.light().copyWith(
          // primarySwatch: Colors.blue,
          ),
      darkTheme: ThemeData.dark(),
      home: const TabBottomContainer(),
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
      const HomePage(),
      const ProductPage(),
      const CategoryPage(),
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
            icon: const Icon(Icons.home),
            label: S.of(context).bottom_navigation_bar_item_label_home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.fmd_good_sharp),
            label: S.of(context).bottom_navigation_bar_item_label_goods,
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.category),
              label: S.of(context).bottom_navigation_bar_item_label_categories),
        ],
      ),
    );
  }
}
