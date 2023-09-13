class ListConversationModel {
  final int id;
  final int user_id;
  final int second_user_id;
  final String user1;
  final String user2;
  final String body;
  final String date;

  ListConversationModel(
    this.id,
    this.user_id,
    this.second_user_id,
    this.user1,
    this.user2,
    this.body,
    this.date,
  );
}

class Messages {
  final int id;
  final String body;
  final String date;
  final int read;
  final int user_id;
  final int conversation_id;

  Messages(
    this.id,
    this.body,
    this.date,
    this.read,
    this.user_id,
    this.conversation_id,
  );
}


