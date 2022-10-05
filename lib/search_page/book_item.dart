import 'package:flutter/material.dart';
import 'package:tarea_3/book_details/book_detail.dart';

class BookItem extends StatelessWidget {
  final String imageURL;
  final String bookTitle;
  final String date;
  final String bookTotalPages;
  final String bookDescription;
  final String moreInfoLink;
  const BookItem(
      {super.key,
      required this.imageURL,
      required this.bookTitle,
      required this.date,
      required this.bookTotalPages,
      required this.bookDescription,
      required this.moreInfoLink});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetail(
                      bookImage: imageURL,
                      bookName: bookTitle,
                      date: date,
                      bookTotalPages: bookTotalPages,
                      bookDescription: bookDescription,
                      moreInfoLink: moreInfoLink,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 1.0)]),
            height: 200,
            width: 140,
            child: Image.network(
              imageURL,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              bookTitle,
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
    ;
  }
}
