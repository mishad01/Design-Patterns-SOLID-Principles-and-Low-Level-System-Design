import 'book.dart';
import 'book_collection.dart';
import 'iterator.dart';

void main() {
  BookCollection bookCollection = BookCollection();
  bookCollection.addBook(Book('C++ Book'));
  bookCollection.addBook(Book('Java Book'));
  bookCollection.addBook(Book('Dart Book'));
  bookCollection.addBook(Book('Python Book'));

  Iterator<Book> iterator = bookCollection.createIterator();
  while (iterator.hasNext()) {
    Book book = iterator.next();
    print(book.title);
  }
}

/*
Iterator Pattern
Problem: How to access elements in a collection without exposing its internal
representation.
Solution: The Iterator Pattern provides a way to traverse a collection without
revealing its underlying structure, offering a uniform interface for traversal.
Structure:
● Iterator: Interface for traversing a collection.
● Collection: Holds the elements and provides an iterator.
 */
