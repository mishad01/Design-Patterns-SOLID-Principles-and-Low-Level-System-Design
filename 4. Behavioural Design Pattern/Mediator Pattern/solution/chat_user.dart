import 'chat_mediator.dart';

class ChatUser {
  String _name;
  ChatMediator chatMediator;
  ChatUser(this._name, this.chatMediator);

  void sendMessage(String message) {
    chatMediator.sendMessage(message, this);
  }

  String getName() {
    return _name;
  }

  void recieveMessage(String msg) {
    print('${this._name} recived message: $msg ');
  }
}
