import 'dart:async';
import 'dart:math';

import 'package:chat/models/chat_user.dart';
import 'package:chat/models/chat_message.dart';
import 'package:chat/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      Random().nextDouble().toString(),
      text,
      DateTime.now(),
      user.id,
      user.name,
      user.imageURL,
    );
    _msgs.add(newMessage);
    _controller?.add(_msgs.reversed.toList());

    return newMessage;
  }
}
