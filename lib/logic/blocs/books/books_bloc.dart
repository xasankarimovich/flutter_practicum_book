import 'package:buksam_flutter_practicum/data/models/book.dart';
import 'package:buksam_flutter_practicum/data/repositories/books_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BooksRepository _booksRepository;

  BooksBloc({required BooksRepository booksRepository})
      : _booksRepository = booksRepository,
        super(InitialBookState()) {
    on<GetBooksEvent>(_getBooks);
    on<AddBookEvent>(_addBook);
    on<EditBookEvent>(_editBook);
    on<DeleteBookEvent>(_deleteBook);
  }

  void _getBooks(GetBooksEvent event, Emitter<BooksState> emit) async {
    emit(LoadingBookState());
    try {
      emit.forEach(
        _booksRepository.getBooks(),
        onData: (List<Book> books) {
          return LoadedBookState(books);
        },
      );
    } catch (e) {
      emit(ErrorBookState(e.toString()));
    }
  }

  void _addBook(AddBookEvent event, Emitter<BooksState> emit) async {
    emit(LoadingBookState());
    try {
      await _booksRepository.addBook(event.book);
      emit(InitialBookState());
    } catch (e) {
      emit(ErrorBookState(e.toString()));
    }
  }

  void _editBook(EditBookEvent event, Emitter<BooksState> emit) async {
    emit(LoadingBookState());
    try {
      await _booksRepository.editBook(event.id, event.book);
    } catch (e) {
      emit(ErrorBookState(e.toString()));
    }
  }

  void _deleteBook(DeleteBookEvent event, Emitter<BooksState> emit) async {
    emit(LoadingBookState());
    try {
      await _booksRepository.deleteBook(event.id);
    } catch (e) {
      emit(ErrorBookState(e.toString()));
    }
  }
}
