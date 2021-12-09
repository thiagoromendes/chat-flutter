class ChatMessage {
  final String id;
  final String text;
  final DateTime createdAt;
  final String userId;
  final String userName;
  final String userImageURL;

  const ChatMessage(
    this.id,
    this.text,
    this.createdAt,
    this.userId,
    this.userName,
    this.userImageURL,
  );
}
