class CardRequest {
  int userId;
  String cardType;
  List<String> documents;

  CardRequest({
    required this.userId,
    required this.cardType,
    required this.documents,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'card_type': cardType,
      'documents': documents,
    };
  }
}
