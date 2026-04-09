# Template Method Pattern

## What is it?

Think of it like a **recipe**.

Every recipe has the same structure: gather ingredients, cook, serve. The steps are always in the same order. But what you actually cook is different each time — pasta, soup, steak. The recipe is the **template**. The specific cooking is left to you.

- The **recipe structure** = Abstract Class (defines the fixed steps)
- The **specific dish** = Concrete Subclass (fills in the varying step)

The Template Method Pattern defines the skeleton of an algorithm in a base class and lets subclasses fill in only the parts that change.

## Structure

- **Abstract Class:** Defines the algorithm skeleton as a template method. Implements the shared steps. Declares the varying step as abstract.
- **Concrete Subclass:** Extends the abstract class and overrides only the varying step.

---

## The Problem

Look at the code in `problem/without_template_pattern.dart`.

We have two parsers — `CSVParser` and `JSONParser`. Both follow the same 3-step process: open file → parse → close file. Only the middle step (parsing) is different.

```dart
class CSVParser {
  void parse() {
    openFile();
    print("Parsing a CSV File"); // only this line differs
    closeFile();
  }

  void openFile() { print("Opening File"); }  // duplicated
  void closeFile() { print("Closing File"); } // duplicated
}

class JSONParser {
  void parse() {
    openFile();
    print("Parsing a JSON File"); // only this line differs
    closeFile();
  }

  void openFile() { print("Opening File"); }  // duplicated
  void closeFile() { print("Closing File"); } // duplicated
}
```

`openFile()` and `closeFile()` are **copy-pasted** in both classes. They do the exact same thing.

```
graph TD
    CSV["CSV Parser"]
    JSON["JSON Parser"]
    DL["openFile + closeFile (duplicated in both)"]
    CSV -- copies --> DL
    JSON -- copies --> DL
```

**What goes wrong?**

| Problem | Why it hurts |
|---|---|
| Code duplication | `openFile()` and `closeFile()` exist twice — same code in two places |
| Change in one place | If `openFile()` logic changes, you must update both `CSVParser` and `JSONParser` |
| Add `XMLParser`? | Copy-paste again. Now the same code lives in 3 places |

> **DRY Violation:** Don't Repeat Yourself — duplicating code means bugs and changes have to be fixed in multiple places.
>
> **SOLID Problem (SRP):** Each parser is managing both the shared steps (open/close) and its own specific logic. The shared steps should live in one place.

---

## The Solution — Template Method Pattern

Look at the code in `solution/template_pattern.dart`.

We create an abstract `DataParser` class. It defines the full algorithm as a template method: `parse()`. The shared steps (`readData`, `writeData`) are implemented once. The varying step (`processData`) is declared abstract — subclasses must fill it in.

```dart
abstract class DataParser {
  void readData() {
    print("Reading Data"); // shared — defined once
  }

  void processData(); // abstract — each subclass fills this in

  void writeData() {
    print("Writing Data"); // shared — defined once
  }

  void parse() {
    readData();    // step 1
    processData(); // step 2 — varies per subclass
    writeData();   // step 3
  }
}
```

Now `CSVParser` and `JSONParser` only override the one step that is actually different:

```dart
class CSVParser extends DataParser {
  @override
  void processData() {
    print('Parsing CSV Data'); // only the unique part
  }
}

class JSONParser extends DataParser {
  @override
  void processData() {
    print('Parsing JSON Data'); // only the unique part
  }
}
```

---

## Steps We Followed

### Step 1 — Identify the fixed steps vs the varying step

| Step | Fixed or Varies? |
|---|---|
| `readData()` | Fixed — same for every parser |
| `processData()` | Varies — different for CSV, JSON, XML |
| `writeData()` | Fixed — same for every parser |

---

### Step 2 — Create the Abstract Class with the template method

The `parse()` method is the **template** — it defines the order and structure. Subclasses cannot change this order.

```dart
void parse() {
  readData();    // always first
  processData(); // always second — but what it does depends on subclass
  writeData();   // always third
}
```

> Think of `parse()` as the recipe card. The order of steps is locked. Only the cooking part is yours to define.

---

### Step 3 — Subclasses override only the varying step

```dart
class CSVParser extends DataParser {
  @override
  void processData() => print('Parsing CSV Data');
}

class JSONParser extends DataParser {
  @override
  void processData() => print('Parsing JSON Data');
}
```

Adding `XMLParser`? Just extend `DataParser` and override `processData()`. The open and close logic is inherited automatically.

---

### Step 4 — Wire it together

```dart
CSVParser csvParser = CSVParser();
csvParser.parse();
// Reading Data
// Parsing CSV Data
// Writing Data

JSONParser jsonParser = JSONParser();
jsonParser.parse();
// Reading Data
// Parsing JSON Data
// Writing Data
```

---

## Before vs After

| | Without Pattern | With Template Method |
|---|---|---|
| `openFile()` / `closeFile()` | Copied into every parser class | Defined once in `DataParser` |
| Adding `XMLParser` | Copy-paste shared code again | Just extend and override `processData()` |
| Changing shared logic | Update every parser class | Update once in `DataParser` |
| Algorithm order | Each class defines its own order | Fixed in `parse()` — consistent everywhere |

---

## Key Insight

The template method (`parse()`) is declared in the parent and **never overridden**. It calls both fixed and abstract methods. Subclasses can only change the abstract steps — they cannot change the order or skip a step.

This is the opposite of Strategy. In Strategy, you swap out the entire algorithm from outside. In Template Method, the algorithm is fixed inside the parent — only small pieces are swapped by subclasses.

---

## Real-World Examples

- **Data Parsers** — Read → Parse → Write. The read/write steps are shared. Parsing logic differs per format (CSV, JSON, XML).
- **UI Frameworks** — Initialize → Draw → Finish. Every UI element follows this. Only `draw()` differs per element type.
- **Game Loop** — Initialize → Update → Render. The loop is the same for every game. What gets updated and rendered differs.
- **Report Generation** — Fetch data → Format → Export. Shared fetch and export, different formatting per report type.
- **Test Frameworks** — Setup → Run test → Teardown. The framework owns the order. You just write the test body.

---

## When to Use Template Method

| Need | Example |
|---|---|
| Multiple classes share the same algorithm structure | All parsers follow read → parse → write |
| Only a few steps differ between classes | Only `processData()` changes — open/close are the same |
| Prevent subclasses from changing the overall flow | `parse()` order must always be the same |
| Eliminate copy-pasted shared code | `openFile()` and `closeFile()` written once |
