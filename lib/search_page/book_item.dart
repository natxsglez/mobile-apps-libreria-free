// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tarea_3/book_details/book_detail.dart';

class BookItem extends StatelessWidget {
  final dynamic book;
  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BookDetail(book: book)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            decoration:
                BoxDecoration(boxShadow: const [BoxShadow(blurRadius: 1.0)]),
            height: 200,
            width: 140,
            child: Image.network(
              book.image,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              book.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          )
        ]),
      ),
    );
  }
}
