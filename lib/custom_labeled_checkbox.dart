import 'package:flutter/material.dart';

///Enum for detecting checkbox-type
enum CheckboxType {
  Parent,
  Child,
}

@immutable
class CustomLabeledCheckbox extends StatelessWidget {
  const CustomLabeledCheckbox({
    required this.label,
    required this.value,
    required this.onChanged,
    this.checkboxType: CheckboxType.Child,
    this.activeColor,
  })  : assert(
          (checkboxType == CheckboxType.Child && value != null) ||
              checkboxType == CheckboxType.Parent,
        ),
        tristate = checkboxType == CheckboxType.Parent ? true : false;

  ///Label for a particular checkbox
  final String label;

  ///Value of that checkbox
  final bool? value;

  ///Determines if we have to manage tristate of the checkbox
  final bool tristate;

  ///Boolean function that performs the onChanged
  final ValueChanged<bool?> onChanged;

  ///Type of the Checkbox, whether it is Parent or Children
  final CheckboxType checkboxType;

  ///Color when the checkbox is ticked
  final Color? activeColor;

  void _onChanged() {
    if (value != null) {
      onChanged(!value!);
    } else {
      onChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: _onChanged,
      child: Padding(
        padding: EdgeInsets.only(left: 12, right: 16),
        child: Row(
          children: <Widget>[
            checkboxType == CheckboxType.Parent
                ? SizedBox(width: 0)
                : SizedBox(width: 32),
            Checkbox(
              tristate: tristate,
              value: value,
              onChanged: (_) {
                _onChanged();
              },
              activeColor: activeColor ?? themeData.toggleableActiveColor,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: themeData.textTheme.subtitle1,
            )
          ],
        ),
      ),
    );
  }
}
