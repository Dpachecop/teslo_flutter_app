import 'package:teslo_flutter_app/config/constants/enviroment.dart';
import 'package:teslo_flutter_app/features/products/domain/entities/Product.dart';

import '../../../auth/infraestructure/mappers/user_mapper.dart';

class ProductMapper {


  static jsonToEntity( Map<String, dynamic> json ) => Product(
    id: json['id'], 
    title: json['title'], 
    price: double.parse( json['price'].toString() ), 
    description: json['description'], 
    slug: json['slug'], 
    stock: json['stock'], 
    sizes: List<String>.from( json['sizes'].map( (size) => size )  ), 
    gender: json['gender'], 
    tags: List<String>.from( json['tags'].map( (tag) => tag )  ),
    images: List<String>.from(
      json['images'].map( 
        (image) => image.startsWith('http')
          ? image
          : '${ Enviroment.apiUrl }/files/product/$image',
      )
    ), 
    user: UserMapper.userJsonToEntity( json['user'] )
  );



}