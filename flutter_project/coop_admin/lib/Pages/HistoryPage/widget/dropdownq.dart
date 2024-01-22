import 'package:flutter/material.dart';

class DropdownWidgetQ extends StatefulWidget {
  final List<dynamic> items;
  final Function onChanged;
  final String hint;
  final dynamic value;
  final List<dynamic>? customItems;

  DropdownWidgetQ({
    required this.items,
    required this.onChanged,
    required this.hint,
    required this.value,
    required this.customItems,
  });

  @override
  _DropdownWidgetQState createState() => _DropdownWidgetQState();
}

class _DropdownWidgetQState extends State<DropdownWidgetQ> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(),
        color: Colors.black,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: Icon(Icons.arrow_drop_down_circle,
              color: Colors.grey.withOpacity(0.7)),
          items: (widget.customItems ?? widget.items)
              .map<DropdownMenuItem<String>>(
            (dynamic value) {
              return DropdownMenuItem<String>(
                child: Text(
                  value.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: value.toString(),
              );
            },
          ).toList(),
          onChanged: (value) {
            widget.onChanged(value);
          },
          hint: Text(
            widget.hint,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: widget.value?.toString() ?? null,
        ),
      ),
    );
  }
}
