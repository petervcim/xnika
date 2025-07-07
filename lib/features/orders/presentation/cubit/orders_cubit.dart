import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/xnikaz_order.dart';
import '../../domain/repo/orders_repo.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepo ordersRepo;
  final List<XnikazOrder> sneakerOrders = <XnikazOrder>[];

  OrdersCubit({
    required this.ordersRepo,
  }) : super(OrdersInitial());

  Future<void> fetchOrders(List<String> orderIds) async {
    emit(FetchingOrderState());
    List<XnikazOrder> fetchedOrders = await ordersRepo.fetchOrders(orderIds);
    sneakerOrders.addAll(fetchedOrders);
    emit(
      OrdersNormalState(
        sneakerOrders: sneakerOrders,
      ),
    );
  }

  Future<void> cancelOrder(String orderId) async {
    emit(
      CancellingOrderState(
        sneakerOrders: sneakerOrders,
      ),
    );
    DateTime dateTime = DateTime.now();
    await ordersRepo.cancelOrder(orderId, dateTime);
    (sneakerOrders.firstWhere((sneakerOrder) => sneakerOrder.id == orderId)..isCanceled = true).canceledDateTime = dateTime;
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
    emit(
      OrdersNormalState(
        sneakerOrders: sneakerOrders,
      ),
    );
  }

  // Future<void> markOrderCompleted(String orderId) async {
  //   emit(CompletingOrderState());
  //   await firebaseOrdersRepo.markOrderAsComplete(orderId);
  //   emit(OrdersNormalState(
  //     sneakerOrders: sneakerOrders,
  //   ));
  // }

  Future<void> sendOrder(
    XnikazOrder newOrder,
    Future<void> Function(String) addOrderToUserCallBack,
  ) async {
    emit(
      SendingOrderState(
        sneakerOrders: sneakerOrders,
      ),
    );
    await Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
    XnikazOrder addedOrder = await ordersRepo.sendNewOrder(newOrder);
    sneakerOrders.add(addedOrder);
    await addOrderToUserCallBack(addedOrder.id!);
    emit(
      OrdersNormalState(
        sneakerOrders: sneakerOrders,
      ),
    );
  }

  Future<void> deleteOrder(
    String userId,
    String orderId,
  ) async {
    sneakerOrders.removeWhere((sneakerOrder) => sneakerOrder.id == orderId);
    // emit(
    //   DeletingOrderState(
    //     sneakerOrders: sneakerOrders,
    //   ),
    // );
    await ordersRepo.deleteOrder(
      userId,
      orderId,
    );
    emit(
      OrdersNormalState(
        sneakerOrders: sneakerOrders,
      ),
    );
  }

  void clearAllOrders() {
    sneakerOrders.clear();
  }
}
