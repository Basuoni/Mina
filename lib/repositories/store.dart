import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class StoreRepo {
  static Future<bool> addProduct(String name, String link, int count) async {
    try {
      await FirebaseFirestore.instance
          .collection('Products')
          .add({"name": name, "Link": link, "Count": count});
      return true;
    } on FirebaseException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<void> getProduct() async {
    final data = await FirebaseFirestore.instance.collection('Products').get();
    log(data.toString());
  }
}
