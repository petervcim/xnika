import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../sneakers/domain/entities/sneaker.dart';
import '../constants/order_constants.dart';

class XnikazOrder {
  bool isCompleted;
  bool isCanceled;
  int? quantity;
  String? color;
  String? size;
  String? id;
  DateTime? dateTime;
  DateTime? completedDateTime;
  DateTime? canceledDateTime;
  Sneaker? sneaker;
  double? price;
  String? addressId;

  XnikazOrder({
    this.id,
    this.dateTime,
    this.completedDateTime,
    this.isCompleted = false,
    this.isCanceled = false,
    this.size,
    this.color,
    this.quantity,
    this.sneaker,
    this.price,
    this.addressId,
    this.canceledDateTime,
  });

  factory XnikazOrder.fromMap(Map<String, dynamic> orderMap) {
    return XnikazOrder(
      size: orderMap[kOrderSneakerSizeFieldName] as String,
      quantity: orderMap[kOrderQuantityFieldName] as int,
      color: orderMap[kOrderSneakerColorFieldName] as String,
      addressId: orderMap[kOrderAddressIdFieldName] as String,
      isCompleted: orderMap[kIsOrderCompleteFieldName] as bool,
      isCanceled: orderMap[kOrderIsCanceledFieldName] as bool,
      dateTime: (orderMap[kOrderDateTimeFieldName] as Timestamp).toDate(),
      canceledDateTime: orderMap[kOrderCanceledDateTimeFieldName] == null ? null : (orderMap[kOrderCanceledDateTimeFieldName] as Timestamp).toDate(),
      completedDateTime: (orderMap[kOrderCompletedDateTime]) == null ? null : (orderMap[kOrderCompletedDateTime] as Timestamp).toDate(),
      price: orderMap[kOrderSneakerPrice] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      kOrderSneakerSizeFieldName: size,
      kOrderQuantityFieldName: quantity,
      kOrderSneakerColorFieldName: color,
      kIsOrderCompleteFieldName: isCompleted,
      kOrderDateTimeFieldName: Timestamp.fromDate(dateTime!),
      kOrderCanceledDateTimeFieldName: canceledDateTime,
      kOrderIsCanceledFieldName: isCanceled,
      kOrderSneakerIdFieldName: sneaker!.id!,
      kOrderCompletedDateTime: completedDateTime,
      kOrderSneakerPrice: price,
      kOrderAddressIdFieldName: addressId,
    };
  }
}
