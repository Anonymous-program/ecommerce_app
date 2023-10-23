import 'package:ecommerce_app/pages/new_product_page.dart';
import 'package:flutter/material.dart';

import '../pages/category_page.dart';
import '../pages/view_product_page.dart';

class DashBoardItem {
  final IconData icon;
  final String name;
  final String route;

  DashBoardItem({
    required this.icon,
    required this.name,
    required this.route,
  });
  static List<DashBoardItem> dashBoardItemList=[
    DashBoardItem(icon: Icons.add, name: 'Add Product', route: NewProductPage.routeName),
    DashBoardItem(icon: Icons.list, name: 'View Product', route: ViewProductPage.routeName),
    DashBoardItem(icon: Icons.category, name: 'Category', route: CategoryPage.routeName),
  ];
}
