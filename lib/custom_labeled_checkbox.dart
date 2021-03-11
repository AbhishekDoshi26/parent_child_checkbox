import 'package:flutter/material.dart';

enum CheckboxType {
  Parent,
  Child,
}

@immutable
class CustomLabeledCheckbox extends StatefulWidget {
  const CustomLabeledCheckbox({
    @required this.label,
    @required this.value,
    @required this.onChanged,
    this.checkboxType: CheckboxType.Child,
    this.activeColor,
  })  : assert(label != null),
        assert(checkboxType != null),
        assert(
          (checkboxType == CheckboxType.Child && value != null) ||
              checkboxType == CheckboxType.Parent,
        ),
        tristate = checkboxType == CheckboxType.Parent ? true : false;

  final String label;
  final bool value;
  final bool tristate;
  final ValueChanged<bool> onChanged;
  final CheckboxType checkboxType;
  final Color activeColor;

  @override
  _CustomLabeledCheckboxState createState() => _CustomLabeledCheckboxState();
}

class _CustomLabeledCheckboxState extends State<CustomLabeledCheckbox> {
  void _onChanged() {
    if (widget.value != null) {
      widget.onChanged(!widget.value);
    } else {
      widget.onChanged(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return InkWell(
      onTap: _onChanged,
      child: Padding(
        padding: EdgeInsets.only(left: 12, right: 16),
        child: Row(
          children: <Widget>[
            widget.checkboxType == CheckboxType.Parent
                ? SizedBox(width: 0)
                : SizedBox(width: 32),
            Checkbox(
              tristate: widget.tristate,
              value: widget.value,
              onChanged: (_) {
                _onChanged();
              },
              activeColor:
                  widget.activeColor ?? themeData.toggleableActiveColor,
            ),
            SizedBox(width: 8),
            Text(
              widget.label,
              style: themeData.textTheme.subtitle1,
            )
          ],
        ),
      ),
    );
  }
}
