import 'chat_mediator.dart';
import 'chat_room.dart';
import 'chat_user.dart';

void main() {
  ChatMediator chatRoom = ChatRoom();
  ChatUser mishad = ChatUser('Mishad', chatRoom);
  ChatUser mahbub = ChatUser('Mahbub', chatRoom);
  ChatUser amit = ChatUser('Amit', chatRoom);
  ChatUser neha = ChatUser('Neha', chatRoom);
  chatRoom.addUser(mishad);
  chatRoom.addUser(mahbub);
  chatRoom.addUser(amit);
  chatRoom.addUser(neha);

  chatRoom.sendMessage('Hello', mishad);
}


/*
● Reduces Complexity: The mediator centralizes communication, reducing direct dependencies
between objects.
● Loose Coupling: Colleagues only interact with the mediator, making them easier to manage,
extend, and maintain.
● Single Responsibility: The mediator handles complex communication logic, allowing colleagues
to focus on their own behavior.
● Centralized Control: Changes to communication rules can be made in the mediator without
affecting the colleagues.


Air Traffic Control:
Airplanes communicate through a central control tower (mediator) instead of coordinating directly
with each other.
GUI Component Coordination:
In GUI applications, multiple UI components may need to interact. For example, when a dropdown
changes, it may trigger updates to text fields, buttons, etc. A mediator can handle this interaction
logic instead of having the components know about each other directly.
Workflow Systems:
In a business process management system, a mediator can coordinate various activities across
multiple systems or departments.
 */