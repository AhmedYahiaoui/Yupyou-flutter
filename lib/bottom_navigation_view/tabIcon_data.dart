import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/images/navbar/house.png',
      selectedImagePath: 'assets/images/navbar/home.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/navbar/route.png',
      selectedImagePath: 'assets/images/navbar/route_1.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/navbar/heart1.png',
      selectedImagePath: 'assets/images/navbar/heart.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/navbar/businessman.png',
      selectedImagePath: 'assets/images/navbar/businessman_1.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
