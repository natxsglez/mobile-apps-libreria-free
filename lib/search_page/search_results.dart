import 'package:flutter/material.dart';
import 'package:tarea_3/search_page/book_item.dart';

class SearchResults extends StatelessWidget {
  final List<dynamic> booksList;
  const SearchResults({super.key, required this.booksList});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
