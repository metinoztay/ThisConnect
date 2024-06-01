class Message {
  final String? id;
  final String chatRoomId;
  final String senderUserId;
  final String receiverUserId;
  final String? content;
  final DateTime createdAt;

  const Message({
    this.id,
    required this.chatRoomId,
    required this.senderUserId,
    required this.receiverUserId,
    this.content,
    required this.createdAt,
  });
}
