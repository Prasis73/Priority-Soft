import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_shoes/features/cart/data/models/cart_item_model.dart';
import 'package:get_shoes/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:get_shoes/features/cart/presentation/bloc/cart_event.dart';
import 'package:get_shoes/features/cart/presentation/bloc/cart_state.dart';

class CartItemBloc extends Bloc<CartItemEvent, CartItemState> {
  final CartRepository cartRepository;

  CartItemBloc({required this.cartRepository}) : super(CartItemInitial()) {
    on<LoadCartItems>(_onLoadCartItems);
    on<ReLoadCartItems>(_onreloadCartItems);
    on<AddCartItem>(_onAddCartItem);
    on<UpdateCartItem>(_onUpdateCartItem);
    on<RemoveCartItem>(_onRemoveCartItem);
  }

  void _onLoadCartItems(
      LoadCartItems event, Emitter<CartItemState> emit) async {
    emit(CartItemLoading());
    try {
      final cartItems = await cartRepository.fetchCartItems();
      final totalAmount = _calculateTotalAmount(cartItems);
      emit(CartItemLoaded(cartItems, totalAmount: totalAmount));
    } catch (e) {
      emit(const CartItemError('Failed to load cart items'));
    }
  }

  void _onreloadCartItems(
      ReLoadCartItems event, Emitter<CartItemState> emit) async {
    try {
      final cartItems = await cartRepository.fetchCartItems();
      final totalAmount = _calculateTotalAmount(cartItems);
      emit(CartItemLoaded(cartItems, totalAmount: totalAmount));
    } catch (e) {
      emit(const CartItemError('Failed to load cart items'));
    }
  }

  void _onAddCartItem(AddCartItem event, Emitter<CartItemState> emit) async {
    try {
      await cartRepository.addCartItem(event.cartItem);
      add(LoadCartItems()); // Reload cart items
    } catch (e) {
      emit(const CartItemError('Failed to add cart item'));
    }
  }

  void _onUpdateCartItem(
      UpdateCartItem event, Emitter<CartItemState> emit) async {
    try {
      await cartRepository.updateCartItem(event.cartItem);
      add(ReLoadCartItems()); // Reload cart items
    } catch (e) {
      emit(const CartItemError('Failed to update cart item'));
    }
  }

  void _onRemoveCartItem(
      RemoveCartItem event, Emitter<CartItemState> emit) async {
    try {
      await cartRepository.removeCartItem(event.cartItemId);
      add(LoadCartItems()); // Reload cart items
    } catch (e) {
      emit(const CartItemError('Failed to remove cart item'));
    }
  }

  double _calculateTotalAmount(List<CartItem> cartItems) {
    return cartItems.fold(0.0, (sum, item) => sum + item.price);
  }
}
