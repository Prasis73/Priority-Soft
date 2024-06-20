import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_shoes/features/products/data/repositories/product_repository_impl.dart';
import 'package:get_shoes/features/products/presentation/bloc/discover_event.dart';
import 'package:get_shoes/features/products/presentation/bloc/discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final ProductRepository productRepository;

  DiscoverBloc(this.productRepository) : super(DiscoverInitial()) {
    on<FetchProducts>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      FetchProducts event, Emitter<DiscoverState> emit) async {
    emit(DiscoverLoading());
    try {
      final products =
          await productRepository.getProducts(filters: event.filters);
      emit(DiscoverLoaded(products, event.filters));
    } catch (e) {
      emit(DiscoverError(e.toString()));
    }
  }
}
