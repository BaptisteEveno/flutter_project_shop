import 'package:flutter/material.dart';
import 'package:flutter_project_shop/cart_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductCard extends StatelessWidget {
  final String thumbnail;
  final String category;
  final String productName;
  final String description;
  final double price;

  const ProductCard({
    required this.thumbnail,
    required this.category,
    required this.productName,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image(
                  width: 50, // Specify the desired width
                  height: 50, // Specify the desired height
                  alignment: Alignment.topCenter,
                  image: NetworkImage(thumbnail),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            child: Text(
              category,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            child: Text(
              productName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            child: Row(
              children: const [
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star_outline),
                Icon(Icons.star_outline),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            child: Text(
              description,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$price €',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  tooltip: 'Ajouter au panier',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
    await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final productsData = data['products'];

      setState(() {
        products = List<Product>.from(
            productsData.map((product) => Product.fromJson(product)));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            thumbnail: product.thumbnail,
            category: product.category,
            productName: product.title,
            description: product.description,
            price: product.price,
          );
        },
      ),
    );
  }
}

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      rating: json['rating'].toDouble(),
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
    );
  }
}
