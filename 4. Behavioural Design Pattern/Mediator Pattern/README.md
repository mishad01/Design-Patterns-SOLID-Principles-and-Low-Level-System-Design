# Mediator Pattern

## What is it?

Think of it like an **air traffic controller at an airport**.

Planes do not talk directly to each other — that would be chaotic. Instead, every plane communicates through the control tower. The tower knows all the planes in the air, decides who goes where, and broadcasts instructions. Each plane only ever talks to the tower, never to other planes directly.

- The **control tower** = Concrete Mediator (`ChatRoom` — knows all participants, routes messages)
- The **planes** = Colleagues (`ChatUser` — only knows the mediator, never other users directly)
- The **protocol** = Mediator interface (`ChatMediator` — declares the contract for communication)

The Mediator Pattern defines an object that encapsulates how a set of objects interact. It promotes loose coupling by keeping objects from referring to each other explicitly, letting you vary their interactions independently.

## Structure

- **Mediator (interface):** Declares the communication methods concrete mediators must implement.
- **Concrete Mediator:** Implements communication logic — knows and coordinates all colleague objects.
- **Colleague:** Each object that communicates through the mediator. Holds a reference to the mediator but never to other colleagues.

---

## The Problem

```dart
class User {
  String _name;
  User(this._name);

  void sendMessage(String msg, User recipient) {
    print('${_name} is sending $msg to ${recipient._name}');
  }

  String getName() => _name;
}

void main() {
  User mishad = User('Mishad');
  User mahbub = User('Mahbub');
  User neha   = User('Neha');

  mishad.sendMessage('hello', mahbub);
  mishad.sendMessage('Hello', neha);
}
```

```
graph TD
    M["Mishad (User)"]
    MB["Mahbub (User)"]
    AM["Amit (User)"]
    N["Neha (User)"]
    M -- message --> MB
    M -- message --> AM
    M -- message --> N
    MB -- message --> AM
    MB -- message --> N
    AM -- message --> N
```

**What goes wrong:**

| Problem | Why it hurts |
|---|---|
| High coupling | Every user must know about every other user — O(n²) connections |
| OCP violated | Adding a new rule (e.g., message logging) requires modifying every `User` |
| SRP violated | `User` handles both its own logic AND knowing every other user's identity |
| Scalability | Each new user multiplies the number of direct connections |

> **OOP Problem (Encapsulation):** Communication logic (who talks to whom, routing, filtering) is scattered across every `User` instead of being owned by one central place.
>
> **SOLID Problem (OCP):** Adding a broadcast feature or logging requires opening and modifying every `User` class.
>
> **SOLID Problem (SRP):** `User` manages its own behaviour AND knows about all other users — two separate responsibilities.

---

## The Solution — Mediator Pattern

We introduce `ChatRoom` as the central hub. Users only know the mediator — never each other. When a user sends a message, they hand it to the mediator, which decides how to distribute it.

| Role | In Our Example | What it does |
|---|---|---|
| **Mediator** (interface) | `ChatMediator` | Declares `sendMessage()` and `addUser()` |
| **Concrete Mediator** | `ChatRoom` | Maintains the user list, routes messages to all participants |
| **Colleague** | `ChatUser` | Sends and receives via the mediator — no direct user references |
| **Client** | `main()` | Creates the room, registers users, triggers sends |

---

## Steps We Followed

### Step 1 — Create the Mediator interface

```dart
abstract class ChatMediator {
  void sendMessage(String message, ChatUser user);
  void addUser(ChatUser user);
}
```

> Defines the contract that `ChatRoom` must fulfil. `ChatUser` only ever holds a reference to this interface — never to a concrete mediator directly.

---

### Step 2 — Create the Concrete Mediator

```dart
class ChatRoom extends ChatMediator {
  List<ChatUser> _users = [];

  @override
  void addUser(ChatUser user) {
    _users.add(user);
  }

  @override
  void sendMessage(String message, ChatUser sender) {
    for (final user in _users) {
      user.recieveMessage(message);
    }
  }
}
```

> All routing logic lives here. Want to skip the sender? Add logging? Only this class changes.

---

### Step 3 — Create the Colleague

```dart
class ChatUser {
  String _name;
  ChatMediator chatMediator;

  ChatUser(this._name, this.chatMediator);

  void sendMessage(String message) {
    chatMediator.sendMessage(message, this);
  }

  String getName() => _name;

  void recieveMessage(String msg) {
    print('$_name recived message: $msg');
  }
}
```

> `ChatUser` holds only a `ChatMediator` reference. It has zero knowledge of other users.

---

### Step 4 — Use in the client

```dart
ChatMediator chatRoom = ChatRoom();
ChatUser mishad = ChatUser('Mishad', chatRoom);
ChatUser mahbub = ChatUser('Mahbub', chatRoom);
ChatUser amit   = ChatUser('Amit', chatRoom);
ChatUser neha   = ChatUser('Neha', chatRoom);

chatRoom.addUser(mishad);
chatRoom.addUser(mahbub);
chatRoom.addUser(amit);
chatRoom.addUser(neha);

chatRoom.sendMessage('Hello everyone!', mishad);
```

---

## Before vs After

| | Without Pattern | With Mediator Pattern |
|---|---|---|
| Communication path | User → User (n² connections) | User → Mediator → Users (n connections) |
| Adding a new rule | Modify every `User` class | Modify only `ChatRoom` |
| Coupling | Every user knows every user | Every user knows only the mediator |
| OCP compliance | Violated — must touch every user | Respected — extend mediator only |
| SRP compliance | Violated — user manages routing | Respected — mediator owns routing |

---

## Key Insight

The Mediator Pattern replaces a tangled web of direct object-to-object references with a single hub. Objects stop knowing about each other and start knowing only one thing — their mediator. The mediator owns all the interaction complexity so colleagues stay simple.

This is the difference between n² direct connections and n connections through one well-defined point.

---

## Real-World Examples

- **Air traffic control** — Planes talk to the tower, not to each other.
- **Chat applications** — Users send to a room/server which distributes to all participants.
- **GUI event systems** — A form mediates interactions between buttons, text fields, and dropdowns so components don't wire directly to each other.
- **Stock trading systems** — A broker (mediator) matches buyers and sellers without them knowing each other.
- **Workflow engines** — A central coordinator routes tasks between departments.

---

## When to Use Mediator

| Need | Example |
|---|---|
| Many objects communicate in complex ways | Chat room, event bus, trading system |
| Reusing an object is hard because it references too many others | UI component wired to every other component |
| Communication rules change frequently | Logging, routing, filtering rules |
| Decoupling leads to cleaner, testable colleagues | Test `ChatUser` without any other user present |