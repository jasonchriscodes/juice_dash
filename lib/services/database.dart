import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfo(Map<String, dynamic> userInfoMap, String id) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addUserOrder(Map<String, dynamic> addOrder, String userId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("Orders")
        .add(addOrder);
  }

  Future<Stream<QuerySnapshot>> getAllOrders(String id) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Orders")
        .snapshots();
  }

  Stream<QuerySnapshot> getAllUsersOrders() {
    return FirebaseFirestore.instance.collectionGroup("Orders").snapshots();
  }

  Future<QuerySnapshot> getUserByEmail(String email) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: email)
        .get();
  }

  Future<QuerySnapshot> getAdminByEmail(String email) {
    return FirebaseFirestore.instance
        .collection("admins")
        .where("Email", isEqualTo: email)
        .get();
  }

  Future<void> markUserOrderDelivered(DocumentReference orderRef) async {
    await orderRef.update({
      "Delivered": "true",
    });
  }

  addAdminOrder(Map<String, dynamic> addUserOrder, String orderId) {}
}
