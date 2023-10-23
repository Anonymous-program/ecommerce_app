import 'package:ecommerce_app/pages/category_page.dart';
import 'package:ecommerce_app/pages/dashboad_screen.dart';
import 'package:ecommerce_app/pages/launcher_screen.dart';
import 'package:ecommerce_app/pages/login_screen.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/new_product_page.dart';
import 'pages/view_product_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers:[
      ChangeNotifierProvider(create:(_)=>ProductProvider(),),
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: LauncherScreen.routeName,
      builder: EasyLoading.init(),
      routes: {
        LauncherScreen.routeName: (_) => const LauncherScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        DashboardScreen.routeName: (_) => const DashboardScreen(),
        NewProductPage.routeName: (_) => const NewProductPage(),
        ViewProductPage.routeName: (_) => const ViewProductPage(),
        CategoryPage.routeName: (_) => const CategoryPage(),
      },
    );
  }
}
