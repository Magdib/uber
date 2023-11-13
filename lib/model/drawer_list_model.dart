import 'package:flutter/material.dart';

class DrawerListModel {
  final IconData icon;
  final String text;
  final void Function()? onTap;

  DrawerListModel({required this.icon, required this.text, this.onTap});
}
