import "package:cloud_firestore/cloud_firestore.dart";
import "package:xnika/features/authentication/domain/constants/authentication_constants.dart";

import "../../sneakers/data/firebase_sneakers_repo.dart";
import "../../sneakers/domain/constants/sneaker_constants.dart";
import "../domain/constants/order_constants.dart";
import "../domain/repo/orders_repo.dart";
import "../domain/entities/xnikaz_order.dart";

class FirebaseOrdersRepo implements OrdersRepo {
  final FirebaseFirestore firebaseFirestoreInstance = FirebaseFirestore.instance;

  @override
  Future<void> deleteOrder(
    String userId,
    String orderId,
  ) async {
    DocumentReference orderDocumentReference = firebaseFirestoreInstance.collection(kOrdersCollectionName).doc(orderId);
    DocumentReference<Map<String, dynamic>> userDocumentReference = firebaseFirestoreInstance.collection(kAuthenticationUsersCollectionName).doc(userId);
    await userDocumentReference.update(<String, dynamic>{
      kAuthenticationUserOrderIds: FieldValue.arrayRemove(
        <String>[
          orderId,
        ],
      ),
    });
    await orderDocumentReference.delete();
  }

  @override
  Future<List<XnikazOrder>> fetchOrders(List<String> orderIds) async {
    List<XnikazOrder> orders = <XnikazOrder>[];
    CollectionReference<Map<String, dynamic>> ordersCollectionReference = firebaseFirestoreInstance.collection(kOrdersCollectionName);

    for (String orderId in orderIds) {
      DocumentReference<Map<String, dynamic>> orderDocumentReference = ordersCollectionReference.doc(orderId);
      DocumentSnapshot<Map<String, dynamic>> orderDocumentSnapshot = await orderDocumentReference.get();

      if (!orderDocumentSnapshot.exists) continue;

      String sneakerId = orderDocumentSnapshot[kOrderSneakerIdFieldName] as String;
      DocumentReference<Map<String, dynamic>> sneakerDocumentReference = firebaseFirestoreInstance.collection(kSneakersFirestoreCollectionName).doc(sneakerId);
      DocumentSnapshot<Map<String, dynamic>> sneakerDocumentSnapshot = await sneakerDocumentReference.get();
      Map<String, dynamic> sneakerProperties = sneakerDocumentSnapshot.data()!;

      orders.add(
        XnikazOrder.fromMap(
          orderDocumentSnapshot.data()!,
        )
          ..id = orderId
          ..sneaker = await FirebaseSneakersRepo.generateSneakerFromDocumentSnapshot(
            sneakerProperties,
            sneakerDocumentSnapshot.id,
          ),
      );
    }

    return orders;
  }

  // @override
  // Future<void> markOrderAsComplete(String orderId) async {
  //   DocumentReference orderDocumentReference = firebaseFirestoreInstance.collection(kOrdersCollectionName).doc(orderId);
  //   await orderDocumentReference.update(
  //     <String, dynamic>{
  //       kIsOrderCompleteFieldName: true,
  //       kOrderCompletedDateTime: Timestamp.fromDate(DateTime.now()),
  //     },
  //   );
  // }

  @override
  Future<XnikazOrder> sendNewOrder(XnikazOrder newOrder) async {
    DocumentReference newOrderDocumentReference = firebaseFirestoreInstance.collection(kOrdersCollectionName).doc();
    await newOrderDocumentReference.set(newOrder.toMap());
    return newOrder..id = newOrderDocumentReference.id;
  }

  @override
  Future<void> cancelOrder(
    String orderId,
    DateTime dateTime,
  ) async {
    DocumentReference orderDocumentReference = firebaseFirestoreInstance.collection(kOrdersCollectionName).doc(orderId);
    await orderDocumentReference.update(
      <String, dynamic>{
        kOrderIsCanceledFieldName: true,
        kOrderCanceledDateTimeFieldName: Timestamp.fromDate(
          dateTime,
        ),
      },
    );
  }
}
