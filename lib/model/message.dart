class ListConversationModel {
  final int id;
  final String name;
  final String body;
  final String date;

  ListConversationModel(
    this.id,
    this.name,
    this.body,
    this.date,
  );
}

class MessageTemplate {
  int id;
  String message;

  MessageTemplate(
    this.id,
    this.message,
  );
}

