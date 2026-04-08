# Command Pattern

## What is it?

Think of it like a **restaurant order slip**.

When you order food, the waiter does not walk into the kitchen and cook it themselves. They write your order on a slip and hand it to the chef. The slip is the command. The waiter does not need to know how to cook — they just pass the slip. The chef does not need to talk to you — they just read the slip.

- The **waiter** = Invoker (triggers the command)
- The **order slip** = Command (wraps the action)
- The **chef** = Receiver (does the actual work)

The Command Pattern wraps a request into an object so the invoker and receiver never need to know about each other.

## Structure

- **Command:** Interface for executing operations.
- **Concrete Command:** Implements the Command interface, wraps a receiver and calls its method.
- **Receiver:** The object that performs the actual work.
- **Invoker:** Sends the command — holds a Command and calls `execute()`.

---

## The Problem

We had two examples showing the same issue.

### Example 1 — Text Editor Buttons

Each button class was directly coupled to `TextEditor`:

```dart
class BoldButton {
  late TextEditor textEditor;

  void click() {
    textEditor.boldText(); // directly calls a specific method
  }
}

class ItalicizeButton {
  late TextEditor textEditor;

  void click() {
    textEditor.italicizeText(); // different button, same tight coupling
  }
}
```

Every button knows about `TextEditor` and calls a specific method. You need a separate button class for every action. 3 actions = 3 button classes.

```
graph TD
    BB["Bold Button"]
    IB["Italicize Button"]
    UB["Underline Button"]
    TE["Text Editor"]
    BB -- calls boldText --> TE
    IB -- calls italicizeText --> TE
    UB -- calls underlineText --> TE
```

### Example 2 — Smart Home Remote

The remote control was directly coupled to `Light`:

```dart
class RemoteControl {
  late Light light; // tightly tied to one specific device

  void pressOnButton() {
    light.turnOn(); // hardcoded — only works for Light
  }

  void pressOffButton() {
    light.turnOff();
  }
}
```

Want to control a `Fan` or `AC`? You must rewrite `RemoteControl`. It can never work generically.

```
graph TD
    RC["Remote Control"]
    L["Light"]
    RC -- calls turnOn/turnOff --> L
```

**What goes wrong in both cases?**

| Problem | Why it hurts |
|---|---|
| Invoker knows the receiver | Button knows `TextEditor`. Remote knows `Light`. They are tightly coupled |
| Adding a new action | You must create a new button class or modify the remote |
| Cannot reuse the invoker | `BoldButton` only ever bolds text. `RemoteControl` only ever controls a light |

> **OOP Problem (Coupling):** The invoker directly holds and calls the receiver — they are stuck together. Changing one means changing the other.
>
> **SOLID Problem (OCP):** Adding a new action requires opening and modifying the invoker class.
>
> **SOLID Problem (SRP):** The invoker is doing two jobs — deciding what to do AND triggering it.

---

## The Solution — Command Pattern

We introduce a `Command` interface with one method: `execute()`. Each action becomes its own class that implements this interface. The invoker holds a `Command` and just calls `execute()` — it never knows what happens inside.

| Role | Example 1 | Example 2 | What it does |
|---|---|---|---|
| **Command** (interface) | `Command` | `Command` | Defines the `execute()` contract |
| **Concrete Command** | `BoldCommand`, `ItalicizeCommand` | `TurnOnLightCommand` | Wraps a receiver + one specific action |
| **Receiver** | `TextEditor` | `Light` | The object that actually does the work |
| **Invoker** | `Button` | `RemoteControl` | Holds a command and calls `execute()` — knows nothing else |

---

## Steps We Followed

### Step 1 — Create the Command interface

```dart
abstract class Command {
  void execute();
}
```

> One method. Any action in the system must fit this shape.

---

### Step 2 — Create Concrete Commands

Each action becomes its own class. It holds a reference to the receiver and calls the right method.

```dart
class BoldCommand implements Command {
  final TextEditor textEditor;
  BoldCommand(this.textEditor);

  @override
  void execute() {
    textEditor.boldText(); // delegates to the receiver
  }
}

class ItalicizeCommand implements Command {
  final TextEditor textEditor;
  ItalicizeCommand(this.textEditor);

  @override
  void execute() {
    textEditor.italicizeText();
  }
}
```

> Each command wraps exactly one action. Adding a new action = adding a new class. Nothing else changes.

---

### Step 3 — Simplify the Invoker

Now there is only **one** `Button` class. It holds any `Command` and calls `execute()`.

```dart
class Button {
  Command? command;

  void setCommand(Command command) {
    this.command = command;
  }

  void click() {
    command?.execute(); // triggers — never knows what happens
  }
}
```

> `Button` no longer knows about `TextEditor`, `boldText()`, or anything else. It just calls `execute()`.

---

### Step 4 — Wire it together

```dart
TextEditor textEditor = TextEditor();

final boldButton = Button();
boldButton.setCommand(BoldCommand(textEditor));
boldButton.click(); // Text has been bolded.

final italicizeButton = Button();
italicizeButton.setCommand(ItalicizeCommand(textEditor));
italicizeButton.click(); // Text has been italicized.
```

One `Button` class handles every action. Swap the command, get different behavior.

---

## Example 2 — Remote Control (Smart Home)

The same idea applied to a remote:

```dart
abstract class Command {
  void execute();
}

class TurnOnLightCommand implements Command {
  final Light light;
  TurnOnLightCommand(this.light);

  @override
  void execute() {
    light.turnOn(); // delegates to Light
  }
}

class RemoteControl {
  Command? command;

  void setCommand(Command command) {
    this.command = command;
  }

  void pressButton() {
    command?.execute(); // generic — works for any command
  }
}
```

```dart
final light = Light();
final remote = RemoteControl();

remote.setCommand(TurnOnLightCommand(light));
remote.pressButton(); // Light is ON

remote.setCommand(TurnOffLightCommand(light));
remote.pressButton(); // Light is OFF
```

Want to control a `Fan` instead? Create `TurnOnFanCommand`. The remote code does not change at all.

---

## Before vs After

| | Without Pattern | With Command Pattern |
|---|---|---|
| Adding a new action | New button class + hardcoded method call | New command class only |
| Invoker knows about | The specific receiver and its methods | Only the `Command` interface |
| One invoker, many actions? | Impossible — each invoker is locked to one action | Yes — just `setCommand()` with a different command |
| Undo support | Very hard — invoker has no memory | Easy — commands can store state and have `undo()` |

---

## Key Insight

The command object is the bridge between the invoker and the receiver. Neither side needs to know the other exists. The invoker just calls `execute()`. The receiver just runs its method. The command object sits in the middle and connects them.

This is why you can queue commands, log them, delay them, or undo them — because the action is now a proper object, not just a method call.

---

## Real-World Examples

- **UI Buttons / Keyboard Shortcuts** — A button is an invoker. Ctrl+Z is an invoker. They each hold a command. The same Undo command can be triggered by either.
- **Smart Home Apps** — A remote or app holds commands for lights, fans, AC. Adding a new device = adding a new command class.
- **Task Queues / Job Schedulers** — Jobs are commands. They are queued, delayed, and executed later.
- **Undo/Redo in Editors** — Each action (type, delete, format) is a command stored in a history list. Undo = call the last command's `undo()`.
- **Macros** — A macro is a list of commands executed one after another.

---

## When to Use Command

| Need | Example |
|---|---|
| Decouple sender from receiver | Button should not know about TextEditor internals |
| One invoker that handles many actions | One `Button` class, many command objects |
| Undo / Redo | Store executed commands and reverse them |
| Queue or delay actions | Add commands to a queue, run later |
| Logging actions | Log every command that was executed |
