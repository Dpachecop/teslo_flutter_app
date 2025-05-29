import 'package:teslo_flutter_app/features/products/domain/datasources/product_datasource.dart';
import 'package:teslo_flutter_app/features/products/domain/entities/Product.dart';
import 'package:teslo_flutter_app/features/products/repositories/product_repositories.dart';

class ProductRepositoryImpl extends ProductRepository{


  final ProductDatasource datasource;

  ProductRepositoryImpl( this.datasource);
  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    return datasource.createUpdateProduct(productLike);
  }

  @override
  Future<Product> getProductById(String id) {
   return datasource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductByPage({int limit = 10, int offset = 0}) {
  return datasource.getProductByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> getProductByTerm(String term) {
   return datasource.getProductByTerm(term);
  }
}