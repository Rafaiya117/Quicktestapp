class FeedbackModel {
  final String id;
  final String teamId;
  final String category;
  final String message;
  final DateTime createdAt;

  FeedbackModel({
    required this.id,
    required this.teamId,
    required this.category,
    required this.message,
    required this.createdAt,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'],
      teamId: json['team_id'],
      category: json['category'] ?? 'Other',
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'team_id': teamId,
    'category': category,
    'message': message,
    'created_at': createdAt.toIso8601String(),
  };
}