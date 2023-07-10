import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Expanded(
        child: ListView(
          children: <Widget>[
            const ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image(
                image: NetworkImage('https://i.dummyjson.com/data/products/5/2.jpg'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              child: const Text('Catégorie', textAlign: TextAlign.left),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              child: const Text(
                'Nom du produit',
                style: TextStyle(
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
              child: const Text(
                'Description du produit',
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '99,95 €',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    tooltip: 'Ajouter au panier',
                    onPressed: () {
                      const snackBar = SnackBar(
                        content: Text('Produit ajouté au panier'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
