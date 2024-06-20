import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_shoes/core/const/app_text_styles.dart';
import 'package:get_shoes/features/products/data/models/review_model.dart';
import 'package:intl/intl.dart';

class AllReviews extends StatefulWidget {
  List<Review> reviews;
  int averageRating;
  AllReviews({super.key, required this.reviews, required this.averageRating});

  @override
  State<AllReviews> createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> {
  int? selectedRating;

  List<Review> get filteredReviews {
    if (selectedRating == null) {
      return widget.reviews;
    } else {
      return widget.reviews
          .where((review) => review.rating == selectedRating)
          .toList();
    }
  }

  void updateFilter(int? rating) {
    setState(() {
      selectedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
          child: Text(
            'Review (${widget.reviews.length})',
            style: AppTextStyles.semiBoldStyle16,
          ),
        ),
        actions: [
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow),
              Text(
                widget.averageRating.toDouble().toString(),
                style: AppTextStyles.boldStyle14,
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilterButton(
                    label: 'All',
                    isSelected: selectedRating == null,
                    onTap: () => updateFilter(null),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FilterButton(
                    label: '5 Stars',
                    isSelected: selectedRating == 5,
                    onTap: () => updateFilter(5),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FilterButton(
                    label: '4 Stars',
                    isSelected: selectedRating == 4,
                    onTap: () => updateFilter(4),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FilterButton(
                    label: '3 Stars',
                    isSelected: selectedRating == 3,
                    onTap: () => updateFilter(3),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FilterButton(
                    label: '2 Stars',
                    isSelected: selectedRating == 2,
                    onTap: () => updateFilter(2),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FilterButton(
                    label: '1 Stars',
                    isSelected: selectedRating == 1,
                    onTap: () => updateFilter(1),
                  ),
                ],
              ),
            ),
          ),
          filteredReviews.isEmpty
              ? Center(
                  child: Text(
                  "No Reviews",
                  style: AppTextStyles.semiBoldStyle16
                      .copyWith(color: Colors.grey),
                ))
              : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredReviews.length,
                    itemBuilder: (context, index) {
                      final review = filteredReviews[index];
                      return ListTile(
                        leading: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://www.htgtrading.co.uk/wp-content/uploads/2016/03/no-user-image-square.jpg",
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          review.userId,
                          style: AppTextStyles.boldStyle14,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: List.generate(5, (starIndex) {
                                return Icon(
                                  Icons.star,
                                  color: starIndex < review.rating
                                      ? const Color(0xffFCD240)
                                      : const Color.fromARGB(99, 158, 158, 158),
                                  size: 16,
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              review.comment,
                              style: AppTextStyles.regularstyle14,
                            ),
                          ],
                        ),
                        trailing: Column(
                          children: [
                            Text(
                              formatTimestamp(review
                                  .date), // You can format the dateOfReview as needed
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: Text(
            label,
            style: AppTextStyles.boldStyle20
                .copyWith(color: isSelected ? Colors.black : Colors.grey),
          ),
        ));
  }
}

String formatTimestamp(Timestamp timestamp) {
  DateTime date = timestamp.toDate();
  DateTime now = DateTime.now();
  DateTime tomorrow = now.add(const Duration(days: 1));

  // Normalize dates to remove time part
  DateTime normalizedDate = DateTime(date.year, date.month, date.day);
  DateTime normalizedNow = DateTime(now.year, now.month, now.day);
  DateTime normalizedTomorrow =
      DateTime(tomorrow.year, tomorrow.month, tomorrow.day);

  if (normalizedDate == normalizedNow) {
    return 'Today';
  } else if (normalizedDate == normalizedTomorrow) {
    return 'Tomorrow';
  } else {
    return DateFormat('dd/MM').format(date);
  }
}
