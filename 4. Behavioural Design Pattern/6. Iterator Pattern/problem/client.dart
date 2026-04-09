import 'book.dart';
import 'book_collection.dart';

void main() {
  BookCollection bookCollection = BookCollection();
  bookCollection.addBook(Book('C++ Book'));
  bookCollection.addBook(Book('Java Book'));
  bookCollection.addBook(Book('Dart Book'));
  bookCollection.addBook(Book('Python Book'));

  //print(bookCollection.getBooks());

  for (var book in bookCollection.getBooks()) {
    print(book.title);
  }
}


/*
Problems in our Code
Problems:
● The client needs to know the internal structure of the collection (array in this
case).
● If we change the collection type (e.g., from an array to a linked list), we would
need to modify the client code.
● It’s harder to implement different traversal strategies.
 */