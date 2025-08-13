import 'package:flutter/material.dart';
import 'package:tasks/src/ui/core/colors.dart';

PreferredSizeWidget appBarWidget({
  required String titulo,
  bool hasArrow = true,
}) =>
    AppBar(
      title: Text(
        titulo,
        style: TextStyle(color: darkPrimaryColor),
      ),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 209, 238, 244),
      automaticallyImplyLeading: hasArrow,
    );
