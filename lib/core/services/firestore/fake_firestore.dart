// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreDBService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final _user = FirebaseAuth.instance.currentUser;

//   // @override
//   // Future<bool> addUser(UserModel user) async {
//   //   DocumentSnapshot readUser =
//   //       await _firestore.doc("users/${user.userID}").get();

//   //   if (!readUser.exists) {
//   //     debugPrint('Data null geldi (Add User FirestoreDBService))');
//   //     await _firestore.collection("users").doc(user.userID).set({
//   //       'userName': user.userName,
//   //       'email': user.email,
//   //       'userID': user.userID,
//   //     });
//   //     return true;
//   //   } else {
//   //     debugPrint(
//   //         'Kullanici zaten veritabanında var  (Add User FirestoreDBService))');
//   //     return false;
//   //   }
//   // }

//   // @override
//   // Future<UserModel> readUser(String userID) async {
//   //   DocumentSnapshot snapshot =
//   //       await _firestore.collection('users').doc(userID).get();

//   //   if (snapshot.exists) {
//   //     Map<String, dynamic> userMap = snapshot.data() as Map<String, dynamic>;
//   //     UserModel user = UserModel.fromMap(userMap);
//   //     return user;
//   //   } else {
//   //     debugPrint('Kullanici veritabanında yok (Read User FirestoreDBService)');
//   //     return UserModel();
//   //   }
//   // }

//   // @override
//   // Future<void> pushBasketDataToFirestore(List<Products> basketProducts) async {
//   //   CollectionReference<Map<String, dynamic>> orderCollection =
//   //       _firestore.collection('orders');
//   //   User? user = FirebaseAuth.instance.currentUser;
//   // DocumentReference<Map<String, dynamic>> newOrderDocument =
//   //     orderCollection.doc();

//   //   Map<String, dynamic> orderData = {
//   //     'userID': user?.uid,
//   //     'products': basketProducts
//   //         .map((product) => {
//   //               'productId': product.id,
//   //               'name': product.name,
//   //               'price': product.price,
//   //               'image': product.imageUrl,
//   //               'quantity': product.quantity,
//   //             })
//   //         .toList(),
//   //   };

//   //   await newOrderDocument.set(orderData);
//   // }

//   @override
//   Future<QuerySnapshot<Map<String, dynamic>>> getOrders() async {
//     final ordersCollection = _firestore.collection('orders');

//     final userOrders =
//         await ordersCollection.where('userID', isEqualTo: _user!.uid).get();

//     return userOrders;
//   }
// }
