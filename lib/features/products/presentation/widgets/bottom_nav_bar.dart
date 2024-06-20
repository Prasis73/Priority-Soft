import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_shoes/core/const/app_text_styles.dart';
import 'package:get_shoes/features/cart/data/models/cart_item_model.dart';
import 'package:get_shoes/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:get_shoes/features/products/data/models/product_model.dart';

class BottomNavBar extends StatelessWidget {
  Product product;
  String? selectedColor;
  String? selectedSize;
  BottomNavBar(
      {super.key,
      required this.product,
      required this.selectedColor,
      required this.selectedSize});

  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Price',
                    style: AppTextStyles.normalStyle12
                        .copyWith(color: const Color(0xffB7B7B7))),
                Text('\$${product.price.toDouble().toString()}',
                    style: AppTextStyles.boldStyle20),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (selectedColor != null && selectedSize != null) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 19.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Add to Cart',
                                    style: AppTextStyles.boldStyle20,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.cancel))
                                ],
                              ),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Quantity",
                                  style: AppTextStyles.boldStyle14,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(quantity.toString(),
                                      style: AppTextStyles.regularstyle14),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (quantity > 1) {
                                            setState(() {
                                              quantity--;
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                  color: quantity <= 1
                                                      ? Colors.grey
                                                      : Colors.black)),
                                          child: Center(
                                            child: Icon(
                                              Icons.remove,
                                              color: quantity <= 1
                                                  ? Colors.grey
                                                  : Colors.black,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          {
                                            setState(() {
                                              quantity++;
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: const Center(
                                            child: Icon(
                                              Icons.add,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Price",
                                        style: AppTextStyles.normalStyle12
                                            .copyWith(
                                                color: const Color(0xffB7B7B7)),
                                      ),
                                      Text(
                                        '\$${product.price.toDouble() * quantity}',
                                        style: AppTextStyles.boldStyle20,
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      final cartItem = CartItem(
                                          id: '',
                                          productId: product.id,
                                          userId: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          color: selectedColor!,
                                          size: int.parse(selectedSize!),
                                          quantity: quantity,
                                          price: product.price * quantity,
                                          name: product.name,
                                          image: product.imageUrl[0],
                                          brand: product.brand);
                                      context
                                          .read<CartItemBloc>()
                                          .cartRepository
                                          .addCartItem(cartItem);
                                      Navigator.pop(context);
                                      showAddedToCartBottomSheet(
                                          context, quantity);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 156,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: const Center(
                                        child: Text(
                                          'ADD TO CART',
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
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select color and size')),
                );
              }
            },
            child: Container(
              height: 50,
              width: 156,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(30)),
              child: const Center(
                child: Text(
                  'ADD TO CART',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showAddedToCartBottomSheet(BuildContext context, int quantity) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(60)),
              child: const Center(
                  child: Icon(
                Icons.check,
                size: 40,
                color: Color(0xffB7B7B7),
              )),
            ),
            const SizedBox(height: 16),
            Text('Added to cart', style: AppTextStyles.semiboldStyle24),
            const SizedBox(height: 8),
            Text('$quantity item added Total',
                style: AppTextStyles.regularstyle14),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: 156,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text('BACK EXPLORE',
                          style: AppTextStyles.boldStyle14),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(
                      '/cartPage',
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
                        'TO CART',
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
          ],
        ),
      );
    },
  );
}
