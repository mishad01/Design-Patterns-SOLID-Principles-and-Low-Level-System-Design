import 'chat_mediator.dart';
import 'chat_user.dart';

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
