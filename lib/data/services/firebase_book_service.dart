import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/book.dart';

class FirebaseBookService {
  final _bookCollection = FirebaseFirestore.instance.collection("books");

  Stream<List<Book>> getBooks() {
    // birinchi return'da collection ichiga kiryapmiz (table)
    return _bookCollection.snapshots().map((querySnapshot) {
      // ikkinchi return'da collection ichidagi hujjatlarga kiryapmiz (rows)
      return querySnapshot.docs.map((doc) {
        // uchinchi return'da har bitta hujjatni (row)
        // Book obyektiga aylantiryapmiz
        return Book.fromMap(doc.data());
      }).toList();
    });
  }

  Future<void> addBook(Book book) async {
    try {
      await _bookCollection.add(book.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editBook(String id, Book book) async {
    try {
      await _bookCollection.doc(id).update(book.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteBook(String id) async {
    try {
      await _bookCollection.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
