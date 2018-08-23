import 'package:flutter_lyc/ui/chat/data/message.dart';
import 'package:flutter_lyc/base/data/pagination.dart';

abstract class ChatContract {
  void showChatHistory(List<Message> m);

  void showMoreChatHistroy(List<Message> m);

  void showNewMessage(Message m);

  void showErrorChat(String mesg);

  void showMessage(String message);

  void showCamera();

  void showGallery();

  void showSendButton();

  void hideSendButton();

  void showDialog();

  void hideDialog();

  void setPagination(Pagination p);
}
