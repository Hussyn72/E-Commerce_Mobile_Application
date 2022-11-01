import 'package:JF_InfoTech/data/repository/cart_repo.dart';
import 'package:JF_InfoTech/models/products_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_models.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items=> _items;
//0.1.2.3....
  List <CartModel> storageItems =[];
//only for storage and shareded preferences

  void addItem(ProductModel product, int quantity) {
    var totalQuantity=0;
    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value) {
        totalQuantity=value.quantity!+quantity;

        return CartModel(
          id: value.id,
          name: value.name,
          quantity: value.quantity!+quantity,
          price: value.price,
          isExist: true,
          img: value.img,
          time: DateTime.now().toString(),
          product: product,

        );
      });


      if(totalQuantity<=0){
        _items.remove(product.id);
      }

    }else{
    if(quantity>0){
      _items.putIfAbsent(product.id!, () {
        //  print("adding item to the cart id" +
        //      product.id!.toString() +
        //      "quantity" +
        //  quantity.toString());
        _items.forEach((key, value) {
          // print("Quantity is " + value.quantity.toString());
        });
        return CartModel(
          id: product.id,
          name: product.name,
          quantity: quantity,
          price: product.price,
          isExist: true,
          img: product.img,
          time: DateTime.now().toString(),
          product: product,
        );
      });
    }else{
      Get.snackbar("Item count", "You should at least add an item in the cart",
      backgroundColor: AppColors.mainColor,
          colorText: Colors.white
      );}
    }
    cartRepo.addToCartList(getItems);
    update();
   // print("length of the item is " + _items.length.toString());
    //!-----> is a bang operator use to indicate its not null
  }

  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product){
    var quantity=0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }
//print total items
  int get totalItems{
    var totalQuantity=0;
    _items.forEach((key, value) {
    totalQuantity+= value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems{
     return _items.entries.map((e){
      return e.value;
    }).toList();
  }

  int get totalAmount{
    var total=0;
    _items.forEach((key, value) {
      total+=value.quantity!*value.price!;
    });



    return total;
  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }

//setter,getter

  set setCart(List<CartModel> items){
    storageItems=items;
   // print("length of cart items"+storageItem.length.toString());
    for(int i=0; i<storageItems.length;i++){
      if(storageItems[i].product!=null && storageItems[i].product!.id!=null){
        _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);

      }
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear(){
    _items={};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems ){
    _items={};
    _items = setItems;
  }

  void addtoCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }
  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }

}
