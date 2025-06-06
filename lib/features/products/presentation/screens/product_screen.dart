import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerStatefulWidget {

  final String productId;
  const ProductScreen( {super.key, required this.productId,});

  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          ' Editar producto'
        ),
      ),

      body: Column(
        children: [
          Text(widget.productId)
        ],
      ),
    );
  }
}