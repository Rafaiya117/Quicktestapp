import 'package:demo_riverpod/providers/feedback_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardStatsProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, teamId) async {
  final feedbackList = await ref.read(feedbackServiceProvider).getAllFeedback(teamId);

  final Map<String, int> categoryCount = {};

  for (final item in feedbackList) {
    categoryCount[item.category] = (categoryCount[item.category] ?? 0) + 1;
  }

  return {
    'total': feedbackList.length,
    'categories': categoryCount,
  };
});