import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_shoes/core/const/app_text_styles.dart';
import 'package:get_shoes/features/products/data/repositories/review_repository_impl.dart';
import 'package:get_shoes/features/products/presentation/bloc/review_bloc.dart';
import 'package:get_shoes/features/products/presentation/bloc/review_state.dart';
import 'package:get_shoes/features/products/presentation/pages/all_reviews.dart';
import 'package:get_shoes/features/products/presentation/widgets/format_time.dart';

class Reviews extends StatelessWidget {
  String id;
  int averageRating;
  Reviews(this.id, this.averageRating, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReviewBloc(ReviewRepository())..add(FetchReview(id: id)),
      child: BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) {
          if (state is ReviewLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReviewLoaded) {
            return state.review.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Center(
                        child: Text(
                      "No Reviews Yet",
                      style: AppTextStyles.boldStyle14
                          .copyWith(color: const Color(0xffB7B7B7)),
                    )),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        state.review.length < 5 ? state.review.length : 5,
                    itemBuilder: (context, index) {
                      final review = state.review[index];
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://www.htgtrading.co.uk/wp-content/uploads/2016/03/no-user-image-square.jpg"),
                            ),
                            title: Text(
                              review.userId,
                              style: AppTextStyles.boldStyle14,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      Icons.star,
                                      color: starIndex < review.rating
                                          ? const Color(0xffFCD240)
                                          : const Color.fromARGB(
                                              99, 158, 158, 158),
                                      size: 16,
                                    );
                                  }),
                                ),
                                Text(
                                  review.comment,
                                  style: AppTextStyles.normalStyle12,
                                ),
                              ],
                            ),
                            trailing: Text(
                              formatTimestamp(review
                                  .date), // You can format the dateOfReview as needed
                              style: AppTextStyles.normalStyle12
                                  .copyWith(color: const Color(0xffB7B7B7)),
                            ),
                          ),
                          state.review.length == index + 1
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AllReviews(
                                                        reviews: state.review,
                                                        averageRating:
                                                            averageRating)));
                                      },
                                      child: Container(
                                          height: 43,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.4,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                            child: Text(
                                              "SEE ALL REVIEW",
                                              style: AppTextStyles.boldStyle14,
                                            ),
                                          ))),
                                )
                              : const SizedBox()
                        ],
                      );
                    },
                  );
          } else if (state is ReviewError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No products available'));
        },
      ),
    );
  }
}
