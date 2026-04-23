//Chat System

class User {
  String _name;
  User(this._name);

  void sendMessage(String msg, User recipent) {
    print('${this._name} is sending $msg to ${recipent._name}');
  }

  String getName() {
    return _name;
  }
}

void main() {
  User mishad = User('Mishad');
  User mahbub = User('Mahbub');
  User amit = User('Amit');
  User neha = User('Neha');

  mishad.sendMessage('hello', mahbub);
  mishad.sendMessage('Hello', neha);
}

/*
Problems with Code
● As more users are added, each user needs to manage direct communication
with all others, leading to high coupling.
● If a new communication rule is introduced (e.g., message logging), it would
need to be added to all users.


Problem: Objects in a system need to communicate, but direct communication leads to tight
coupling and complexity.
Solution: The Mediator Pattern introduces a mediator object that handles all
communication between objects, reducing direct dependencies and coupling.
In our chat app, by introducing a Mediator object, we will decouple the users from knowing
about each other directly. The Mediator handles all communication, and the users
(colleagues) only interact with the Mediator. This simplifies the interaction and reduces
dependencies.
 */
