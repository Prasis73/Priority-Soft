import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_shoes/core/const/app_text_styles.dart';
import 'package:get_shoes/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:get_shoes/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:get_shoes/features/cart/presentation/bloc/cart_event.dart';
import 'package:get_shoes/features/cart/presentation/bloc/cart_state.dart';
import 'package:get_shoes/features/cart/presentation/pages/checkout_page.dart';
import 'package:get_shoes/features/cart/presentation/widgets/cart_item_tile.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 255, 255, 255),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 12,
            ),
            child: BlocProvider(
              create: (context) => CartItemBloc(
                cartRepository: RepositoryProvider.of<CartRepository>(context),
              )..add(LoadCartItems()),
              child: const CartView(),
            ),
          ),
          Positioned(
              top: 55,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              )),
          Positioned(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 65.0),
                  child: Text(
                    "Cart",
                    style: AppTextStyles.semiBoldStyle16,
                  )),
            ],
          )),
        ],
      ),
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartItemBloc, CartItemState>(
      builder: (context, state) {
        if (state is CartItemLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartItemLoaded) {
          return state.cartItems.isEmpty
              ? const Center(
                  child: Text(
                    "Cart is Empty",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: ListView.builder(
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = state.cartItems[index];
                          return Dismissible(
                            key: Key(cartItem.brand),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              context
                                  .read<CartItemBloc>()
                                  .add(RemoveCartItem(cartItem.id));
                              return false;
                            },
                            child:
                                CartItemTile(cartItem: cartItem, state: state),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Grand Total",
                                    style: AppTextStyles.normalStyle12
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    '\$${state.totalAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: state.cartItems.isEmpty
                                    ? () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text('Add Items in cart first'),
                                        ));
                                      }
                                    : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CheckoutPage(
                                                cartItems: state.cartItems),
                                          ),
                                        );
                                      },
                                child: Container(
                                  height: 50,
                                  width: 156,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Center(
                                    child: Text(
                                      'CHECK OUT',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
        } else if (state is CartItemError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No items in the cart'));
        }
      },
    );
  }
}
