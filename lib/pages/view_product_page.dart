import 'package:ecommerce_app/pages/product_details_page.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ViewProductPage extends StatelessWidget {
  static const String routeName = '/viewProduct';
  const ViewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('View Product'),
        ),
        body: Consumer<ProductProvider>(
          builder: (context, p, child) => ListView.builder(
            itemCount: p.productList.length,
            itemBuilder: (context, index) {
              final product = p.productList[index];
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsPage.routeName,
                      arguments: product.id);
                },
                leading: SizedBox(
                  width: 100,
                  height: 100,
                  child: CachedNetworkImage(
                    fadeInDuration: const Duration(seconds: 3),
                    fadeInCurve: Curves.easeInOut,
                    imageUrl: product.imageUrl,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
                title: Text(product.name),
                subtitle: Text('Stock:${product.stock}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star),
                    Text(
                      product.avgRating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
