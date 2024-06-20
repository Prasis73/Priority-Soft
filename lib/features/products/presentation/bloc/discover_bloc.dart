import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_shoes/features/products/data/repositories/product_repository_impl.dart';
import 'package:get_shoes/features/products/presentation/bloc/discover_event.dart';
import 'package:get_shoes/features/products/presentation/bloc/discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final ProductRepository productRepository;

  DiscoverBloc(this.productRepository) : super(DiscoverInitial()) {
    on<FetchProducts>(_mapEventToState);
    on<FetchMoreProducts>(_mapFetchMoreProductsToState);
  }

  Future<void> _mapEventToState(
      FetchProducts event, Emitter<DiscoverState> emit) async {
    emit(DiscoverLoading());
    try {
      final products =
          await productRepository.getProducts(filters: event.filters);
      final lastDocument =
          products.isNotEmpty ? products.last.documentSnapshot : null;
      emit(DiscoverLoaded(
        products: products,
        filters: event.filters,
        hasReachedMax: products.length < 10,
        lastDocument: lastDocument,
      ));
    } catch (e) {
      emit(DiscoverError(e.toString()));
    }
  }

  Future<void> _mapFetchMoreProductsToState(
      FetchMoreProducts event, Emitter<DiscoverState> emit) async {
    if (state is DiscoverLoaded) {
      final currentState = state as DiscoverLoaded;
      if (currentState.hasReachedMax) return;

      try {
        final products = await productRepository.getProducts(
          filters: event.filters,
          startAfter: currentState.lastDocument,
        );
        final lastDocument =
            products.isNotEmpty ? products.last.documentSnapshot : null;
        emit(products.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : DiscoverLoaded(
                products: currentState.products + products,
                filters: event.filters,
                hasReachedMax: products.length < 10,
                lastDocument: lastDocument,
              ));
      } catch (e) {
        emit(DiscoverError(e.toString()));
      }
    }
  }
}
