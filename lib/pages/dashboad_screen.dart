import 'package:ecommerce_app/auth/auth_service.dart';
import 'package:ecommerce_app/customwidgets/dashboard_item_view.dart';
import 'package:ecommerce_app/pages/launcher_screen.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dashboard_item.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context,listen:false).getAllCategorise();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                AuthServices.logout().then((value) =>
                    Navigator.pushReplacementNamed(
                        context, LauncherScreen.routeName));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
          itemCount: DashBoardItem.dashBoardItemList.length,
          itemBuilder: (context, index) {
            final item=DashBoardItem.dashBoardItemList[index];
            return DashboardItemView(item: item);
          },),
    );
  }
}
