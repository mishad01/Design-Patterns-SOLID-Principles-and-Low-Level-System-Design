**L – Liskov Substitution Principle**

The Liskov Substitution Principle (LSP) states that objects of a superclass should be replaceable with objects of a subclass without altering the correctness of the program. It ensures that a subclass can stand in for its parent class and function correctly in any context that expects the parent class.

---

## Problem (Violates LSP):

```dart
class Bird {
  void eat() {
    print('Bird eating');
  }

  void fly() {
    print('Bird flying');
  }
}

class Ostrich extends Bird {
  @override
  void eat() {
    print('Ostrich eating');
  }

  @override
  void fly() {
    throw UnsupportedError('Ostriches cannot fly');
  }
}
```

**Why this violates LSP:**
- Ostrich inherits from Bird but cannot fulfill the contract of the `fly()` method
- If we treat Ostrich as a Bird and call `fly()`, it throws an exception
- The subclass (Ostrich) cannot be safely substituted for its parent class (Bird)
- This breaks the fundamental promise: "subclasses should be usable wherever their parent class is expected"


---

## Another Example (File Operations):

### Problem (Violates LSP):

```dart
class File {
  void read() {
    print('Reading file');
  }

  void write() {
    print('Writing to file');
  }
}

// ReadOnlyFile cannot write but inherits write contract
class ReadOnlyFile extends File {
  @override
  void read() {
    print('Reading read-only file');
  }

  @override
  void write() {
    throw UnsupportedError('Cannot write to read-only file');
  }
}

void main() {
  File file = ReadOnlyFile();
  file.read();  // Works fine
  file.write(); // Throws error! - LSP violated
}
```

**Why this violates LSP:**
- ReadOnlyFile cannot fulfill the contract of File's `write()` method
- Code expecting a File will crash if it attempts to write to a ReadOnlyFile
- The subclass breaks the expected behavior contract
- We cannot safely substitute ReadOnlyFile wherever File is expected

### Solution (Follows LSP):

```dart
// Base file interface - read-only operations
abstract class FileOperation {
  void read();
}

// Interface for writable operations
abstract class WritableFileOperation extends FileOperation {
  void write();
}

// Read-only file - only implements read
class ReadOnlyFile implements FileOperation {
  @override
  void read() {
    print('Reading read-only file');
  }
}

// Read-Write file - implements both interfaces
class ReadWriteFile implements WritableFileOperation {
  @override
  void read() {
    print('Reading file');
  }

  @override
  void write() {
    print('Writing to file');
  }
}

void main() {
  // Safe usage with FileOperation
  List<FileOperation> readableFiles = [ReadOnlyFile(), ReadWriteFile()];
  
  for (FileOperation file in readableFiles) {
    file.read(); // All can read safely
  }
  
  print('---');
  
  // Safe usage with WritableFileOperation
  List<WritableFileOperation> writableFiles = [ReadWriteFile()];
  
  for (WritableFileOperation file in writableFiles) {
    file.write(); // Only writable files can write
  }
}
```

**Benefits:**
- ReadOnlyFile doesn't inherit methods it can't implement
- Only files that support writing implement WritableFileOperation
- No forced exception throwing or breaking behavior contracts
- Clear separation of concerns between read-only and read-write operations
- Complete substitutability: any ReadOnlyFile can replace FileOperation, any ReadWriteFile can replace WritableFileOperation

