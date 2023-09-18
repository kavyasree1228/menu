import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;

  CartView({required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected items'),
      ),
      body: ListView.builder(
        itemCount: selectedItems.length,
        itemBuilder: (context, index) {
          final item = selectedItems[index];
          final itemName = item['name'] as String;
          final itemPrice = item['price'] as double;

          return ListTile(
            title: Text(itemName),
            subtitle: Text('\$${itemPrice.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
