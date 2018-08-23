import 'dart:async';
import 'package:flutter_lyc/ui/chat/data/message.dart';
import 'package:flutter_lyc/ui/chat/data/chat.dart';

abstract class ChatRepository {
  Future<Chat> getChatHistory(String accessCode);

  Future<Chat> getMoreChatHistory(String accessCode, int page);

  Future<Message> sendMessage(String accessCode, String mesg, int articleId,
      int doctorId, int serviceId);

  Future<Message> sendImage(String accessCode, String filePath, int articleId,
      int doctorId, int serviceId);

  void sendChatSection(String accessCode, int chatSession);

  void updateReadStatus(String accessCode, int messageId);
}
