part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class ResultsFoundState extends SearchState {
  final List<dynamic> booksList;

  const ResultsFoundState({required this.booksList});

  @override
  List<Object> get props => [booksList];
}

class NoResultsFoundState extends SearchState {
  final bool showNoResultsFoundMessage;

  const NoResultsFoundState({required this.showNoResultsFoundMessage});

  @override
  List<Object> get props => [showNoResultsFoundMessage];
}
