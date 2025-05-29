import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_flutter_app/features/products/presentation/providers/products_provider.dart';
import 'package:teslo_flutter_app/features/products/presentation/widgets/product_card.dart';
import 'package:teslo_flutter_app/features/shared/widgets/side_menu.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
        ],
      ),
      body: const _ProductsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo producto'),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class _ProductsView extends ConsumerStatefulWidget {
  const _ProductsView();

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    ref.read(productsProvider.notifier).loadNextPage();
scrollController.addListener(
  () 
  {if (scrollController.position.pixels + 400 >=
        scrollController.position.maxScrollExtent) {
      ref.read(productsProvider.notifier).loadNextPage();
    }});
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productsProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 15,
        itemCount: productState.products.length,
        itemBuilder: (conext, index) {
          final product = productState.products[index];
          return Column(children: [ProductCard(product: product)]);
        },
      ),
    );
  }
}
