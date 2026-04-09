import 'book.dart';
import 'iterator.dart';

class BookCollection {
  final List<Book> books = [];

  void addBook(Book book) {
    books.add(book);
  }

  List<Book> getBooks() => books;

  Iterator<Book> createIterator() {
    return BookIterator(this.books);
  }
}

class BookIterator implements Iterator<Book> {
  final List<Book> books;
  int position = 0;

  BookIterator(this.books);

  @override
  bool hasNext() {
    return position < books.length;
  }

  @override
  Book next() {
    return books[position++];
  }
}
