import 'package:equatable/equatable.dart';
import 'package:get_shoes/features/cart/data/models/cart_item_model.dart';

abstract class CartItemEvent extends Equatable {
  const CartItemEvent();

  @override
  List<Object> get props => [];
}

class LoadCartItems extends CartItemEvent {}

class ReLoadCartItems extends CartItemEvent {}

class AddCartItem extends CartItemEvent {
  final CartItem cartItem;

  const AddCartItem(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

class UpdateCartItem extends CartItemEvent {
  final CartItem cartItem;

  const UpdateCartItem(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

class RemoveCartItem extends CartItemEvent {
  final String cartItemId;

  const RemoveCartItem(this.cartItemId);

  @override
  List<Object> get props => [cartItemId];
}
