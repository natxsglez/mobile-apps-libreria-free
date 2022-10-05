// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarea_3/bloc/search_bloc.dart';
import 'package:tarea_3/search_page/search_results.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _bookInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Librería free to play'),
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 18.0, 8.0, 12.0),
          child: TextField(
            controller: _bookInputController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print("A buscar");
                    String bookSearchTerm = _bookInputController.text;
                    BlocProvider.of<SearchBloc>(context)
                        .add(Search(bookToSearch: bookSearchTerm));
                  },
                ),
                border: OutlineInputBorder(),
                label: Text("Ingresa un título")),
          ),
        ),
        Expanded(
          child:
              BlocConsumer<SearchBloc, SearchState>(builder: (context, state) {
            if (state is ResultsFoundState) {
              return _showListOfResults(context, state.booksList);
            } else if (state is LoadingSearchState) {
              return _showListOfResults(context, [], isLoading: true);
            }
            return _showInsertBookTitleToSearchText();
          }, listener: (context, state) {
            if (state is LoadingSearchState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Cargando resultados...")),
              );
            } else if (state is NoResultsFoundState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text("Lo sentimos, no se encontraron coincidencias")),
              );
              _bookInputController.clear();
            }
          }),
        )
      ]),
    );
  }

  Widget _showInsertBookTitleToSearchText() {
    return Expanded(
        child: Center(child: Text("Ingrese palabra para buscar libro")));
  }

  Widget _showListOfResults(context, List<dynamic> booksList,
      {bool isLoading = false}) {
    return SearchResults(
      booksList: booksList,
      isLoading: isLoading,
    );
  }
}
