// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_shoes/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:get_shoes/features/cart/presentation/bloc/cart_state.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartItemBloc, CartItemState>(
      builder: (context, state) {
        int itemCount = 0;
        if (state is CartItemLoaded) {
          itemCount = state.cartItems.length;
        }

        return Stack(
          children: [
            IconButton(
              icon: SvgPicture.asset(
                height: 24,
                width: 24,
                'assets/svg/cart.svg',
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/cartPage',
                );
              },
            ),
            /*   if (itemCount > 0)
              Positioned(
                right: 12,
                top: 16,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 8,
                    minHeight: 8,
                  ),
                ),
              ), */
          ],
        );
      },
    );
  }
}
