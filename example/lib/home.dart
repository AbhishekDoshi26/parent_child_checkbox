import 'package:flutter/material.dart';
import 'package:parent_child_checkbox/parent_child_checkbox.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String parentName = 'Flutter Channels';
  List<String> children = ['Stable', 'Master', 'Beta', 'Dev'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Child Checkbox'),
      ),
      body: Center(
        child: ParentChildCheckboxes(
          parentName: parentName,
          children: children,
        ),
      ),
    );
  }
}
