library parent_child_checkbox;

import 'package:flutter/material.dart';
import 'custom_labeled_checkbox.dart';

class ParentChildCheckboxes extends StatefulWidget {
  ///List of children checkboxes
  final List<String>? children;

  ///Name or Label of the Parent Checkbox
  final String? parentName;

  ///Parent Active Color
  final Color parentActiveColor;

  ///Child Active Color
  final Color childActiveColor;
  ParentChildCheckboxes({
    this.children,
    this.parentName,
    this.parentActiveColor = Colors.blue,
    this.childActiveColor = Colors.blueAccent,
  });
  @override
  _ParentChildCheckboxesState createState() => _ParentChildCheckboxesState();
}

class _ParentChildCheckboxesState extends State<ParentChildCheckboxes> {
  ///Children Value
  late List<bool> _childrenValue;

  ///Parent Value
  bool? _parentValue;

  ///Manages the tristate of the checkbox
  void _manageTristate(int index, bool value) {
    setState(() {
      // selected
      _childrenValue[index] = value;
      // Checking if all other children are also selected -
      if (_childrenValue.contains(!value)) {
        // No. Parent -> tristate.
        _parentValue = null;
      } else {
        // Yes. Select all.
        setState(() {
          _parentValue = value;
          _checkAll(value);
        });
      }
    });
  }

  //Selects or deselects all depending on the value
  void _checkAll(bool value) {
    setState(() {
      _parentValue = value;
      for (int i = 0; i < widget.children!.length; i++) {
        _childrenValue[i] = value;
      }
    });
  }

  @override
  void initState() {
    _parentValue = false;
    _childrenValue = List.generate(widget.children!.length, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomLabeledCheckbox(
          label: widget.parentName!,
          value: _parentValue,
          onChanged: (value) {
            if (value != null) {
              _checkAll(value);
            } else {
              _checkAll(true);
            }
          },
          checkboxType: CheckboxType.Parent,
          activeColor: widget.parentActiveColor,
        ),
        ListView.builder(
          itemCount: widget.children!.length,
          itemBuilder: (context, index) => CustomLabeledCheckbox(
            label: widget.children![index],
            value: _childrenValue[index],
            onChanged: (value) {
              _manageTristate(index, value!);
            },
            checkboxType: CheckboxType.Child,
            activeColor: widget.childActiveColor,
          ),
          shrinkWrap: true,
        ),
      ],
    );
  }
}
