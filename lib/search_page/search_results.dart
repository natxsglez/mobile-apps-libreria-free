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
    print("${isLoading}");
    return isLoading
        ? Shimmer.fromColors(
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
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(blurRadius: 1.0)]),
                          height: 200,
                          width: 140,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              width: 80,
                            ))
                      ]);
                })),
          )
        : GridView.count(
            childAspectRatio: 0.76,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(booksList.length, (index) {
              String imageURL = booksList[index]["volumeInfo"]
                      .containsKey("imageLinks")
                  ? booksList[index]["volumeInfo"]["imageLinks"]["thumbnail"]
                  : "https://cdn.pixabay.com/photo/2020/10/02/17/55/book-5621767_1280.png";
              String totalPages =
                  booksList[index]["volumeInfo"].containsKey("pageCount")
                      ? "${booksList[index]["volumeInfo"]["pageCount"]}"
                      : "El total de páginas no se encuentra disponible";
              String bookDescription =
                  booksList[index]["volumeInfo"].containsKey("description")
                      ? booksList[index]["volumeInfo"]["description"]
                      : "No hay descripción disponible";
              return BookItem(
                imageURL: imageURL,
                bookTitle: booksList[index]["volumeInfo"]["title"],
                date: booksList[index]["volumeInfo"]["publishedDate"],
                bookTotalPages: totalPages,
                bookDescription: bookDescription,
                moreInfoLink: booksList[index]["volumeInfo"]["infoLink"],
              );
            }));
  }
}
