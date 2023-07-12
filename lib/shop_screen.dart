import 'package:flutter/material.dart';
import 'package:flutter_project_shop/Card/product_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Product>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Failed to load data');
          } else {
            final products = snapshot.data;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400, // Adjust this value based on your phone's width
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.9,
              ),
              primary: false,
              itemCount: products?.length ?? 0,
              padding: const EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                final product = products?[index];
                return ProductCard(
                  thumbnail: product?.thumbnail ?? '',
                  category: product?.category ?? '',
                  productName: product?.title ?? '',
                  description: product?.description ?? '',
                  price: product?.price ?? 0.0,
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Product>> fetchData() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final productsData = data['products'];
      return List<Product>.from(productsData.map((product) => Product.fromJson(product)));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
