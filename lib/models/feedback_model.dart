import 'package:demo_riverpod/providers/feedback_provider.dart';

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

extension FeedbackModelX on FeedbackModel {
  FeedbackMode get feedbackMode {
    switch (category.toLowerCase()) {
      case 'work':
        return FeedbackMode.work;
      case 'culture':
        return FeedbackMode.culture;
      case 'management':
        return FeedbackMode.management;
      default:
        return FeedbackMode.all;
    }
  }

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hr ago';
    } else {
      return '${diff.inDays} day ago';
    }
  }
}
