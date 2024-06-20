import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_shoes/core/const/app_text_styles.dart';
import 'package:get_shoes/features/products/data/models/product_model.dart';
import 'package:get_shoes/features/products/presentation/widgets/cart_icon_badge.dart';
import 'package:get_shoes/features/products/presentation/widgets/review_page.dart';
import 'package:get_shoes/features/products/presentation/widgets/bottom_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _currentIndex = 0;
  Timer? _timer;
  String? selectedColor;
  String? selectedSize;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onColorSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
        backgroundColor: const Color.fromARGB(246, 255, 255, 255),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 22, right: 22, top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.width - 45,
                        width: MediaQuery.of(context).size.width - 45,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(181, 231, 231, 231),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            PageView.builder(
                              itemCount: product.imageUrl.length,
                              controller: PageController(viewportFraction: 1),
                              onPageChanged: (index) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Image.network(
                                    product.imageUrl[index],
                                    fit: BoxFit.contain,
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              bottom: 8,
                              left: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(product.imageUrl.length,
                                    (index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentIndex == index
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  );
                                }),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 10,
                              child: Container(
                                height: 40,
                                width: 132,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      product.imageUrl.length, (index) {
                                    setState(() {
                                      selectedColor = product.colors.first;
                                    });

                                    final colorName = product.colors[index];
                                    final color = _getColorFromName(colorName);
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedColor = colorName;
                                        });
                                        _onColorSelected(index);
                                      },
                                      child: Container(
                                        height: 27,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: color,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                        child: _currentIndex == index
                                            ? const Center(
                                                child: Icon(
                                                  Icons.check,
                                                  size: 14,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const SizedBox(),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      product.name,
                      style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.bold,
                        textStyle: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              Icons.star,
                              color: starIndex < product.averageRating
                                  ? const Color(0xffFCD240)
                                  : const Color.fromARGB(99, 158, 158, 158),
                              size: 16,
                            );
                          }),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          product.averageRating.toDouble().toString(),
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.bold,
                            textStyle: const TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "(${product.reviewsCount} Reviews)",
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                              fontSize: 11,
                              color: Color(0xffB7B7B7),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Size",
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: List.generate(product.sizes.length, (size) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedSize = product.sizes[size];
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: selectedSize == product.sizes[size]
                                      ? Colors.black
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.grey)),
                              child: Center(
                                child: Text(
                                  product.sizes[size],
                                  style: AppTextStyles.boldStyle14.copyWith(
                                      color: selectedSize == product.sizes[size]
                                          ? Colors.white
                                          : const Color(0xff6F6F6F)),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Description",
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      product.description,
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Review (${product.reviewsCount})",
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Reviews(product.id, product.averageRating),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
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
            const Positioned(
              top: 55,
              right: 10,
              child: CartIcon(),
            )
          ],
        ),
        bottomNavigationBar: BottomNavBar(
            product: product,
            selectedColor: selectedColor,
            selectedSize: selectedSize));
  }
}

Color _getColorFromName(String colorName) {
  final colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'pink': Colors.pink,
    'white': Colors.white,
    'black': Colors.black
    // Add more colors as needed
  };

  return colorMap[colorName.toLowerCase()] ??
      Colors.grey; // Default color if not found
}
