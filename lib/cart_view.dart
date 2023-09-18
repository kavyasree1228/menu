import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;

  CartView({required this.selectedItems});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool orderPlaced = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedItems.isNotEmpty) {
      // If there are selected items, automatically place the order after 15 seconds.
      Future.delayed(Duration(seconds: 15), () {
        if (!orderPlaced) {
          // Simulate an order placement process here.
          setState(() {
            orderPlaced = true;
          });

          // Simulate a delay for the order placement.
          Future.delayed(Duration(seconds: 2), () {
            // Reset the order placement status after a while.
            setState(() {
              orderPlaced = false;
            });

            // Navigate back to the main menu.
            Navigator.of(context).pop();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected items'),
      ),
      body: orderPlaced
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    height: 50,
                    alignment: Alignment.center,
                    color: Colors.green,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Your order has been placed. Please be seated\nand wait while we prepare the food.',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate back to the main menu.
                      Navigator.of(context).pop();
                    },
                    child: Text('Go Back to Main Menu'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: widget.selectedItems.length,
              itemBuilder: (context, index) {
                final item = widget.selectedItems[index];
                final itemName = item['name'] as String;
                final itemPrice = item['price'] as double;

                return ListTile(
                  title: Text(itemName),
                  subtitle: Text('\$${itemPrice.toStringAsFixed(2)}'),
                );
              },
            ),
      floatingActionButton: !orderPlaced
          ? FloatingActionButton.extended(
              onPressed: () {
                // Simulate an order placement process.
                setState(() {
                  orderPlaced = true;
                });

                // Simulate a delay for the order placement.
                Future.delayed(Duration(seconds: 15), () {
                  // Reset the order placement status after a while.
                  setState(() {
                    orderPlaced = false;
                  });

                  // Navigate back to the main menu.
                  Navigator.of(context).pop();
                });
              },
              label: Text('Place Order'),
              icon: Icon(Icons.shopping_cart),
            )
          : null,
    );
  }
}
