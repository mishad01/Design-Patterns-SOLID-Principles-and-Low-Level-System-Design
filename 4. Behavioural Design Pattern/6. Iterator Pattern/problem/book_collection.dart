import 'book.dart';

class BookCollection {
  List<Book> books = [];
  void addBook(Book book) {
    books.add(book);
  }

  List<Book> getBooks() {
    return books;
  }
}
