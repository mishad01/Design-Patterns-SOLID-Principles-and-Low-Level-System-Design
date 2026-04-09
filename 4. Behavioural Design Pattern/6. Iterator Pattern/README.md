# Iterator Pattern

## What is it?

Think of it like a **TV remote with next/previous buttons**.

You do not need to know how many channels exist or how they are stored inside the TV. You just press **Next** and the TV handles the traversal. The remote gives you a uniform way to go through all channels without opening up the TV.

- The **remote** = Iterator (gives you `hasNext()` and `next()`)
- The **TV's channel list** = Collection (holds the elements)
- **You** = Client (traverses without knowing the internal structure)

The Iterator Pattern provides a standard way to walk through a collection without exposing how it stores its elements internally.

## Structure

- **Iterator:** Interface with `hasNext()` and `next()` methods.
- **Concrete Iterator:** Implements the Iterator interface and tracks the current position.
- **Collection (Iterable):** Holds elements and creates an iterator via `createIterator()`.

---

## The Problem

```dart
class BookCollection {
  List<Book> books = [];

  void addBook(Book book) {
    books.add(book);
  }

  List<Book> getBooks() {
    return books; // exposes internal structure
  }
}
```

The client loops over the collection directly:

```dart
for (var book in bookCollection.getBooks()) {
  print(book.title); // client knows it's a List
}
```

```
graph TD
    C["Client"]
    BC["Book Collection"]
    C -- accesses internal list of --> BC
```

**What goes wrong:**

| Problem | Why it hurts |
|---|---|
| Client knows internal structure | If you switch from `List` to `LinkedList` or a `Set`, client code breaks |
| No traversal flexibility | You cannot easily add reverse iteration, filtered iteration, etc. without touching the client |
| Collection is forced to expose internals | `getBooks()` leaks the raw list — the client can even mutate it |

> **OOP Problem (Encapsulation):** The collection leaks its internal data structure. The client is now coupled to `List<Book>` specifically.
>
> **SOLID Problem (OCP):** Changing the internal storage type requires modifying the client code — open for modification when it should not be.
>
> **SOLID Problem (SRP):** The client is taking on the responsibility of knowing how to traverse the collection.

---

## The Solution — Iterator Pattern

We introduce an `Iterator<T>` interface. The collection creates and returns a concrete iterator. The client only talks to the iterator — never to the collection's internals.

| Role | In Our Example | What it does |
|---|---|---|
| **Iterator** (interface) | `Iterator<T>` | Defines `hasNext()` and `next()` |
| **Concrete Iterator** | `BookIterator` | Tracks position and implements traversal |
| **Collection** | `BookCollection` | Holds books, creates a `BookIterator` |
| **Client** | `main()` | Uses iterator — never sees the internal list |

---

## Steps We Followed

### Step 1 — Create the Iterator interface

```dart
abstract class Iterator<T> {
  bool hasNext();
  T next();
}
```

> Generic interface. Works for any collection type. Every concrete iterator must implement these two methods.

---

### Step 2 — Create the Concrete Iterator

```dart
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
```

> Keeps track of `position` internally. The client never touches it. You could swap this out for a reverse iterator or a filtered one without touching anything else.

---

### Step 3 — Update the Collection to create an Iterator

```dart
class BookCollection {
  final List<Book> books = [];

  void addBook(Book book) {
    books.add(book);
  }

  Iterator<Book> createIterator() {
    return BookIterator(books); // returns an iterator, not the list
  }
}
```

> `getBooks()` is gone. The collection no longer exposes its internals. `createIterator()` hands out a controlled traversal object instead.

---

### Step 4 — Use the Iterator in the client

```dart
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
```

> The client only calls `hasNext()` and `next()`. It does not know or care whether books are stored in a `List`, a `Map`, a database, or anything else.

---

## Before vs After

| | Without Pattern | With Iterator Pattern |
|---|---|---|
| Client knows internal structure? | Yes — iterates directly over a `List<Book>` | No — only uses `Iterator<Book>` |
| Change internal storage | Client code must be rewritten | Only `BookIterator` changes |
| Multiple traversal strategies | Hard — must expose new getters | Easy — create a new iterator class |
| Encapsulation | Broken — internal list exposed via `getBooks()` | Preserved — `createIterator()` is the only way in |

---

## Key Insight

The iterator is a cursor. It sits between the client and the collection, moving through elements one by one. The client does not need to know what is behind the curtain — List, LinkedList, tree, database result set. As long as there is an iterator, the client works the same way.

This is why Java's `for-each` loop, Python's `for ... in`, and Dart's `Iterable` all work the same regardless of whether you are iterating a list, a set, or a custom data structure.

---

## Real-World Examples

- **Dart `Iterable`** — Every `List`, `Set`, and `Map` in Dart implements `Iterable`. You write `for (var x in collection)` without caring about the internal type.
- **Java `Iterator`** — `ArrayList`, `LinkedList`, and custom collections all return an `Iterator`. The for-each loop uses this behind the scenes.
- **Database cursors** — A cursor lets you walk through query results row by row without loading everything into memory at once.
- **File system traversal** — OS iterators walk directory trees. You call `next()` to get the next file — you do not manage the stack or recursion yourself.
- **Pagination APIs** — A page cursor lets clients request the next page without knowing how the server stores or indexes records.

---

## When to Use Iterator

| Need | Example |
|---|---|
| Traverse a collection without exposing internals | Client should not know if it's a List or LinkedList |
| Multiple traversal strategies on the same collection | Forward, backward, filtered — each is its own iterator |
| Uniform traversal interface across different collections | Walk a `BookCollection` and a `MagazineCollection` the same way |
| Lazy traversal (large or infinite sequences) | Database cursor, stream — only fetch what you need |