import 'package:flutter/material.dart';
import 'package:todolist_flutter/theme.dart';

List<Map<String, dynamic>> dataSort = [
  {
    'icon': Icon(
      Icons.sort,
      color: blueColor,
    ),
    'label': 'Terbaru',
  },
  {
    'icon': Icon(
      Icons.tram_sharp,
      color: blueColor,
    ),
    'label': 'Terlama',
  },
  {
    'icon': Icon(
      Icons.system_security_update_warning,
      color: blueColor,
    ),
    'label': 'A-Z',
  },
  {
    'icon': Icon(
      Icons.airline_seat_legroom_normal_rounded,
      color: blueColor,
    ),
    'label': 'Z-A',
  },
  {
    'icon': Icon(
      Icons.qr_code,
      color: blueColor,
    ),
    'label': 'Belum Selesai',
  },
];

List<Map<String, dynamic>> listPriority = [
  {
    'label': 'Very High',
    'color': dangerColor,
    'active': false,
    'value': 'very-high'
  },
  {'label': 'High', 'color': yellowColor, 'active': false, 'value': 'high'},
  {'label': 'Medium', 'color': greenColor, 'active': false, 'value': 'normal'},
  {'label': 'Low', 'color': blueColor, 'active': false, 'value': 'low'},
  {'label': 'Very Low', 'color': acColor, 'active': false, 'value': 'very-low'},
];
