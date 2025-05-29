  import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_flutter_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_flutter_app/features/products/infrastructure/infraestructure.dart';
import 'package:teslo_flutter_app/features/products/repositories/product_repositories.dart';
  
  
final productsRepositoryProvider = Provider<ProductRepository>((ref) {

  final accessToken = ref.watch(authProvider).user?.token ?? '';
  
  final productRepository =  ProductRepositoryImpl(ProductDatasourceImpl(acccesToken: accessToken));


  return productRepository;
});
