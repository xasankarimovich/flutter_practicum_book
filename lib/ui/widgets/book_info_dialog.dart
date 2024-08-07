import 'package:buksam_flutter_practicum/data/models/book.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookInfoDialog extends StatelessWidget {
  final Book book;
  const BookInfoDialog({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(book.title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Author name: ${book.author}"),
          Text(
            "Published date: ${DateFormat("d MMMM, y").format(book.publishedDate)}",
          ),
          const Text("Book facts:"),
          ...(List.generate(book.facts.length, (index) {
            return Text("${index + 1}. ${book.facts[index]}");
          }).toList())
        ],
      ),
    );
  }
}
