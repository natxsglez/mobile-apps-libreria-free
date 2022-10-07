// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tarea_3/search_page/book_item.dart';
import 'package:shimmer/shimmer.dart';

class SearchResults extends StatelessWidget {
  final List<dynamic> booksList;
  final isLoading;
  const SearchResults(
      {super.key, this.booksList = const [], this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return isLoading ? _loadResultsListWidget() : _showResultsList();
  }

  GridView _showResultsList() {
    return GridView.count(
        childAspectRatio: 0.76,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        crossAxisCount: 2,
        children: List.generate(booksList.length, (index) {
          return BookItem(book: booksList[index]);
        }));
  }

  Shimmer _loadResultsListWidget() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.count(
          childAspectRatio: 0.76,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          crossAxisCount: 2,
          children: List.generate(8, (index) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(boxShadow: [BoxShadow(blurRadius: 1.0)]),
                    height: 200,
                    width: 140,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(blurRadius: 1.0)]),
                        height: 20,
                        width: 160,
                      ))
                ]);
          }),
        ));
  }
}
