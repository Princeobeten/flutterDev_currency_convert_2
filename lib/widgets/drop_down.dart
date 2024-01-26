import 'package:flutter/material.dart';

Widget customDropDown(List<String> items, String value, void Function(String) onChange) {
  // Remove duplicates from the list
  List<String> uniqueItems = items.toSet().toList();

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButton<String>(
      value: value,
      onChanged: (val) {
        onChange(val!); // Use val here instead of the incorrect variable "val"
      },
      items: uniqueItems.map<DropdownMenuItem<String>>((String val) {
        return DropdownMenuItem(
          value: val,
          child: Text(val),
        );
      }).toList(),
    ),
  );
}
