import 'package:flutter/material.dart';
import 'package:todolist_flutter/theme.dart';

Widget buttonPill(
  VoidCallback ontap, {
  bool icon = true,
  String label = 'Tambah',
  bool disabled = false,
}) {
  return Material(
    color: blueColor,
    borderRadius: BorderRadius.circular(50),
    child: InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: disabled ? null : ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 9.5,
          horizontal: 15,
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: icon
            ? Row(
                children: [
                  Icon(
                    Icons.add,
                    color: whiteColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    label,
                    style: TextStyle(color: whiteColor, fontSize: 20),
                  ),
                ],
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  label,
                  style: TextStyle(color: whiteColor, fontSize: 20),
                ),
              ),
      ),
    ),
  );
}
