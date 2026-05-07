# Prototype Pattern

## What is it?

Think of it like **using a document template**.

When your company needs a new contract, nobody types it from scratch. Someone opens the master template, hits "duplicate", and edits only the parts that change — the client name, the date, the specific terms. The original template stays untouched. The copy starts identical and diverges only where it needs to.

- The **master template** = Prototype (`Shape` — the object that knows how to clone itself)
- **Hitting duplicate** = calling `clone()` (produces an independent copy)
- The **new contract** = the cloned object (same structure, independently editable)

The Prototype Pattern creates new objects by copying an existing object rather than constructing from scratch. The object itself is responsible for defining what "copy" means.

## Structure

- **Prototype (interface):** Declares the `clone()` method.
- **Concrete Prototype:** Implements `clone()` — knows exactly how to copy its own internal state.
- **Client:** Asks the prototype to clone itself instead of calling a constructor directly.

---

## The Problem

```dart
class Circle {
  double radius;
  String color;
  List<double> coordinates; // expensive to compute — e.g., derived from a map projection

  Circle({
    required this.radius,
    required this.color,
    required this.coordinates,
  });
}

class Rectangle {
  double width;
  double height;
  String color;
  List<double> coordinates;

  Rectangle({
    required this.width,
    required this.height,
    required this.color,
    required this.coordinates,
  });
}

void main() {
  final original = Circle(
    radius: 10,
    color: 'red',
    coordinates: expensiveProjection(), // slow — must be recomputed every time
  );

  // Want a similar circle in blue? Must re-pass all fields — including the expensive ones
  final copy = Circle(
    radius: original.radius,
    color: 'blue',
    coordinates: original.coordinates, // shallow — changes to copy affect original!
    // What if Circle gets a new field? This line silently forgets it.
  );
}
```

```
graph TD
    Client["Client"]
    Circle["Circle (constructor)"]
    Rect["Rectangle (constructor)"]
    Client -- new Circle(...all fields...) --> Circle
    Client -- new Rectangle(...all fields...) --> Rect
```

**What goes wrong:**

| Problem | Why it hurts |
|---|---|
| Re-passing all fields | The client must know every field of the object — tightly coupled to internals |
| Silent field omission | If a new field is added to `Circle`, every copy callsite can silently forget it |
| Shared references | Naively assigning `coordinates: original.coordinates` shares the list — mutating the copy mutates the original |
| Expensive re-initialisation | Some fields require heavy computation; reconstructing from scratch wastes work |

> **OOP Problem (Encapsulation):** The client reaches inside `Circle` to pull out every field for copying — it knows too much about the object's internals.
>
> **SOLID Problem (OCP):** Adding a new field to `Circle` requires finding and updating every copy callsite across the codebase.
>
> **SOLID Problem (SRP):** The client is doing two jobs — using the shape AND knowing how to reproduce it faithfully.

---

## The Solution — Prototype Pattern

We give each class a `clone()` method. The class itself knows how to copy all its fields correctly — including deep-copying collections. The client just calls `clone()` and gets an independent copy, no field knowledge required.

| Role | In Our Example | What it does |
|---|---|---|
| **Prototype** (interface) | `Shape` | Declares `clone()` — all shapes must be cloneable |
| **Concrete Prototype** | `Circle`, `Rectangle` | Implements `clone()` — copies all fields, including deep copies of collections |
| **Client** | `main()` | Calls `original.clone()` — never touches the constructor directly |

---

## Steps We Followed

### Step 1 — Create the Prototype interface

```dart
abstract class Shape {
  String color;

  Shape(this.color);

  Shape clone();
}
```

> Every shape must be able to produce a copy of itself. The client only ever calls this one method.

---

### Step 2 — Implement Concrete Prototypes

```dart
class Circle extends Shape {
  double radius;
  List<double> coordinates;

  Circle({
    required this.radius,
    required String color,
    required this.coordinates,
  }) : super(color);

  Circle._copy(Circle source)
      : radius = source.radius,
        coordinates = List.from(source.coordinates), // deep copy — independent list
        super(source.color);

  @override
  Circle clone() => Circle._copy(this);
}

class Rectangle extends Shape {
  double width;
  double height;
  List<double> coordinates;

  Rectangle({
    required this.width,
    required this.height,
    required String color,
    required this.coordinates,
  }) : super(color);

  Rectangle._copy(Rectangle source)
      : width = source.width,
        height = source.height,
        coordinates = List.from(source.coordinates),
        super(source.color);

  @override
  Rectangle clone() => Rectangle._copy(this);
}
```

> The private copy constructor (`._copy`) handles all the field-by-field copying in one place. `List.from()` ensures the coordinates list is independent — changes to the copy do not affect the original.

---

### Step 3 — Use clone() in the client

```dart
void main() {
  final Circle original = Circle(
    radius: 10,
    color: 'red',
    coordinates: [1.0, 2.0, 3.0],
  );

  // Clone and override only what changes — no knowledge of internals needed
  final Circle blueCircle = original.clone()..color = 'blue';
  final Circle biggerCircle = original.clone()..radius = 20;

  print(original.color);     // red
  print(blueCircle.color);   // blue
  print(biggerCircle.radius); // 20.0
  print(original.radius);    // 10.0 — original untouched
}
```

> The client clones and then overrides only the fields it cares about. It never has to know about `coordinates` or any other internal field.

---

### Step 4 — Works polymorphically

```dart
void duplicateAll(List<Shape> shapes) {
  final copies = shapes.map((s) => s.clone()).toList();
  // Each shape knows how to clone itself — the loop doesn't care if it's Circle or Rectangle
}
```

> Because `clone()` is on the `Shape` interface, you can clone any shape without knowing its concrete type.

---

## Before vs After

| | Without Pattern | With Prototype Pattern |
|---|---|---|
| Copying an object | Client re-passes every field to the constructor | Client calls `clone()` — one method |
| Field changes | Every copy callsite must be updated | Only the `clone()` method inside the class changes |
| Deep copy safety | Client must remember to deep-copy collections manually | The class handles it in `_copy` — guaranteed correct |
| Expensive re-initialisation | All fields recomputed from scratch | Clone copies the already-computed state |
| Polymorphic copying | Impossible — must know the concrete type to call the right constructor | `shape.clone()` works regardless of the concrete type |

---

## Key Insight

The Prototype Pattern moves the knowledge of how to copy an object from the caller into the object itself. The class owns its own reproduction logic, just like it owns its construction and its behaviour. This means adding a new field is a one-place change: update the class and its `clone()` method — nowhere else.

It also solves the shallow-copy trap: because the class controls copying, it decides which fields need deep copies and handles it correctly every time. Callers get an independent object without thinking about it.

---

## Real-World Examples

- **Shape editors** (Figma, Sketch) — Duplicate a complex grouped shape. All children, styles, and transforms are deep-copied. The user just hits Cmd+D.
- **Game engines** — Spawn enemy units by cloning a pre-configured prototype instead of rebuilding the full object graph each time.
- **Caching** — Return a clone of a cached object so callers can modify their copy without corrupting the cache.
- **Configuration templates** — Clone a base configuration and override only the environment-specific values.
- **Undo stacks** — Snapshot the current state by cloning the model before each mutation. Undo = restore the previous clone.

---

## When to Use Prototype

| Need | Example |
|---|---|
| Creating a new object is expensive | Object requires heavy computation or I/O to initialise |
| You want copies that differ in only a few fields | Shapes of the same size in different colours |
| The client should not know the object's concrete class | `shape.clone()` works on `Circle` and `Rectangle` without a type check |
| Deep copying is complex and should live in one place | Collections and nested objects must be copied carefully |
| You need runtime object templates | A "base enemy" prototype cloned and tweaked for each spawn |
