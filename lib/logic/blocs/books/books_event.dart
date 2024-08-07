part of 'books_bloc.dart';

sealed class BooksEvent {}

final class GetBooksEvent extends BooksEvent {}

final class AddBookEvent extends BooksEvent {
  final Book book;

  AddBookEvent(this.book);
}

final class EditBookEvent extends BooksEvent {
  final String id;
  final Book book;

  EditBookEvent(this.id, this.book);
}

final class DeleteBookEvent extends BooksEvent {
  final String id;

  DeleteBookEvent(this.id);
}
