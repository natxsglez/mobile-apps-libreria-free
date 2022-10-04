// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarea_3/bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _bookInputController = TextEditingController();
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
                  onPressed: () {},
                ),
                border: OutlineInputBorder(),
                label: Text("Ingresa un título")),
          ),
        ),
        BlocConsumer<SearchBloc, SearchState>(
            builder: SearchBloc,
            listener: (context, state) {
              if (state is SearchInitial) {
                // return textfield con texto que pide ingresar busqueda
              } else if (state is ResultsFoundState) {
                // return list with all thre results
              } else if (state is NoResultsFoundState) {
                // return something c:
              }
            })
      ]),
    );
  }
}
