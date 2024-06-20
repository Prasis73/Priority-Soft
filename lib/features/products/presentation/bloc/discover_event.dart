import 'package:equatable/equatable.dart';

abstract class DiscoverEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProducts extends DiscoverEvent {
  final Map<String, dynamic>? filters;

  FetchProducts({this.filters});
  @override
  List<Object> get props => [filters ?? {}];
}

class FetchMoreProducts extends DiscoverEvent {
  final Map<String, dynamic>? filters;
  FetchMoreProducts({this.filters});
  @override
  List<Object> get props => [filters ?? {}];
}
