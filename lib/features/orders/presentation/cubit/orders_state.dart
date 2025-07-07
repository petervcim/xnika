part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class FetchingOrderState extends OrdersState {}

final class DeletingOrderState extends OrdersState {
  final List<XnikazOrder> sneakerOrders;

  DeletingOrderState({
    required this.sneakerOrders,
  });
}

final class SendingOrderState extends OrdersState {
  final List<XnikazOrder> sneakerOrders;

  SendingOrderState({
    required this.sneakerOrders,
  });
}

// final class CompletingOrderState extends OrdersState {}

final class OrdersNormalState extends OrdersState {
  final List<XnikazOrder> sneakerOrders;

  OrdersNormalState({
    required this.sneakerOrders,
  });
}

final class CancellingOrderState extends OrdersNormalState {
  CancellingOrderState({
    required super.sneakerOrders,
  });
}
