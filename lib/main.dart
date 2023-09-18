import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(MenuApp());
}

class MenuApp extends StatelessWidget {
  const MenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Menu'),
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/menu.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final menuData = json.decode(snapshot.data.toString());
            final categories = menuData['categories'];
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  title: Text(category['name']),
                  subtitle: Text('${category['items'].length} items'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(category: category),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return CircularProgressIndicator(); // Loading indicator
          }
        },
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final Map<String, dynamic> category;

  CategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    final items = category['items'];
    return Scaffold(
      appBar: AppBar(
        title: Text(category['name']),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text('\$${item['price']}'),
            onTap: () {
              // Handle item press here
              print('Pressed: ${item['name']}');
            },
          );
        },
      ),
    );
  }
}
