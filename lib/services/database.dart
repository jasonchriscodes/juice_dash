import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfo(Map<String, dynamic> userInfoMap, String id) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addUserOrder(Map<String, dynamic> addOrder, String id) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Orders")
        .add(addOrder);
  }

  Future addAdminOrder(Map<String, dynamic> addAdminOrder) {
    return FirebaseFirestore.instance
        .collection("adminOrder")
        .add(addAdminOrder);
  }
}
