import 'package:equatable/equatable.dart';
import 'package:get_shoes/features/cart/data/models/cart_item_model.dart';

abstract class CartItemState extends Equatable {
  const CartItemState();

  @override
  List<Object> get props => [];
}

class CartItemInitial extends CartItemState {}

class CartItemLoading extends CartItemState {}

class CartItemLoaded extends CartItemState {
  final List<CartItem> cartItems;
  final double totalAmount;

  const CartItemLoaded(this.cartItems, {required this.totalAmount});

  @override
  List<Object> get props => [cartItems];
}

class CartItemError extends CartItemState {
  final String message;

  const CartItemError(this.message);

  @override
  List<Object> get props => [message];
}
