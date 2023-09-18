import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu/cart_view.dart';

class CategoryPage extends StatefulWidget {
  final Map<String, dynamic> category;

  CategoryPage({required this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isItemClicked = false;
  List<Map<String, dynamic>> selectedItems = [];
  List<int> selectedItemIndices = [];

  void addItemToCart(Map<String, dynamic> item, int index) {
    setState(() {
      selectedItems.add(item);
      selectedItemIndices.add(index);
    });
  }

  void navigateToCartView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartView(selectedItems: selectedItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryName = widget.category['name'] as String;
    final items = widget.category['items'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final itemName = item['name'] as String;
          final itemPrice = item['price'] as double;
          final isItemSelected = selectedItemIndices.contains(index);

          return ListTile(
            title: Text(itemName),
            subtitle: Text('\$${itemPrice.toStringAsFixed(2)}'),
            onTap: () {
              setState(() {
                isItemClicked = true;
              });
              addItemToCart(item, index);
            },
            tileColor: isItemSelected ? Colors.grey : null,
          );
        },
      ),
      bottomNavigationBar: isItemClicked
          ? BottomAppBar(
              child: ElevatedButton(
                onPressed: navigateToCartView,
                child: Text('Add to Cart'),
              ),
            )
          : null,
    );
  }
}
