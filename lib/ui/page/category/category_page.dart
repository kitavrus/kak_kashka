import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin<CategoryPage> {
  @override
  void initState() {
    super.initState();
    print('initState Category');
  }

  @override
  Widget build(BuildContext context) {
    print('build Category');
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: CategorySelector(
        ["Banana", "Pear", "Apple", "Strawberry", "Pineapple"],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


// import 'package:flutter/material.dart';

// void main() {
//   runApp(MultipleCategorySelection());
// }

class MultipleCategorySelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Interactive categories")),
        body: CategorySelector(
          ["Banana", "Pear", "Apple", "Strawberry", "Pineapple"],
        ),
      ),
    );
  }
}

class CategorySelector extends StatefulWidget {
  final List<String> categories;

  CategorySelector(this.categories);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final selectedCategories = <String>[];

  handleChange(String name, bool selected) {
    setState(() {
      if (selected) {
        selectedCategories.add(name);
      } else {
        selectedCategories.remove(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryFilter(
          categories: widget.categories,
          selected: selectedCategories,
          callback: handleChange,
        ),
        Container(
          color: Colors.green,
          height: 2,
        ),
        SelectedCategories(
          categories: selectedCategories,
        )
      ],
    );
  }
}

class CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final List<String> selected;
  final Function(String, bool) callback;
  const CategoryFilter({Key? key, required this.categories, required this.selected, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              value: selected.contains(categories[index]),
              onChanged: (selected) {

                if(selected is bool){
                  callback(categories[index], selected);
                }
              },
              title: Text(categories[index]),
            );
          }),
    );
  }
}

class SelectedCategories extends StatelessWidget {
  final List<String> categories;

  const SelectedCategories({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(categories[index]),
            );
          }),
    );
  }
}
