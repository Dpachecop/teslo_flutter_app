import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_flutter_app/features/products/domain/entities/Product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => context.push('/product/${product.id}'),
      child: Column(
        children: [
          _ImageViewer(images: product.images),
      
          Text(product.title),
          Text(product.price.toString()),
        ],
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final List<String> images;
  const _ImageViewer({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/no-image.jpg',
          fit: BoxFit.cover,
          height: 250,
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage(
        fit: BoxFit.cover,
        height: 250,
        fadeInDuration: Duration(milliseconds: 100),
        fadeOutDuration: Duration(milliseconds: 200),
        placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
        image: NetworkImage(images.first),
      ),
    );
  }
}
