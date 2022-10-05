// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetail extends StatefulWidget {
  final String bookImage;
  final String bookName;
  final String date;
  final String bookTotalPages;
  final String bookDescription;
  final String moreInfoLink;
  const BookDetail(
      {super.key,
      required this.bookImage,
      required this.bookName,
      required this.date,
      required this.bookTotalPages,
      required this.bookDescription,
      required this.moreInfoLink});

  @override
  State<BookDetail> createState() => _BookDetailState(
      bookImage: bookImage,
      bookName: bookName,
      date: date,
      bookTotalPages: bookTotalPages,
      bookDescription: bookDescription,
      moreInfoLink: moreInfoLink);
}

class _BookDetailState extends State<BookDetail> {
  final String bookImage;
  final String bookName;
  final String date;
  final String bookTotalPages;
  final String bookDescription;
  final String moreInfoLink;

  _BookDetailState({
    required this.bookName,
    required this.bookImage,
    required this.date,
    required this.bookTotalPages,
    required this.bookDescription,
    required this.moreInfoLink,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles del libro'), actions: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.earthAmericas),
          onPressed: () {
            _launchUrl();
          },
        ),
        IconButton(
            onPressed: () {
              Share.share('Mira este libro $moreInfoLink');
            },
            icon: Icon(Icons.share))
      ]),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: SizedBox(
              height: 300,
              width: 200,
              child: Image.network(
                bookImage,
                fit: BoxFit.fill,
              )),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            bookName,
            style: TextStyle(fontSize: 36),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                date,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "Páginas: $bookTotalPages",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                bookDescription,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(fontStyle: FontStyle.italic),
              )
            ],
          ),
        )
      ]),
    );
  }

  void _launchUrl() async {
    Uri parsedUrl = Uri.parse(moreInfoLink);
    if (!await canLaunchUrl(parsedUrl)) {
      throw 'Could not launch $moreInfoLink';
    } else {
      launchUrl(
        parsedUrl,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
