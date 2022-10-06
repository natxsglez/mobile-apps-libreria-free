import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final String host = "www.googleapis.com";
  final String path = "/books/v1/volumes";
  final String scheme = "https";

  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>(_searchBooks);
  }

  Future<FutureOr<void>> _searchBooks(event, emit) async {
    emit(LoadingSearchState());
    dynamic booksResult;
    var booksReq = Uri(
        scheme: scheme,
        host: host,
        path: path,
        queryParameters: {"q": event.bookToSearch});

    try {
      emit(LoadingSearchState());
      dynamic res = await http.get(booksReq);
      booksResult = jsonDecode(res.body);
      if (booksResult["totalItems"] == 0) {
        emit(NoResultsFoundState());
      } else {
        emit(ResultsFoundState(booksList: booksResult["items"]));
      }
    } catch (error) {
      emit(ErrorFoundState());
    }
  }
}
