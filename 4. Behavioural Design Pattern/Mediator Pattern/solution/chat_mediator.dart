import 'chat_user.dart';

abstract class ChatMediator {
  void sendMessage(String message, ChatUser user);
  void addUser(ChatUser user);
}
