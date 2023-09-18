import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:menu/catagory_list_page.dart';

void main() {
  runApp(MenuApp());
}

class MenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Restaurant Menu',
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
            return ListView.separated(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(category['name']),
                      subtitle: Text('${category['items'].length} items'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CategoryPage(category: category),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) =>
                  Divider(), // Add a separator line
            );
          } else {
            return CircularProgressIndicator(); // Loading indicator
          }
        },
      ),
    );
  }
}
