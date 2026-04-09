class Book {
  String title;

  Book(this.title);

  String getTitle() {
    return title;
  }
}


/*
import 'book.dart';
import 'iterator.dart';

class BookCollection {
  List<Book> books = [];

  void addBook(Book book) {
    books.add(book);
  }

  List<Book> getBooks() => books;
  BookIterator createIterator() {
    return BookIterator(books);
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

 */