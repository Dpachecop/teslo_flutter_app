import 'package:dio/dio.dart';
import 'package:teslo_flutter_app/config/constants/enviroment.dart';
import 'package:teslo_flutter_app/features/products/domain/datasources/product_datasource.dart';
import 'package:teslo_flutter_app/features/products/domain/entities/Product.dart';
import 'package:teslo_flutter_app/features/products/infrastructure/mappers/product_mapper.dart';

class ProductDatasourceImpl extends ProductDatasource {
  final Dio dio;
  final String acccesToken;

  ProductDatasourceImpl({required this.acccesToken})
    : dio = Dio(
        BaseOptions(
          baseUrl: Enviroment.apiUrl,
          headers: {"Authorization": " Bearer $acccesToken"},
        ),
      );

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductByPage({int limit = 10, int offset = 0})  async{
   final response = await dio.get("/products?limit=$limit&offset=$offset");
   final List<Product> products = [];
   for (final product in response.data) {
      products.add(ProductMapper.jsonToEntity(product));
     
   }

return products;
  }

  @override
  Future<List<Product>> getProductByTerm(String term) {
    // TODO: implement getProductByTerm
    throw UnimplementedError();
  }
}
