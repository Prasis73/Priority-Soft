import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_shoes/features/products/data/models/product_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    String img = "${product.brand}.svg";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 165,
          width: 165,
          decoration: BoxDecoration(
            color: const Color.fromARGB(181, 231, 231, 231),
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 6.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/svg/$img',
                          fit: BoxFit.contain,
                        ))),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Image.network(
                    product.imageUrl[0],
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          product.name,
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w500,
            textStyle: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.yellow, size: 16),
            const SizedBox(
              width: 2,
            ),
            Text(
              '${product.averageRating.toDouble()}',
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
              '(${product.reviewsCount} Reviews)',
              style: GoogleFonts.urbanist(
                color: Colors.grey,
                textStyle: const TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
        Text(
          '\$${double.parse(product.price.toString())}',
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.bold,
            textStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
