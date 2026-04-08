# Memento Pattern

## What is the Memento Pattern?

Think of it like the **undo button** in any app (like Google Docs or VS Code).

When you press Ctrl+Z, the app goes back to what it was before. How does it do that?
It secretly saved a copy of the old state. That saved copy is called a **Memento**.

---

## The Problem

> **OOP Problem:** Encapsulation is broken — to save state externally, you'd have to expose the editor's internal fields, violating the principle that an object controls its own data.
>
> **SOLID Problem (SRP):** If the editor also managed its own undo history, it would have two responsibilities: editing text *and* tracking history. These should be separate concerns.

We had a simple text editor:

```dart
editor.write("Hello World");
editor.write("Hello everyone");
// Oh no! I want to undo the last write — but I can't!
print(editor.getContent()); // prints: Hello everyone
```

Once you write new content, the old content is **gone forever**.
There was no way to go back. No undo. No history.

---

## The Solution — Memento Pattern

We introduced 3 things to fix this:

| Class | Role | Simple way to think of it |
|---|---|---|
| `EditorMemento` | Stores a snapshot | A photo of the editor at one moment |
| `TextEditor` | The editor itself | Knows how to take a photo and restore from one |
| `CateTaker` | Manages the history | A photo album that stores all past photos |

---

## Steps We Followed

### Step 1 — Create the Memento (the snapshot)

We created `EditorMemento`. It is just a simple box that holds the content of the editor at a specific moment.

```dart
class EditorMemento {
  String content;
  EditorMemento(this.content);
  String getContent() => content;
}
```

> Think of it as a sticky note with the old text written on it.

---

### Step 2 — Teach the Editor to save and restore

We added two methods to `TextEditor`:

- `save()` — takes a snapshot and returns a Memento
- `restore(memento)` — takes a Memento and puts that old content back

```dart
EditorMemento save() {
  return EditorMemento(content!); // take a photo
}

void restore(EditorMemento memento) {
  content = memento.getContent(); // put the old photo back
}
```

---

### Step 3 — Create the Caretaker (the history manager)

We created `CateTaker`. It keeps a **stack** (like a pile) of saved states.

- `saveState(editor)` — pushes a new snapshot onto the pile
- `undo(editor)` — removes the latest snapshot and restores the one before it

```dart
void saveState(TextEditor editor) {
  history.push(editor.save());
}

void undo(TextEditor editor) {
  if (!history.isEmpty) {
    history.pop();          // remove the most recent snapshot
    editor.restore(history.top); // go back to the one before it
  }
}
```

> Think of it as a stack of sticky notes. Undo = throw away the top note and read the one below it.

---

### Step 4 — Wire it all together

```dart
TextEditor editor = TextEditor();
CateTaker cateTaker = CateTaker();

editor.write("Hello World");
cateTaker.saveState(editor);    // save snapshot 1: "Hello World"

editor.write("Hello everyone");
cateTaker.saveState(editor);    // save snapshot 2: "Hello everyone"

cateTaker.undo(editor);         // go back to snapshot 1
print(editor.getContent());     // prints: Hello World
```

---

## How the Stack Works (Visual)

```
After writing "Hello World" and saving:
  Stack: [ "Hello World" ]

After writing "Hello everyone" and saving:
  Stack: [ "Hello World", "Hello everyone" ]

After undo():
  → pop "Hello everyone"   (remove top)
  → restore "Hello World"  (look at new top)
  Stack: [ "Hello World" ]
```

---

## Key Takeaway

| Before (Problem) | After (Solution) |
|---|---|
| Writing new text destroys old text | Old text is saved as a snapshot |
| No undo | Undo restores the previous snapshot |
| Editor knows everything | Each class has one job (Single Responsibility) |

The Memento Pattern solves undo by **saving snapshots of state** without exposing the internal details of the object.

---

## Where Else Is This Pattern Used?

The text editor is just one example. Any time you need to **save state and go back to it**, Memento is the right pattern.

### 1. Game Save / Checkpoint
You reach a checkpoint in a game. The game saves your character's health, position, and score.
If you die, it restores you to that checkpoint — not the very beginning.

```dart
game.reachCheckpoint();
cateTaker.saveState(game);  // save: health=100, level=3, score=500

// player dies...

cateTaker.undo(game);       // restore: health=100, level=3, score=500
```

---

### 2. Settings Screen with a Cancel Button
User opens Settings and changes some values. If they press **Cancel**, all changes are thrown away and the old settings come back.

```dart
cateTaker.saveState(settings);   // save before user starts editing

settings.setTheme("dark");
settings.setFontSize(20);

// user presses Cancel...

cateTaker.undo(settings);        // restore original settings
```

---

### 3. Multi-Step Form (Wizard)
A form has 3 steps. The user fills step 1, moves to step 2, then wants to go back and change step 1.
Each step's data was saved as a snapshot so going back is easy.

```dart
cateTaker.saveState(form);   // save step 1 data
form.goToStep(2);

// user clicks "Back"...

cateTaker.undo(form);        // restore step 1 data
```

---

### 4. Drawing / Photo Editor
Every brush stroke in Photoshop is saved. Pressing Ctrl+Z undoes the last stroke by restoring the previous snapshot of the canvas.

---

## The Rule of Thumb

Use Memento whenever you need any of these:

| Need | Example |
|---|---|
| Undo / Redo | Text editors, drawing apps |
| Rollback on failure | Database transactions |
| Cancel changes | Settings screen, dialogs |
| Checkpoints | Games, long-running processes |
| Go back in a flow | Multi-step forms, wizards |

The object being saved does not matter. What matters is: **save a snapshot now, restore it later**.
