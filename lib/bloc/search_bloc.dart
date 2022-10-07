import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tarea_3/repositories/book_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final BookRepository _bookRepository = BookRepository();

  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>(_searchBooks);
  }

  Future<FutureOr<void>> _searchBooks(event, emit) async {
    emit(LoadingSearchState());

    try {
      dynamic res = await _bookRepository.getBooks(event.bookToSearch);
      print(res);
      if (res.length == 0) {
        emit(NoResultsFoundState());
      } else {
        emit(ResultsFoundState(booksList: res));
      }
    } catch (error) {
      emit(ErrorFoundState());
    }
  }
}
