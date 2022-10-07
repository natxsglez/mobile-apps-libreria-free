// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetail extends StatefulWidget {
  final dynamic book;
  const BookDetail({super.key, required this.book});

  @override
  State<BookDetail> createState() => _BookDetailState(book: book);
}

class _BookDetailState extends State<BookDetail> {
  final dynamic book;
  bool _readMore = false;

  _BookDetailState({required this.book});
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
              Share.share('Mira este libro ${book.link}');
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
                book.image,
                fit: BoxFit.fill,
              )),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: _createTextWidget(book.title, TextStyle(fontSize: 36),
              alignment: TextAlign.center),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createTextWidget(book.bookDate,
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              _createTextWidget(
                  "Páginas: ${book.pages}", TextStyle(fontSize: 18)),
              GestureDetector(
                  onTap: () {
                    _readMore = !_readMore;
                    setState(() {});
                  },
                  child: _readMoreText()),
            ],
          ),
        )
      ]),
    );
  }

  Text _createTextWidget(String text, TextStyle style,
      {TextAlign? alignment = null}) {
    return Text(
      text,
      style: style,
      textAlign: alignment,
    );
  }

  Widget _readMoreText() {
    return SizedBox(
      height: 220,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(
            book.description,
            maxLines: _readMore ? 100 : 6,
            overflow: _readMore ? null : TextOverflow.ellipsis,
            style: TextStyle(fontStyle: FontStyle.italic),
          )),
    );
  }

  void _launchUrl() async {
    Uri parsedUrl = Uri.parse(book.link);
    if (!await canLaunchUrl(parsedUrl)) {
      throw 'Could not launch ${book.link}';
    } else {
      launchUrl(
        parsedUrl,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
