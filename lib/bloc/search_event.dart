part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class Search extends SearchEvent {
  final String bookToSearch;
  Search({required this.bookToSearch});

  @override
  List<dynamic> get props => [bookToSearch];
}
