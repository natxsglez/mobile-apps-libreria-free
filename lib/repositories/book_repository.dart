// ignore_for_file: unused_element

import 'dart:convert';
import 'package:http/http.dart' as http;

class Book {
  final String bookImage;
  final String bookName;
  final String date;
  final String bookTotalPages;
  final String bookDescription;
  final String moreInfoLink;

  Book(
      {required this.bookImage,
      required this.bookName,
      required this.date,
      required this.bookTotalPages,
      required this.bookDescription,
      required this.moreInfoLink});

  String get image {
    return bookImage;
  }

  String get title {
    return bookName;
  }

  String get bookDate {
    return date;
  }

  String get pages {
    return bookTotalPages;
  }

  String get description {
    return bookDescription;
  }

  String get link {
    return moreInfoLink;
  }
}

class BookRepository {
  final String host = "www.googleapis.com";
  final String path = "/books/v1/volumes";
  final String scheme = "https";
  static final BookRepository bookRepository = BookRepository._internal();
  factory BookRepository() => bookRepository;

  BookRepository._internal();

  Future<dynamic> getBooks(String bookToSearch) async {
    dynamic res;
    dynamic booksResult;

    var booksReq = Uri(
        scheme: scheme,
        host: host,
        path: path,
        queryParameters: {"q": bookToSearch});
    try {
      res = await http.get(booksReq);
      res = jsonDecode(res.body);

      if (res["totalItems"] == 0) {
        return [];
      }
      booksResult = _fixArrayOfResults(res["items"]);
      return booksResult;
    } catch (error) {
      throw error;
    }
  }

  List<dynamic> _fixArrayOfResults(dynamic res) {
    List<dynamic> booksList = [];
    for (int index = 0; index < res.length; index++) {
      booksList.add(Book(
        bookImage: res[index]["volumeInfo"].containsKey("imageLinks")
            ? res[index]["volumeInfo"]["imageLinks"]["thumbnail"]
            : "https://cdn.pixabay.com/photo/2020/10/02/17/55/book-5621767_1280.png",
        bookName: res[index]["volumeInfo"]["title"],
        date: res[index]["volumeInfo"].containsKey("publishedDate")
            ? res[index]["volumeInfo"]["publishedDate"]
            : "-",
        bookTotalPages: res[index]["volumeInfo"].containsKey("pageCount")
            ? "${res[index]["volumeInfo"]["pageCount"]}"
            : "-",
        bookDescription: res[index]["volumeInfo"].containsKey("description")
            ? res[index]["volumeInfo"]["description"]
            : "-",
        moreInfoLink: res[index]["volumeInfo"]["infoLink"],
      ));
    }
    return booksList;
  }
}
