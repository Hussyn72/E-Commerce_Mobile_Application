import 'package:flutter/cupertino.dart';
import 'cart_models.dart';

class Product{
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel> _products;
  List<ProductModel> get products=>_products;

  product({ required totalSize, required typeId, required offset ,required products}){
    this._totalSize=_totalSize;
    this._typeId=_typeId;
    this._offset=_offset;
    this._products=_products;
  }

  Product.fromJson(Map<String, dynamic> json) {
  _totalSize = json['total_size'];
  _typeId = json['type_id'];
  _offset = json['offset'];
  if(json['products'] != null){
    _products = <ProductModel>[];
    json['products'].forEach((v){
      _products.add(ProductModel.fromjson(v));
    });
   }
  }

}

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;



  ProductModel(
  {
    this.id,
    this.name,
    this.description,
    this.price,
    this.stars,
    this.img,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.typeId,

}
      );

  ProductModel.fromjson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['createAt'];
    updatedAt = json['updatedAt'];
    typeId = json['typeId'];

  }
  Map<String, dynamic> toJson(){
    return{
      "id:":this.id,
      "name":this.name,
      "price":this.price,
      "img":this.img,
      "location":this.location,
      "createdAt" : this.createdAt,
      "updatedAt" : this.updatedAt,
      "typeId" : this.typeId,

    };
  }

}
