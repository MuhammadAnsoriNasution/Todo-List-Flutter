import 'package:flutter/material.dart';
import 'package:todolist_flutter/data.dart';
import 'package:todolist_flutter/theme.dart';

Widget listItemForm({TextEditingController? controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "NAMA LIST ITEM",
        style: labelFormDialog,
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: white100Color,
            width: 1,
          ),
        ),
        child: TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 14),
        ),
      )
    ],
  );
}

Widget priorityForm({Color? value, required Function onChanged}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("PRIORITY", style: labelFormDialog),
      const SizedBox(
        height: 10,
      ),
      Container(
        padding: const EdgeInsets.only(left: 16, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: white100Color,
            width: 1,
          ),
        ),
        child: DropdownButton<Color>(
          isExpanded: true,
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down),
          elevation: 16,
          style: TextStyle(color: blackColor),
          underline: const SizedBox(),
          onChanged: (Color? newValue) => onChanged(newValue),
          // (String? newValue) {
          //   setState(() {
          //     dropdownValue = newValue!;
          //   });
          // },
          items: listPriority.map((value) {
            return DropdownMenuItem<Color>(
              value: value['color'],
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: white100Color,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: value['color'],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(value['label'])
                  ],
                ),
              ),
            );
          }).toList(),
          hint: const Text(
            "Pilih Priority",
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.end,
          ),
        ),
      )
    ],
  );
}
