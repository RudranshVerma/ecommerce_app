import 'dart:core';
import 'package:ecommerce_app/providers/product_class.dart';
import 'package:ecommerce_app/providers/sql_helper.dart';
import 'package:flutter/cupertino.dart';

class Cart extends ChangeNotifier {
  static List<Product> _list = [];
  List<Product> get getItems {
    return _list;
  }

  double get totalPrice {
    var total = 0.0;

    for (var item in _list) {
      total += item.price * item.qty;
    }
    return total;
  }

  int? get count {
    return _list.length;
  }

  void addItem(Product product) async {
    await SQLHelper.insertItem(product).whenComplete(() => _list.add(product));
    notifyListeners();
  }

  loadCartItemsProvider() async {
    List<Map> data = await SQLHelper.loadItems();
    _list = data.map((product) {
      return Product(
          documentId: product['documentId'],
          name: product['name'],
          price: product['price'],
          qty: product['qty'],
          qntty: product['qntty'],
          imagesUrl: product['imagesUrl'],
          suppId: product['suppId']);
    }).toList();
    notifyListeners();
  }

  void increment(
    Product product,
  ) async {
    await SQLHelper.updateItem(product, 'increment')
        .whenComplete(() => product.increase());

    notifyListeners();
  }

  void reduceByOne(Product product) async {
    await SQLHelper.updateItem(product, 'reduce')
        .whenComplete(() => product.decrease());
    notifyListeners();
  }

  void removeItem(Product product) async {
    await SQLHelper.deleteItem(product.documentId)
        .whenComplete(() => _list.remove(product));
    notifyListeners();
  }

  void clearCart() async {
    await SQLHelper.deleteAllItems().whenComplete(() => _list.clear());
    notifyListeners();
  }
}
