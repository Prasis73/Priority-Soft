import 'package:equatable/equatable.dart';
import 'package:get_shoes/features/products/data/models/product_model.dart';

abstract class DiscoverState extends Equatable {
  @override
  List<Object> get props => [];
}

class DiscoverInitial extends DiscoverState {}

class DiscoverLoading extends DiscoverState {}

class DiscoverLoaded extends DiscoverState {
  final List<Product> products;
  final Map<String, dynamic>? filters;
  DiscoverLoaded(this.products, this.filters);

  @override
  List<Object> get props => [products, filters ?? {}];
}

class DiscoverError extends DiscoverState {
  final String message;
  DiscoverError(this.message);

  @override
  List<Object> get props => [message];
}
