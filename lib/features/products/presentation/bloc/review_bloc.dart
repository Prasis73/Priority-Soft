import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_shoes/features/products/data/repositories/review_repository_impl.dart';
import 'package:get_shoes/features/products/presentation/bloc/review_state.dart';

part 'review_event.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository reviewRepository;

  ReviewBloc(this.reviewRepository) : super(ReviewInitial()) {
    on<FetchReview>(_mapEventToState);
  }
  Future<void> _mapEventToState(
      FetchReview event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      final reviews = await reviewRepository.getReview(id: event.id);
      emit(ReviewLoaded(reviews));
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }
}
