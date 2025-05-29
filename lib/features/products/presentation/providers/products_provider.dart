import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_flutter_app/features/products/domain/entities/Product.dart';
import 'package:teslo_flutter_app/features/products/presentation/providers/products_repository_provider.dart';
import 'package:teslo_flutter_app/features/products/repositories/product_repositories.dart';



final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>((ref){


final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductsNotifier(productRepository: productsRepository);
});

class ProductsNotifier extends StateNotifier<ProductsState>{
  final ProductRepository productRepository;
  ProductsNotifier({required this.productRepository}): super(ProductsState()){

   // initial load of products 
    loadNextPage();
  }

// method to load products by page
  /// This method fetches products from the repository and updates the state.
  /// It checks if the current state is loading or if the last page has been reached.
  /// If not, it fetches the next page of products and updates the state accordingly.
Future<void> loadNextPage() async {
  if (state.isLoading || state.isLastPage) return;

  state = state.copyWith(isLoading: true);

  
    final products = await productRepository.getProductByPage(
      limit: state.limit,
      offset: state.offset,
    );

    if (products.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
    return;
    }

    state = state.copyWith(
     
      isLoading: false,
      isLastPage: false,
      offset: state.offset + 10,
       products: [...state.products, ...products],
    );
  } 




}

// State class to hold the state of products
  /// This class represents the state of the products in the application.
  /// It includes a list of products, loading state, last page status, limit, and offset.
  /// It provides a method to create a copy of the state with updated values.
class ProductsState{
final List<Product> products;
final bool isLoading;
final bool isLastPage;
final int limit;
final int offset;

ProductsState({
  this.products = const [],
  this.isLoading = false,
  this.isLastPage = false,
  this.limit = 10,
  this.offset = 0,


});

  ProductsState copyWith({
    List<Product>? products,
    bool? isLoading,
    bool? isLastPage,
    int? limit,
    int? offset,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isLastPage: isLastPage ?? this.isLastPage,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }






}