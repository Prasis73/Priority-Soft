part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchReview extends ReviewEvent {
  final String? id;

  FetchReview({this.id});
}
