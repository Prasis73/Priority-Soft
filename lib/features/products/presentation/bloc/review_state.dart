import 'package:equatable/equatable.dart';
import 'package:get_shoes/features/products/data/models/review_model.dart';

abstract class ReviewState extends Equatable {
  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<Review> review;
  ReviewLoaded(this.review);

  @override
  List<Object> get props => [review];
}

class ReviewError extends ReviewState {
  final String message;
  ReviewError(this.message);

  @override
  List<Object> get props => [message];
}
