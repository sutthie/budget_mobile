import 'package:flutter/material.dart';

class SJDropdownYear extends StatelessWidget {
  final List<int> items;
  final String value;
  final ValueChanged<String> onChanged;

  const SJDropdownYear({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ddlYearNew = DropdownButton(
      value: value,
      items: items.map((int item) {
        return DropdownMenuItem<int>(
          child: Text('$item'),
          value: item,
        );
      }).toList(),
      //onChanged: onChanged,
      onChanged: (value) {},
      //hint: Text("เลือกปีงบประมาณ"),
      disabledHint: Text("Disabled"),
      elevation: 8,
      style: TextStyle(color: Colors.green, fontSize: 16),
      icon: Icon(Icons.arrow_drop_down_circle),
      iconDisabledColor: Colors.red,
      iconEnabledColor: Colors.blue,
      iconSize: 27,
    );

    return Container(
      margin: EdgeInsets.all(3),
      width: 75,
      height: 33,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        //border: Border.all(width: 2),
      ),
      child: Center(
        // Center the DropdownButton horizontally
        child: ddlYearNew,
      ),
    );
  }
}
