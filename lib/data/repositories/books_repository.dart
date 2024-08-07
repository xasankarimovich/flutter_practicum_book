import 'package:buksam_flutter_practicum/data/models/book.dart';
import 'package:buksam_flutter_practicum/data/services/firebase_book_service.dart';

class BooksRepository {
  final FirebaseBookService _firebaseBookService;

  BooksRepository({required FirebaseBookService firebaseBookService})
      : _firebaseBookService = firebaseBookService;

  Stream<List<Book>> getBooks() {
    return _firebaseBookService.getBooks();
  }

  Future<void> addBook(Book book) async {
    await _firebaseBookService.addBook(book);
  }

  Future<void> editBook(String id, Book book) async {
    await _firebaseBookService.editBook(id, book);
  }

  Future<void> deleteBook(String id) async {
    await _firebaseBookService.deleteBook(id);
  }
}
