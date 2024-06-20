import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_shoes/features/products/data/models/product_model.dart';

abstract class DiscoverState extends Equatable {
  @override
  List<Object> get props => [];
}

class DiscoverInitial extends DiscoverState {}

class DiscoverLoading extends DiscoverState {}

/* class DiscoverLoaded extends DiscoverState {
  final List<Product> products;
  final Map<String, dynamic>? filters;
  DiscoverLoaded(this.products, this.filters);

  @override
  List<Object> get props => [products, filters ?? {}];
} */
class DiscoverLoaded extends DiscoverState {
  final List<Product> products;
  final Map<String, dynamic>? filters;
  final bool hasReachedMax;
  final DocumentSnapshot? lastDocument;

  DiscoverLoaded({
    required this.products,
    this.filters,
    this.hasReachedMax = false,
    this.lastDocument,
  });

  DiscoverLoaded copyWith({
    List<Product>? products,
    Map<String, dynamic>? filters,
    bool? hasReachedMax,
    DocumentSnapshot? lastDocument,
  }) {
    return DiscoverLoaded(
      products: products ?? this.products,
      filters: filters ?? this.filters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      lastDocument: lastDocument ?? this.lastDocument,
    );
  }

  @override
  List<Object> get props => [products, filters ?? {}, hasReachedMax];
}

class DiscoverError extends DiscoverState {
  final String message;
  DiscoverError(this.message);

  @override
  List<Object> get props => [message];
}
