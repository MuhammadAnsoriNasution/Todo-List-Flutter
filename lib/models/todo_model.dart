import 'package:flutter/material.dart';

class TodoModel {
  late int id;
  late int idActivity;
  late String title;
  late DateTime tanggal;
  late Color color;
  late bool done;

  TodoModel({
    required this.id,
    required this.title,
    required this.tanggal,
    required this.idActivity,
    required this.color,
    this.done = false,
  });
}
