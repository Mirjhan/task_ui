import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentController extends GetxController {
  int indexPage = 0;
  PageController pageController = PageController();

  void onTap(int index) {
    pageController.jumpToPage(index);
    indexPage = index;
    update();
  }
}
