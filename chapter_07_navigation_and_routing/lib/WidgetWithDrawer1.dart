import 'package:flutter/material.dart';
import 'MyDrawer.dart';

class WidgetWithDrawer1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Navigation'),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Container(
            child: Text(
          "I'm widget 1",
          style: Theme.of(context).textTheme.display1,
        )),
      ),
    );
  }
}
