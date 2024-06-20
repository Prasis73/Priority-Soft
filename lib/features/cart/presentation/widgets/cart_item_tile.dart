import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_shoes/core/const/app_text_styles.dart';
import 'package:get_shoes/features/cart/data/models/cart_item_model.dart';
import 'package:get_shoes/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:get_shoes/features/cart/presentation/bloc/cart_event.dart';
import 'package:get_shoes/features/cart/presentation/bloc/cart_state.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final CartItemLoaded state;

  const CartItemTile({super.key, required this.cartItem, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(82, 195, 194, 194),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                width: 88,
                height: 88,
                child: Image.network(
                  cartItem.image,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cartItem.name),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      '${cartItem.brand} , ${cartItem.color} , ${cartItem.size}',
                      style: AppTextStyles.normalStyle12.copyWith(
                          color: const Color.fromARGB(255, 125, 124, 124)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${cartItem.price.toDouble()}',
                          style: AppTextStyles.semiBoldStyle16,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: cartItem.quantity <= 1 ? Colors.grey : Colors.black,
                  ),
                  onPressed: () {
                    if (cartItem.quantity > 1) {
                      int updatedPrice = cartItem.price ~/ cartItem.quantity;
                      context.read<CartItemBloc>().add(
                            UpdateCartItem(
                              cartItem.copyWith(
                                  quantity: cartItem.quantity - 1,
                                  price: cartItem.price - updatedPrice),
                            ),
                          );
                    }
                  },
                ),
                Text('${cartItem.quantity}'),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    int updatedPrice = cartItem.price ~/ cartItem.quantity;
                    context.read<CartItemBloc>().add(
                          UpdateCartItem(
                            cartItem.copyWith(
                                quantity: cartItem.quantity + 1,
                                price: cartItem.price + updatedPrice),
                          ),
                        );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
