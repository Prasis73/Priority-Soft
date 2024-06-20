// ignore_for_file: avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_shoes/core/const/app_text_styles.dart';
import 'package:get_shoes/features/cart/data/models/cart_item_model.dart';
import 'package:get_shoes/features/products/presentation/pages/discover_page.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isTap = false;
  @override
  Widget build(BuildContext context) {
    double totalAmount =
        widget.cartItems.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Order Summary',
          style: AppTextStyles.semiBoldStyle16,
        )),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Information', style: AppTextStyles.boldStyle18),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Payment Method',
                      style: AppTextStyles.semiBoldStyle16),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey,
                  ),
                  subtitle: Text(
                    "Credit Card",
                    style: AppTextStyles.regularstyle14,
                  ),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Location', style: AppTextStyles.semiBoldStyle16),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey,
                  ),
                  subtitle: Text(
                    "Semarang, Indonesia",
                    style: AppTextStyles.regularstyle14,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Order Detail',
                  style: AppTextStyles.boldStyle18,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = widget.cartItems[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              cartItem.name,
                              style: AppTextStyles.semiBoldStyle16,
                            ),
                            subtitle: Text(
                              '${cartItem.brand}, ${cartItem.color}, ${cartItem.size}, Qty ${cartItem.quantity}',
                              style: AppTextStyles.regularstyle14
                                  .copyWith(color: Colors.grey),
                            ),
                            trailing: Text(
                              '\$${cartItem.price.toStringAsFixed(2)}',
                              style: AppTextStyles.boldStyle14,
                            ),
                          ),
                          if (widget.cartItems.length <= index + 1)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Payment Detail',
                                  style: AppTextStyles.boldStyle18,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Sub Total',
                                      style: AppTextStyles.regularstyle14,
                                    ),
                                    Text('\$${totalAmount.toStringAsFixed(2)}',
                                        style: AppTextStyles.semiBoldStyle16),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Shipping',
                                      style: AppTextStyles.regularstyle14,
                                    ),
                                    Text(
                                      '\$20',
                                      style: AppTextStyles.semiBoldStyle16,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Order:',
                                      style: AppTextStyles.regularstyle14,
                                    ),
                                    Text(
                                        '\$${(totalAmount + 20).toStringAsFixed(2)}',
                                        style: AppTextStyles.semiBoldStyle16),
                                  ],
                                ),
                              ],
                            )
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
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
                          '\$${(totalAmount + 20).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        isTap
                            ? () {}
                            : await _handlePayment(
                                context, widget.cartItems, totalAmount);
                      },
                      child: Container(
                        height: 50,
                        width: 156,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: isTap
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
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
      ),
    );
  }

  Future<void> _handlePayment(BuildContext context, List<CartItem> cartItems,
      double totalAmount) async {
    setState(() {
      isTap = true;
    });
    try {
      for (int i = 0; i < cartItems.length; i++) {
        await FirebaseFirestore.instance.collection('checkout').add({
          'brand': cartItems[i].brand,
          'userId': cartItems[i].userId,
          'color': cartItems[i].color,
          'productId': cartItems[i].productId,
          'price': cartItems[i].price,
          'quantity': cartItems[i].quantity,
          'image': cartItems[i].image,
          'size': cartItems[i].size,
          'id': cartItems[i].id,
          'shipping_cost': 20,
          'paymanet_method': "cash on delivery",
          'location': "Semarang, Indonesia",
          'totalAmount': totalAmount + 20,
          'timestamp': Timestamp.now(),
          'status': 'Not Delivered'
        }).then((value) {
          FirebaseFirestore.instance
              .collection('cart')
              .doc(cartItems[i].id)
              .delete()
              .then((value) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Payment successful!'),
            ));

            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const DiscoverPage()),
              (Route<dynamic> route) => false,
            );
          });
        });
      }
    } catch (e) {
      setState(() {
        isTap = false;
      });
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Payment failed: $e'),
      ));
    }
  }
}
