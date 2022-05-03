import 'package:flutter/material.dart';

class ItemsScreen extends StatelessWidget {
  static const routeName = 'items';

  const ItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Items Screen'),
      ),
    );
  }
}
