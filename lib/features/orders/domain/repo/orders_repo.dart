import '../entities/xnikaz_order.dart';

abstract class OrdersRepo {
  Future<List<XnikazOrder>> fetchOrders(
    List<String> orderIds,
  );
  Future<XnikazOrder> sendNewOrder(
    XnikazOrder newXnikazOrder,
  );
  Future<void> deleteOrder(
    String userId,
    String orderId,
  );
  Future<void> cancelOrder(
    String orderId,
    DateTime dateTime,
  );
  // Future<void> markOrderAsComplete(String orderId);
}
