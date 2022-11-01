import 'package:JF_InfoTech/models/products_models.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? time;
  String? img;
  bool? isExist;
  int? quantity;
  ProductModel? product;


  CartModel({
    this.id,
    this.name,
    this.quantity,
    this.price,
    this.isExist,
    this.img,
    this.time,
    this.product,
  });

  CartModel.fromjson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = ProductModel.fromjson(json['product']);
  }

  Map<String, dynamic> toJson(){
   return{
     "id:":this.id,
     "name":this.name,
     "price":this.price,
     "img":this.img,
     "quantity":this.quantity,
     "isExist":this.isExist,
     "time":this.time,
     "product":this.product!.toJson(),

   };
  }
}